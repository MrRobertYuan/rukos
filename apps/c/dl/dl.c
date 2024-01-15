/* Copyright (c) [2023] [Syswonder Community]
 *   [Ruxos] is licensed under Mulan PSL v2.
 *   You can use this software according to the terms and conditions of the Mulan PSL v2.
 *   You may obtain a copy of Mulan PSL v2 at:
 *               http://license.coscl.org.cn/MulanPSL2
 *   THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 *   See the Mulan PSL v2 for more details.
 */


#include <stdio.h>

extern int parse_elf();
extern int parse_elf_dyn();
extern int parse_elf_dyn_glibc();

int main(int argc, char** argv)
{
    puts("Hello, Ruxos dl!");
    printf("argc %d, argv %p\n", argc, argv);

    // parse_elf("/statichello");
    parse_elf_dyn("/dynamichello", argc, argv);
    // parse_elf_dyn_glibc("/dynamichello", argc, argv);

    return 0;
}
