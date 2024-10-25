#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "user/user.h"

int main()
{
    int pid;
    int p[2];
    int p2[2];
    pipe(p);
    pipe(p2);
    int tmp = fork();
    if(tmp != 0){
        void * send;
        send = (void *)malloc(1);
        //*send = 1;
        pid = getpid();
        close(p[0]);
        write(p[1],send,1);
        close(p[1]);
        close(p2[1]);
        read(p2[0],send,1);
        close(p2[0]);
        printf("%d: received pong\n",pid);
    }else{
        void * recv;
        pid = getpid();
        recv = (void *)malloc(1);
        close(p[1]);
        read(p[0],recv,1);
        close(p[0]);
        printf("%d: received ping\n",pid);
        close(p2[0]);
        write(p2[1],recv,1);
        close(p2[1]);
    }
    exit(0);
}