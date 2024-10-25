#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int find(char * path,char * name){
    int fd;
    char buf[512],*p;
    struct stat st;
    struct dirent de;
    fd = open(path,0);
    if(fd < 0){
        printf("cannot open %s\n",path);
        return 0;
    }
    if(fstat(fd, &st) < 0){
        printf("cannot stat %s\n", path);
        close(fd);
        return 0;
    }
    switch(st.type){
        case T_FILE:
            //printf("%s\n",path);
            strcpy(buf,path);
            p = buf + strlen(buf);
            for(;*p != '/';p--);
            p++;
            if(!strcmp(p,name)){
                printf("%s\n",path);
            }
            break;
        case T_DIR:
            //printf("dir\n");
            strcpy(buf,path);
            p = buf + strlen(buf);
            *p++ = '/';
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
                //printf("every:%s\n",de.name);
                if(de.inum == 0)
                    continue;
                if(!strcmp(de.name,".")){
                    continue;
                }
                if(!strcmp(de.name,"..")){
                    continue;
                }
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                if(stat(buf, &st) < 0){
                    printf("cannot stat %s\n", buf);
                    continue;
                }
                find(buf,name);
            }
            break;
    }
    close(fd);
    return 0;
}



int main(int argc ,char *argv[]){

    char * path = argv[1];
    char * name = argv[2];
    if(argc != 3){
        printf("less\n");
        exit(0);
    }
    find(path,name);
    exit(0);
}