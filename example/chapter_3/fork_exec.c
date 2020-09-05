#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>


int main(void){
	pid_t pid;
	int exit_status;

	if((pid = fork()) < 0 ){
		perror("fork error");
		exit(1);
	}

	else if (pid ==0){
		printf("Hi\n");
		execl("./fork","fork", "-l",(char*)0);
		printf("DKU \n");
	} else {
		pid = wait(&exit_status);
	}


	return 0;
}

