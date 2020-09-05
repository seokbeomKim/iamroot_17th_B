#include <linux/unistd.h>
#include <linux/kernel.h>
#include <asm/uaccess.h>

asmlinkage int sys_show_multi(int x,int y,int* res)
{
	int error,compute;
	int i;

	error = access_ok(VERIFY_WRITE,res,sizeof(*res));

	if(error < 0)
	{
		printk("error in cdang \n");
		printk("error is %d \n",error);
		return error;	
	}

	compute = x*y;
	printk("compute is %d \n",compute);
	i = copy_to_user(res,&compute,sizeof(int));
	return 0;
}