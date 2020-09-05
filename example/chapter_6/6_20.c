
#include “mystat.h”
#include<linux/unistd.h>

int main(int argc, char* argv[])
{
	int task_number;
	struct mystat* mybuf;
	if(argc != 2)
	{
		printf(“Usage : a.out pid\n”);
		exit(1);
	}
	task_number = atoi(argv[1]);
	mybuf = (char*)malloc(sizeof(struct mystat));
	if(mybuf = NULL)
		exit(1);
	syscall(326,task_number,mybuf);
	printf(“pid is %d \n”, (int)mybuf->pid);
	printf(“ppid is %d \n”, (int)mybuf->ppid);
	printf(“state is %d \n”, (int)mybuf->stat);
	printf(“Policy is %d \n”, (int)mybuf->policy);
	printf(“File count is %d \n”, (int)mybuf->open_files);
	printf(“Start time is %d \n”, (int)mybuf->starttime);
	return 0;
}


