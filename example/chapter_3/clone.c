#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <linux/sched.h>

int g = 2;

int sub_func(void *arg)
{
        g++;
        printf("pid<%d>: Child g= %d \n" ,getpid(),g);
        return 0;
}

int main(void)
{
        int pid;
        int child_stack[4096];
        int l = 3;
        printf("pid<%d>: Parent g = %d, l = %d \n", getpid(),g,l);
        clone(sub_func, (void*)(child_stack+4095), CLONE_VM | CLONE_THREAD | CLONE_SIGHAND,NULL);
        sleep(1);
        printf("pid<%d>: Parent g = %d, l = %d \n", getpid(),g,l);
        return 0;
}                                                                                            
