/* Copyright (c) [2023] [Syswonder Community]
 *   [Ruxos] is licensed under Mulan PSL v2.
 *   You can use this software according to the terms and conditions of the Mulan PSL v2.
 *   You may obtain a copy of Mulan PSL v2 at:
 *               http://license.coscl.org.cn/MulanPSL2
 *   THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A
 * PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
 */

#include <stdio.h>
#include <unistd.h>


int main(int argc, char **argv)
{
    puts("Hello, Ruxos dl!");
    printf("argc %d, argv %p\n", argc, argv);

    // int i = 0;
    for (int i = 0; i <= argc; i++) {
        printf("arg %d: %s\n", i, *(argv + i));
    }
    // printf("arg %d: %s\n", i, *(argv + i));

    char *app_path = argv[0];
    // printf("go\n");
    // execl(app_path, app_path, "--help", 0);
    execv(app_path, argv);


    return 0;
}
