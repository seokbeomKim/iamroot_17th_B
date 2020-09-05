#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <linux/sched.h>


int sub_func(void *arg)
{
    printf("TGID(%d), PID(%d): Child\n", getpid(), syscall(__NR_gettid));
    exit(0);
}

#define STACK_SIZE 16 * 1024
int main(void)
{
        int pid;
        int child_a_stack[STACK_SIZE], child_b_stack[STACK_SIZE];

        printf("before clone:\n");
        printf("TGID(%d), PID(%D): Parent\n", getpid(), syscall(__NR_gettid));


        clone(sub_func, (void*)(child_a_stack+2000), CLONE_CHILD_CLEARTID | CLONE_CHILD_SETTID, NULL);
        clone(sub_func, (void*)(child_b_stack+2000), CLONE_VM | CLONE_THREAD | CLONE_SIGHAND, NULL);

        sleep(3);

        printf("after clone\n");
        exit(0);
}
