#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>


int main(void){
	int pid;
	
	printf("before fork \n \n");

	if((pid = vfork()) < 0 ){
		perror("fork error");
		exit(-2);
	}
	else if (pid ==0){
		printf("TGID<%d>, PID<%ld>: Child \n" ,getpid(), syscall(__NR_gettid));
		exit(-2);
	} 	
	else {
		printf("TGID<%d>, PID<%ld>: Parent\n" ,getpid(), syscall(__NR_gettid));
		sleep(2);
	}
	printf("after fork\n\n");
	return 0;
}

