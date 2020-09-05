struct COMMAND {asmlinkage int sys_gettaskinfo( void )
{
	printk("<0> PID : %d \n", current->pid);
	printk("<0> TGID : %d \n", current->tgid);
	printk("<0> PPID : %d \n", current->parent->pid);
	printk("<0> STATE : %d \n", current->state);
	printk("<0> PRIORITY: %d \n", current->prio);
	printk("<0> POLICY : %d \n", current->policy);
	printk("<0> Number of MAJOR FALUT : %d \n", current->maj_flt);
	printk("<0> Number of MINOR FALUT : %d \n", current->min_flt);
	return 0;
}