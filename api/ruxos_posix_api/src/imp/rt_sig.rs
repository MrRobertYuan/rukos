/* Copyright (c) [2023] [Syswonder Community]
 *   [Ruxos] is licensed under Mulan PSL v2.
 *   You can use this software according to the terms and conditions of the Mulan PSL v2.
 *   You may obtain a copy of Mulan PSL v2 at:
 *               http://license.coscl.org.cn/MulanPSL2
 *   THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 *   See the Mulan PSL v2 for more details.
 */

//! Signal implementation, used by musl

use core::ffi::c_int;

use crate::ctypes;

/// Set mask for given thread
pub fn sys_rt_sigprocmask(
    flag: c_int,
    _new_mask: *const usize,
    _old_mask: *mut usize,
    sigsetsize: usize,
) -> c_int {
    debug!(
        "sys_rt_sigprocmask <= flag: {}, sigsetsize: {}",
        flag, sigsetsize
    );

    static mut MASK_TMP: usize = 0;

    let mut oldset = 0;
    if !_old_mask.is_null() {
        unsafe {
            *_old_mask = MASK_TMP;
            oldset = MASK_TMP;
        }
    }

    // 1111111111111111111111111111110001111111111111111111101100100111
    // 0000000000000000000000000000001100000000000000000000000000000000
    // 1111111111111111111111111111110001111111111111111111101100100111

    let set = if _new_mask.is_null() {
        usize::MAX
    } else {
        unsafe { *_new_mask }
    };

    unsafe {
        // match how
        match flag {
            // block
            0 => {} //  MASK_TMP |= set,
            // unblock
            1 => {
                if !_new_mask.is_null() {
                    MASK_TMP &= !set;
                }
            }
            // set mask
            2 => {
                if !_new_mask.is_null() {
                    MASK_TMP = set;
                }
            }
            _ => panic!(),
        }
    }

    info!(
        "sys_rt_sigprocmask: how {flag}, set {:b}, oldset {:b}",
        set, oldset
    );
    unsafe {
        core::arch::asm!("nop
        nop
        nop
        nop
        nop");
    }
    syscall_body!(sys_rt_sigprocmask, Ok(0))
}

/// sigaction syscall for A64 musl
pub fn sys_rt_sigaction(
    sig: c_int,
    _sa: *const ctypes::sigaction,
    _old: *mut ctypes::sigaction,
    _sigsetsize: ctypes::size_t,
) -> c_int {
    debug!("sys_rt_sigaction <= sig: {}", sig);
    unsafe {
        // let act = *_sa;
        // let oldact = *_old;

        // info!("-----------------------------------");
        // info!(
        //     "sys_rt_sigaction, sig {}, act flag {:b} {:x} oldact flag {:b} {:x} ",
        //     sig, act.sa_flags, act.sa_flags, oldact.sa_flags, oldact.sa_flags
        // );
        // let actp = &act;
        // let actp = actp as *const _ as *const u64; 
        // let handler_addr = *actp;
        // let handler_addr = handler_addr as *const u64;
        // info!("sys_rt_sigaction, act handler {:x?}",  *actp);
        // info!("sys_rt_sigaction, act handler content {:x?}",  *handler_addr);
        // info!("-----------------------------------");
    }
    syscall_body!(sys_rt_sigaction, Ok(0))
}
