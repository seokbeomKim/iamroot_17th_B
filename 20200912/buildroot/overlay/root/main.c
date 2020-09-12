#include <stdio.h>
#include <linux/unistd.h>

int main(void)
{
	printf("test syscall: %d\n", syscall(295));
	return 0;
}
