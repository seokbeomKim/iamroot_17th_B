#include <stdio.h>
#include <linux/unistd.h>

int main(void)
{
    int mult_ret = 0;
    int x = 2,y=5;
    int i;
    i = syscall(318,x,y,&mult_ret);
    printf("x is %d \ny is %d \nret is %d \n",x,y,mult_ret);

    return 0;
}