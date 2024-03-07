use crate::dl::load_elf::ptr2vec;
use crate::dl::load_elf::vec_u8_to_str;

use super::auxv::*;
use super::stack;
use alloc::vec;
use alloc::vec::Vec;
use core::ffi::c_char;
use core::ffi::c_int;
use core::ffi::c_void;
use ruxos_posix_api::*;

#[no_mangle]
pub unsafe extern "C" fn parse_elf_dyn(
    filename: *const c_char,
    argc: c_int,
    args: *const *const c_char,
) {
    // info!("-----------------parse_elf_dyn-----------------------");
    // info!("file {}", vec_u8_to_str(&ptr2vec(filename)));
    // info!("argc {}", argc);

    let prog = super::load_elf::ElfProg::new(filename);

    // get entry
    let mut entry = prog.entry;
    // info!("entry = 0x{:x}", entry);

    // if interp is needed
    // info!("interp {:p} ", prog.interp_path);
    let mut at_base = 0;
    if prog.interp_path as usize != 0 {
        let interp_prog = super::load_elf::ElfProg::new(prog.interp_path);
        entry = interp_prog.entry;
        at_base = interp_prog.base;
        axlog::ax_println!("INTERP base is {:x}", at_base);
    };

    // create stack
    // FIXME: better stack. what about using old stack?
    let mut stack: stack::Stack = stack::Stack::new();

    let name = prog.name;
    let platform = prog.platform;

    // non 8B info
    stack.push(vec![0u8; 32], 16);
    let p_progname = stack.push(name, 16);
    let p_plat = stack.push(platform, 16); // platform
    let p_rand = stack.push(prog.rand, 16); // rand

    // env
    let mut env_vec = vec![];
    for en in RUX_ENVIRON.iter() {
        // info!("env en {:p} {}", *en, vec_u8_to_str(&(ptr2vec(*en))));
        env_vec.push(*en as usize);
    }
    // RUX_ENVIRON has ended with NULL, no need to push NULL

    // argv
    let mut argv = vec![];
    unsafe {
        for i in 0..argc {
            let arg = ptr2vec(*args.add(i as usize));
            let p_arg = stack.push(arg, 16);
            argv.push(p_arg);
        }
    }
    argv.push(0); // NULL

    // auxv
    // FIXME: vdso
    // FIXME: rand
    let auxv = vec![
        AT_PHDR,
        prog.phdr as usize,
        AT_PHNUM,
        prog.phnum as usize,
        AT_PHENT,
        prog.phent as usize,
        AT_BASE,
        at_base,
        AT_PAGESZ,
        0x1000,
        AT_HWCAP,
        0,
        AT_CLKTCK,
        100,
        AT_FLAGS,
        0,
        AT_ENTRY,
        prog.entry,
        AT_UID,
        1000,
        AT_EUID,
        1000,
        AT_EGID,
        1000,
        AT_GID,
        1000,
        AT_SECURE,
        0,
        AT_EXECFN,
        p_progname,
        AT_RANDOM,
        p_rand,
        AT_SYSINFO_EHDR,
        0,
        AT_IGNORE,
        0,
        AT_NULL,
        0,
    ];

    // push
    stack.push(auxv, 16);
    stack.push(env_vec, 8);
    stack.push(argv, 8);
    let sp = stack.push(vec![argc as usize], 8);


    // try run
    ax_println!(
        "run at entry 0x{entry:x}, then it will jump to 0x{:x} ",
        prog.entry
    );


    // `blr` or `bl`  
    unsafe {
        core::arch::asm!("
         mov sp, {}
         blr {}
     ",
        in(reg)sp,
        in(reg)entry,
        );
    }

    unreachable!("should not return");
}
