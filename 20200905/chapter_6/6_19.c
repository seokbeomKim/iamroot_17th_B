#include "mystat.h"
asmlinkage int sys_gettaskinfo(int id, struct mystat *user_buf)
{
    struct mystat *buf;
    int i, cnt = 0;
    struct task_struct *search;
    struct file *fp;
    search = pid_task(id, PID_TYPE_PID);
    if (!start)
        return -1;
       buf = (char *)kmalloc(sizeof(struct mystat), GFP_KERNEL);
       if (buf == NULL) {
           printk("buf is NULL\n");
           return -1;
       }

       buf->pid = search->pid;
       buf->ppid = search->parent->pid;
       buf->stat = search->state;
       buf->priority = search->prio;
       buf->policy = search->policy;
       buf->utime = search->utime;
       buf->stime = search->stime;
       buf->starttime = search->start_time.tv_sec;
       buf->min_flt = search->min_flt;
       buf->maj_flt = search->maj_flt;
       for ( i = 0 ; i < 32; i++) {
           if ( (search->files->fd_array[i]) != NULL) {
               cnt++;
           }
       }

       buf->open_files = cnt;
       copy_to_user(user_buf, buf, sizeof(struct mystat));
       return 0;
}