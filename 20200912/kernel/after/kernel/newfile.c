#include <linux/unistd.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/sched.h>

asmlinkage long __arm64_sys_newsyscall(void)
{
	printk("<0> Hello Linux, I'm in Kernel \n");
	return 0;
}

EXPORT_SYMBOL_GPL(__arm64_sys_newsyscall);
