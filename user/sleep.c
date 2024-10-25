#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "user/user.h"
int main( int argc ,char *argv[])  //通过argc和argv传入参数
{
    if(argc!=2){
        printf("no\n");
        exit(1);
    }
    sleep(atoi(argv[1]));
    exit(0);
}
