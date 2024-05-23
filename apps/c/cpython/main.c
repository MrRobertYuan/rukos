#include <stdio.h>
#include <unistd.h>

int main(int argc, char** argv, char**envp) {
	// execv(argv[0], argv);
	printf("%d\n", argc);
	for(int i = 0; i < argc; ++i)
		printf("%s\n", argv[i]);
	execv(argv[0], argv);
	// execv(argv[1], argv+1);
	return 0;
}