use super::auxv::*;
use super::stack;

use alloc::vec;
use alloc::vec::Vec;

use core::ffi::c_char;

use crate::dl::load_elf::{ptr2vec, vec_u8_to_str};

#[no_mangle]
pub unsafe extern "C" fn parse_elf(filename: *const c_char) {
    info!("filename {:}", vec_u8_to_str(&ptr2vec(filename)));

    let prog = super::load_elf::ElfProg::new(filename);

    // get entry
    let entry = prog.entry;
    info!("entry = 0x{:x}", entry);

    // create stack
    let mut stack = stack::Stack::new();

    let name = prog.name;
    let platform = prog.platform;

    // non 8B info
    stack.push(vec![0u8; 32], 16);
    let p_progname = stack.push(name, 16);
    let p_plat = stack.push(platform, 16); // platform
    let p_rand = stack.push(prog.rand, 16); // rand

    // auxv
    // FIXME: vdso
    let auxv = vec![
        AT_PHDR, prog.phdr as usize, 
        AT_PHNUM, prog.phnum as usize,
        AT_PHENT, prog.phent as usize,
        AT_BASE, 0,
        AT_PAGESZ, 0x1000,
        AT_HWCAP, 0,
        AT_CLKTCK, 0x64,
        AT_FLAGS, 0,
        AT_ENTRY, prog.entry,
        AT_UID, 1000,
        AT_EUID, 1000,
        AT_EGID, 1000,
        AT_SECURE, 0,
        AT_EXECFN, p_progname,
        AT_RANDOM, p_rand,
        AT_SYSINFO_EHDR, 0, 
        AT_IGNORE, 0, 
        AT_NULL, 0, 
    ];
    stack.push(auxv, 16);

    // argc, argv, envp
    let args_envp = vec![
        1, 
        p_progname, 
        0, 
        0
    ];
    let sp = stack.push(args_envp, 8);
    info!("sp 0x{:x}", sp);

    // try run
    info!("run");
    unsafe {
        core::arch::asm!("
        mov sp, {}
        blr {}
    ",
        in(reg)sp,
        in(reg)prog.entry,
        );
    }

    unreachable!("should not return");
}
