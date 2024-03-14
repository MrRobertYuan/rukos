use alloc::vec::Vec;
use core::{ffi::c_char, mem::size_of};
use crate::*; 

#[derive(Debug)]
pub struct ElfProg {
    pub name: Vec<u8>,
    pub path: Vec<u8>,
    pub platform: Vec<u8>,
    pub rand: Vec<u64>,
    pub base: usize,
    pub entry: usize,
    pub interp_path: *const c_char,
    pub phent: usize,
    pub phnum: usize,
    pub phdr: usize,
}

impl ElfProg {
    /// read elf from `path`, and copy LOAD segments to a alloacated memory
    ///
    /// and load interp, if needed.
    pub fn new(filepath: *const c_char) -> Self {
        let name = ptr2vec(filepath);
        let path = ptr2vec(filepath);
        // info!("---------------------------------");
        axlog::ax_println!("new elf prog: {}", vec_u8_to_str(&path));

        // open file
        let fd = sys_open(filepath, ctypes::O_RDWR as i32, 0);
        // info!("open file, fd {}", fd);

        // get file size
        let buf = sys_mmap(0 as *mut _, size_of::<ctypes::kstat>(), 0, 0, 0, 0);
        let bufsize = unsafe {
            sys_fstat(fd, buf);
            (*(buf as *const ctypes::kstat)).st_size as usize
        };
        sys_munmap(buf, size_of::<ctypes::kstat>());
        // info!("fize size {}", bufsize);

        // read file
        let buf = sys_mmap(0 as *mut _, bufsize, 0, 0, fd, 0);
        axlog::ax_println!("mmap to read file at {:p} size {:x}", buf, bufsize);
        sys_read(fd, buf, bufsize);
 
        // parse elf
        let slice = unsafe { core::slice::from_raw_parts_mut(buf as *mut u8, bufsize) };
        let file = elf::ElfBytes::<elf::endian::AnyEndian>::minimal_parse(slice).expect("Open test1");

        // get program's LOAD mem size
        let mut msize = 0;
        let segs = file.segments().unwrap();
        for seg in segs {
            if seg.p_type == elf::abi::PT_LOAD {
                msize += seg.p_memsz;
            }
        }
        // info!("msize = {}", msize);

        // mmap memory to copy LOAD segmeants
        let a = crate::sys_mmap(0 as *mut _, msize as usize, 0, 0, 0, 0);
        axlog::ax_println!("mmap to copy LOAD at {:p} size {:x}", a, msize);
        let base = a as usize;
        // info!("base = 0x{:x}", base);


        // copy LOAD segs into base
        for seg in segs {
            if seg.p_type == elf::abi::PT_LOAD {
                // info!("found LOAD: {:?}", seg);
                let data = file.segment_data(&seg).unwrap();
                let vaddr = seg.p_vaddr as usize + base;
                unsafe {
                    // info!("write to {:x} datalen = {:x}", vaddr, data.len());
                    let c = vaddr as *mut u8;
                    for i in 0..data.len() {
                        *(c.add(i)) = data[i];
                    }
                }
            }
        }

        // phdr
        let phdr = base + file.ehdr.e_phoff as usize;

        // get entry
        let entry = file.ehdr.e_entry as usize + base;
        // info!("entry = 0x{:x}", entry);

        // parse interpreter
        // #[allow(non_upper_case_globals)]
        // static static_libc_path: &str = "/lib/ld-musl-aarch64.so.1";
        let mut interp_path = 0 as *const c_char;
        for seg in file.segments().unwrap() {
            if seg.p_type == elf::abi::PT_INTERP {
                let data = file.segment_data(&seg).unwrap();
                // interp_path = static_libc_path.as_ptr() as *const c_char;
                interp_path = data.as_ptr() as *const c_char;
            }
        }

        for sec in file.section_header_by_name(".got").unwrap() {
            let addr = sec.sh_addr as usize + base;
            ax_println!("got vaddr = {:#X}", addr);
        }

        // return Self
        let mut platform = Vec::new();
        for c in b"aarch64" {
            platform.push(*c);
        }
        let ret = Self {
            base,
            entry,
            name,
            path,
            platform,
            rand: alloc::vec![1, 2],
            interp_path,
            phent: file.ehdr.e_phentsize as usize,
            phnum: file.ehdr.e_phnum as usize,
            phdr,
        };
        
        let text_off = file.section_header_by_name(".text").unwrap().unwrap().sh_offset;
        ax_println!("loaded ELF in 0x{:x}, .text is 0x{:x}", ret.base, ret.base + text_off as usize);

        // unmap file
        sys_munmap(buf, bufsize);
        ax_println!("unmap ELF file in memory at {:p} len {:x}", buf, bufsize);

        ret
    }
}

pub fn ptr2vec(s: *const c_char) -> Vec<u8> {
    if s as usize == 0 {
        return alloc::vec![];
    }
    let mut v = Vec::new();
    unsafe {
        let mut i = 0;
        while *s.add(i) != 0 {
            v.push(*s.add(i) as u8);
            i += 1;
        }
    }
    v
}

pub fn vec_u8_to_str<'a>(v: &'a Vec<u8>) -> &'a str {
    if v.len() == 0 {
        return "";
    }
    let a = v.as_slice();
    let s = core::str::from_utf8(a).unwrap();
    s
}
