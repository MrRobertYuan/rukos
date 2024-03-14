use core::ffi::c_char;

mod auxv;
mod load_elf;
mod stack;

use alloc::{ffi::CString, vec};

/// execve:
/// #include <unistd.h>
/// int execve(const char *pathname, char *const argv[], char *const envp[] );
pub fn sys_execve(pathname: usize, argv: usize, envp: usize) -> ! {
    use auxv::*;

    // info!("-----------------parse_elf_dyn-----------------------");
    // info!("file {}", vec_u8_to_str(&ptr2vec(filename)));
    // info!("argc {}", argc);

    let prog = load_elf::ElfProg::new(pathname as *const c_char);

    // get entry
    let mut entry = prog.entry;
    // info!("entry = 0x{:x}", entry);

    // if interp is needed
    // info!("interp {:p} ", prog.interp_path);
    let mut at_base = 0;
    if prog.interp_path as usize != 0 {
        let interp_prog = load_elf::ElfProg::new(prog.interp_path);
        entry = interp_prog.entry;
        at_base = interp_prog.base;
        axlog::ax_println!("INTERP base is {:x}", at_base);
    };

    // create stack
    let mut stack = stack::Stack::new();

    ax_println!("get stack");

    let name = prog.name;
    let platform = prog.platform;

    // non 8B info
    stack.push(vec![0u8; 32], 16);
    let p_progname = stack.push(name, 16);
    let p_plat = stack.push(platform, 16); // platform
    let p_rand = stack.push(prog.rand, 16); // rand

    // env
    // let mut env_vec = vec![];
    // for en in RUX_ENVIRON.iter() {
    //     // info!("env en {:p} {}", *en, vec_u8_to_str(&(ptr2vec(*en))));
    //     env_vec.push(*en as usize);
    // }
    // // RUX_ENVIRON has ended with NULL, no need to push NULL

    // // argv
    // let mut argv = vec![];
    // unsafe {
    //     for i in 0..argc {
    //         let arg = ptr2vec(*args.add(i as usize));
    //         let p_arg = stack.push(arg, 16);
    //         argv.push(p_arg);
    //     }
    // }
    // argv.push(0); // NULL

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

    ax_println!("creating env & arg's vec");

    let mut env_vec = vec![];
    let mut arg_vec = vec![];
    let mut argc = 0;

    let envp = envp as *const usize;
    unsafe {
        let mut i = 0;
        while *envp.add(i) != 0 {
            env_vec.push(*envp.add(i));
            i += 1;
        }
        env_vec.push(0);
    }

    ax_println!("env_vec ok");

    let argv = argv as *const usize;
    unsafe {
        let mut i = 0;
        loop {
            let p = *argv.add(i);
            if p == 0 {
                break;
            }
            arg_vec.push(p as usize);
            argc += 1;
            i += 1;
        }
        // while *argv.add(i) != 0 {
        //     let ptr = *argv.add(i) as *mut c_char;
        //     let val = CString::from_raw(ptr);
        //     ax_println!("{i}, arg {:?}", val);
        //     arg_vec.push(*argv.add(i));
        //     argc += 1;
        //     i += 1;
        // }
        arg_vec.push(0);
    }
    ax_println!("argvec ok");

    // push
    stack.push(auxv, 16);
    stack.push(env_vec, 8);
    stack.push(arg_vec, 8);
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
