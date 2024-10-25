#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

int main( int argc ,char *argv[])  //通过argc和argv传入参数
{
    int pid;
    char *argv_c[MAXARG];

    for(int i=1;i<argc;i++){
        argv_c[i-1] = argv[i];
    }
    int res = 1;
    char *p,c;
    p = &c;
    int arg_n = argc - 1;
    char buf[1024];
    while(res){
        int buf_end = 0;
        arg_n = argc - 1;
        int begin = 0;
        while(1){
            res = read(0,p,1);
            if(res == 0){
                exit(0);
            }
            if(c == ' ' || c == '\n'){
                //printf("every arg arg_n:%d line:%d\n",arg_n,line);
                //printf("arg:%s\n",argv_c[arg_n]);
                buf[buf_end++] = 0; 
                argv_c[arg_n++] = &buf[begin];
                begin = buf_end;
                if(c == '\n'){
                    break;
                }
            }else{
                buf[buf_end++] = c;
                //printf("every char:%c line:%d\n",c,line);
            }
        }

        //printf("123456\n");
        argv_c[arg_n] = 0;
        pid = fork();
        if(pid == 0){
            exec(argv_c[0], argv_c);//exec
        }else{
            wait(0);
        }
    }
    exit(0);
}