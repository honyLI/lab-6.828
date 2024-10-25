#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "user/user.h"
// 2 3 5 7 11 13 17
int child(int p){
    int tmp = 0;
    int res = read(p,&tmp,sizeof(tmp));
    if(res == 0){
        close(p);
        exit(0);
    }else{
        printf("prime %d\n",tmp);
    }
    int pi[2];
    pipe(pi);
    int pid = fork();
    if(pid == 0){
        close(pi[1]);
        child(pi[0]);
    }else{
        close(pi[0]);
        int i;
        while(read(p,&i,sizeof(i))){
            if(i % tmp == 0){
                //printf("%d:%d\n",getpid(),i);
                continue;
            }else{
                write(pi[1],&i,sizeof(i));
            }
        }        
        close(pi[1]);
        wait(0);        

    }
    exit(0);
}

int main(){
    int p[2];
    pipe(p);
    int pid = fork();
    if(pid == 0){
        close(p[1]);
        child(p[0]);
    }else{
        close(p[0]);
        for(int i=2;i<=35;i++){
            write(p[1],&i,sizeof(i));
        }
        close(p[1]);
        wait(0);
    }
    exit(0);
}