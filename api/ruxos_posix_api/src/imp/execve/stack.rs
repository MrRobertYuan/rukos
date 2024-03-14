use core::mem::size_of;

use crate::*;

#[derive(Debug)]
pub struct Stack {
    sp: usize,
    start: usize,
    end: usize,
}

impl Stack {
    // alloc a 5-page stack
    pub fn new() -> Self {
        let size = 0x250000;
        let p = sys_mmap(0 as *mut _, size, 0, 0, 0, 0);

        let start = p as usize;
        let sp = start + size;
        let end = sp;

        let ret = Self { sp, start, end };
        // let mut sp = 0usize;
        // unsafe {
        //     core::arch::asm!("
        //     mov {} , sp 
        //     ", out(reg)sp);
        // }
        // assert_ne!(sp, 0);

        // let ret = Self {sp, start: 0 , end: 0};

        ax_println!("create stack {:#x?}", ret);

        ret 
    }

    pub fn align(&mut self, align: usize) -> usize {
        self.sp -= self.sp % align;
        self.sp
    }

    pub fn push<T: Copy>(&mut self, thing: alloc::vec::Vec<T>, align: usize) -> usize {
        let size = thing.len() * size_of::<T>();
        self.sp -= size;
        self.sp = self.align(align); // align 16B

        if self.sp < self.start {
            panic!("stack overflow");
        }

        let mut pt = self.sp as *mut T;
        unsafe {
            for t in thing {
                *pt = t;
                pt = pt.add(1);
            }
        }

        self.sp
    }

    // pub fn get_sp(&self) -> usize {
    //     self.sp
    // }
}

impl Drop for Stack {
    fn drop(&mut self) {
        ax_println!("stack release!");
        sys_munmap(self.start as *mut _, self.end - self.start);
    }
}
