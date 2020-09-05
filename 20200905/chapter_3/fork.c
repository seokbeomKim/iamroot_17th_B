#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int g = 2;

int main(void){
	pid_t pid;
	int l = 3;

	printf("pid<%d>: Parent g = %d, l = %d \n", getpid(),g,l);

	if((pid = fork()) < 0 ){
		perror("fork error");
		exit(1);
	}

	else if (pid ==0){
		g++;
		l++;
		printf("pid<%d>: Child \n" ,getpid());
	} else {
		printf("PID<%d>: Parent \n", getpid());
	}

	printf("PID <%d>: g = %d, l= %d \n",getpid(),g,l);

	return 0;
}

