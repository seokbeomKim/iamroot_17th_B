#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <linux/sched.h>

int g = 2;

void *t_function(void *data)
{
        int id;
	int i = 0;
	pthread_t t_id;
	id = *((int *)data);
	printf("TGID<%d>, PID<%ld>, pthread_self(%d): Child \n" ,getpid(), syscall(__NR_gettid),pthread_self());
	sleep(2);
        return (void *)(id*id);
}

int main(void)
{
        int pid,status;
        int a = 1;
	int b = 2;
	pthread_t p_thread[2];
	printf("before pthread_create\n\n");

	if((pid = pthread_create(&p_thread[0],NULL, t_function, (void*)&a)) < 0){
		perror("thread create error : ");
		exit(1);
	}

	if((pid = pthread_create(&p_thread[1],NULL, t_function, (void*)&a)) < 0){
		perror("thread create error : ");
		exit(2);
	}

	pthread_join(p_thread[0],(void **)&status);
	printf("pthread_join(%d) \n", status);
	pthread_join(p_thread[1],(void **)&status);
	printf("pthread_join(%d) \n", status);
	printf("TGID<%d>, PID<%ld>: Child \n" ,getpid(), syscall(__NR_gettid));
        return 0;
}                                                                                            
