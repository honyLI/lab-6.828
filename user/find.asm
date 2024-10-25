
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/types.h"     //调用相应的头文件
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

int find(char * path,char * name){
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	0500                	addi	s0,sp,640
  2a:	892a                	mv	s2,a0
  2c:	89ae                	mv	s3,a1
    int fd;
    char buf[512],*p;
    struct stat st;
    struct dirent de;
    fd = open(path,0);
  2e:	4581                	li	a1,0
  30:	00000097          	auipc	ra,0x0
  34:	4c2080e7          	jalr	1218(ra) # 4f2 <open>
    if(fd < 0){
  38:	0a054863          	bltz	a0,e8 <find+0xe8>
  3c:	84aa                	mv	s1,a0
        printf("cannot open %s\n",path);
        return 0;
    }
    if(fstat(fd, &st) < 0){
  3e:	d9840593          	addi	a1,s0,-616
  42:	00000097          	auipc	ra,0x0
  46:	4c8080e7          	jalr	1224(ra) # 50a <fstat>
  4a:	0a054963          	bltz	a0,fc <find+0xfc>
        printf("cannot stat %s\n", path);
        close(fd);
        return 0;
    }
    switch(st.type){
  4e:	da041783          	lh	a5,-608(s0)
  52:	0007869b          	sext.w	a3,a5
  56:	4705                	li	a4,1
  58:	0ce68b63          	beq	a3,a4,12e <find+0x12e>
  5c:	4709                	li	a4,2
  5e:	04e69a63          	bne	a3,a4,b2 <find+0xb2>
        case T_FILE:
            //printf("%s\n",path);
            strcpy(buf,path);
  62:	85ca                	mv	a1,s2
  64:	db040513          	addi	a0,s0,-592
  68:	00000097          	auipc	ra,0x0
  6c:	1d4080e7          	jalr	468(ra) # 23c <strcpy>
            p = buf + strlen(buf);
  70:	db040513          	addi	a0,s0,-592
  74:	00000097          	auipc	ra,0x0
  78:	210080e7          	jalr	528(ra) # 284 <strlen>
  7c:	02051793          	slli	a5,a0,0x20
  80:	9381                	srli	a5,a5,0x20
  82:	db040713          	addi	a4,s0,-592
  86:	97ba                	add	a5,a5,a4
            for(;*p != '/';p--);
  88:	0007c683          	lbu	a3,0(a5)
  8c:	02f00713          	li	a4,47
  90:	00e68963          	beq	a3,a4,a2 <find+0xa2>
  94:	02f00693          	li	a3,47
  98:	17fd                	addi	a5,a5,-1
  9a:	0007c703          	lbu	a4,0(a5)
  9e:	fed71de3          	bne	a4,a3,98 <find+0x98>
            p++;
            if(!strcmp(p,name)){
  a2:	85ce                	mv	a1,s3
  a4:	00178513          	addi	a0,a5,1
  a8:	00000097          	auipc	ra,0x0
  ac:	1b0080e7          	jalr	432(ra) # 258 <strcmp>
  b0:	c52d                	beqz	a0,11a <find+0x11a>
                }
                find(buf,name);
            }
            break;
    }
    close(fd);
  b2:	8526                	mv	a0,s1
  b4:	00000097          	auipc	ra,0x0
  b8:	426080e7          	jalr	1062(ra) # 4da <close>
    return 0;
}
  bc:	4501                	li	a0,0
  be:	27813083          	ld	ra,632(sp)
  c2:	27013403          	ld	s0,624(sp)
  c6:	26813483          	ld	s1,616(sp)
  ca:	26013903          	ld	s2,608(sp)
  ce:	25813983          	ld	s3,600(sp)
  d2:	25013a03          	ld	s4,592(sp)
  d6:	24813a83          	ld	s5,584(sp)
  da:	24013b03          	ld	s6,576(sp)
  de:	23813b83          	ld	s7,568(sp)
  e2:	28010113          	addi	sp,sp,640
  e6:	8082                	ret
        printf("cannot open %s\n",path);
  e8:	85ca                	mv	a1,s2
  ea:	00001517          	auipc	a0,0x1
  ee:	8e650513          	addi	a0,a0,-1818 # 9d0 <malloc+0xe8>
  f2:	00000097          	auipc	ra,0x0
  f6:	738080e7          	jalr	1848(ra) # 82a <printf>
        return 0;
  fa:	b7c9                	j	bc <find+0xbc>
        printf("cannot stat %s\n", path);
  fc:	85ca                	mv	a1,s2
  fe:	00001517          	auipc	a0,0x1
 102:	8e250513          	addi	a0,a0,-1822 # 9e0 <malloc+0xf8>
 106:	00000097          	auipc	ra,0x0
 10a:	724080e7          	jalr	1828(ra) # 82a <printf>
        close(fd);
 10e:	8526                	mv	a0,s1
 110:	00000097          	auipc	ra,0x0
 114:	3ca080e7          	jalr	970(ra) # 4da <close>
        return 0;
 118:	b755                	j	bc <find+0xbc>
                printf("%s\n",path);
 11a:	85ca                	mv	a1,s2
 11c:	00001517          	auipc	a0,0x1
 120:	8d450513          	addi	a0,a0,-1836 # 9f0 <malloc+0x108>
 124:	00000097          	auipc	ra,0x0
 128:	706080e7          	jalr	1798(ra) # 82a <printf>
 12c:	b759                	j	b2 <find+0xb2>
            strcpy(buf,path);
 12e:	85ca                	mv	a1,s2
 130:	db040513          	addi	a0,s0,-592
 134:	00000097          	auipc	ra,0x0
 138:	108080e7          	jalr	264(ra) # 23c <strcpy>
            p = buf + strlen(buf);
 13c:	db040513          	addi	a0,s0,-592
 140:	00000097          	auipc	ra,0x0
 144:	144080e7          	jalr	324(ra) # 284 <strlen>
 148:	02051913          	slli	s2,a0,0x20
 14c:	02095913          	srli	s2,s2,0x20
 150:	db040793          	addi	a5,s0,-592
 154:	993e                	add	s2,s2,a5
            *p++ = '/';
 156:	00190b13          	addi	s6,s2,1
 15a:	02f00793          	li	a5,47
 15e:	00f90023          	sb	a5,0(s2)
                if(!strcmp(de.name,".")){
 162:	00001a97          	auipc	s5,0x1
 166:	896a8a93          	addi	s5,s5,-1898 # 9f8 <malloc+0x110>
                if(!strcmp(de.name,"..")){
 16a:	00001b97          	auipc	s7,0x1
 16e:	896b8b93          	addi	s7,s7,-1898 # a00 <malloc+0x118>
                if(!strcmp(de.name,".")){
 172:	d8a40a13          	addi	s4,s0,-630
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
 176:	4641                	li	a2,16
 178:	d8840593          	addi	a1,s0,-632
 17c:	8526                	mv	a0,s1
 17e:	00000097          	auipc	ra,0x0
 182:	34c080e7          	jalr	844(ra) # 4ca <read>
 186:	47c1                	li	a5,16
 188:	f2f515e3          	bne	a0,a5,b2 <find+0xb2>
                if(de.inum == 0)
 18c:	d8845783          	lhu	a5,-632(s0)
 190:	d3fd                	beqz	a5,176 <find+0x176>
                if(!strcmp(de.name,".")){
 192:	85d6                	mv	a1,s5
 194:	8552                	mv	a0,s4
 196:	00000097          	auipc	ra,0x0
 19a:	0c2080e7          	jalr	194(ra) # 258 <strcmp>
 19e:	dd61                	beqz	a0,176 <find+0x176>
                if(!strcmp(de.name,"..")){
 1a0:	85de                	mv	a1,s7
 1a2:	8552                	mv	a0,s4
 1a4:	00000097          	auipc	ra,0x0
 1a8:	0b4080e7          	jalr	180(ra) # 258 <strcmp>
 1ac:	d569                	beqz	a0,176 <find+0x176>
                memmove(p, de.name, DIRSIZ);
 1ae:	4639                	li	a2,14
 1b0:	d8a40593          	addi	a1,s0,-630
 1b4:	855a                	mv	a0,s6
 1b6:	00000097          	auipc	ra,0x0
 1ba:	246080e7          	jalr	582(ra) # 3fc <memmove>
                p[DIRSIZ] = 0;
 1be:	000907a3          	sb	zero,15(s2)
                if(stat(buf, &st) < 0){
 1c2:	d9840593          	addi	a1,s0,-616
 1c6:	db040513          	addi	a0,s0,-592
 1ca:	00000097          	auipc	ra,0x0
 1ce:	1a2080e7          	jalr	418(ra) # 36c <stat>
 1d2:	00054a63          	bltz	a0,1e6 <find+0x1e6>
                find(buf,name);
 1d6:	85ce                	mv	a1,s3
 1d8:	db040513          	addi	a0,s0,-592
 1dc:	00000097          	auipc	ra,0x0
 1e0:	e24080e7          	jalr	-476(ra) # 0 <find>
 1e4:	bf49                	j	176 <find+0x176>
                    printf("cannot stat %s\n", buf);
 1e6:	db040593          	addi	a1,s0,-592
 1ea:	00000517          	auipc	a0,0x0
 1ee:	7f650513          	addi	a0,a0,2038 # 9e0 <malloc+0xf8>
 1f2:	00000097          	auipc	ra,0x0
 1f6:	638080e7          	jalr	1592(ra) # 82a <printf>
                    continue;
 1fa:	bfb5                	j	176 <find+0x176>

00000000000001fc <main>:



int main(int argc ,char *argv[]){
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e406                	sd	ra,8(sp)
 200:	e022                	sd	s0,0(sp)
 202:	0800                	addi	s0,sp,16

    char * path = argv[1];
    char * name = argv[2];
    if(argc != 3){
 204:	470d                	li	a4,3
 206:	00e50f63          	beq	a0,a4,224 <main+0x28>
        printf("less\n");
 20a:	00000517          	auipc	a0,0x0
 20e:	7fe50513          	addi	a0,a0,2046 # a08 <malloc+0x120>
 212:	00000097          	auipc	ra,0x0
 216:	618080e7          	jalr	1560(ra) # 82a <printf>
        exit(0);
 21a:	4501                	li	a0,0
 21c:	00000097          	auipc	ra,0x0
 220:	296080e7          	jalr	662(ra) # 4b2 <exit>
 224:	87ae                	mv	a5,a1
    }
    find(path,name);
 226:	698c                	ld	a1,16(a1)
 228:	6788                	ld	a0,8(a5)
 22a:	00000097          	auipc	ra,0x0
 22e:	dd6080e7          	jalr	-554(ra) # 0 <find>
    exit(0);
 232:	4501                	li	a0,0
 234:	00000097          	auipc	ra,0x0
 238:	27e080e7          	jalr	638(ra) # 4b2 <exit>

000000000000023c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 242:	87aa                	mv	a5,a0
 244:	0585                	addi	a1,a1,1
 246:	0785                	addi	a5,a5,1
 248:	fff5c703          	lbu	a4,-1(a1)
 24c:	fee78fa3          	sb	a4,-1(a5)
 250:	fb75                	bnez	a4,244 <strcpy+0x8>
    ;
  return os;
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret

0000000000000258 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e422                	sd	s0,8(sp)
 25c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 25e:	00054783          	lbu	a5,0(a0)
 262:	cb91                	beqz	a5,276 <strcmp+0x1e>
 264:	0005c703          	lbu	a4,0(a1)
 268:	00f71763          	bne	a4,a5,276 <strcmp+0x1e>
    p++, q++;
 26c:	0505                	addi	a0,a0,1
 26e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 270:	00054783          	lbu	a5,0(a0)
 274:	fbe5                	bnez	a5,264 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 276:	0005c503          	lbu	a0,0(a1)
}
 27a:	40a7853b          	subw	a0,a5,a0
 27e:	6422                	ld	s0,8(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret

0000000000000284 <strlen>:

uint
strlen(const char *s)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 28a:	00054783          	lbu	a5,0(a0)
 28e:	cf91                	beqz	a5,2aa <strlen+0x26>
 290:	0505                	addi	a0,a0,1
 292:	87aa                	mv	a5,a0
 294:	4685                	li	a3,1
 296:	9e89                	subw	a3,a3,a0
 298:	00f6853b          	addw	a0,a3,a5
 29c:	0785                	addi	a5,a5,1
 29e:	fff7c703          	lbu	a4,-1(a5)
 2a2:	fb7d                	bnez	a4,298 <strlen+0x14>
    ;
  return n;
}
 2a4:	6422                	ld	s0,8(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret
  for(n = 0; s[n]; n++)
 2aa:	4501                	li	a0,0
 2ac:	bfe5                	j	2a4 <strlen+0x20>

00000000000002ae <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2b4:	ce09                	beqz	a2,2ce <memset+0x20>
 2b6:	87aa                	mv	a5,a0
 2b8:	fff6071b          	addiw	a4,a2,-1
 2bc:	1702                	slli	a4,a4,0x20
 2be:	9301                	srli	a4,a4,0x20
 2c0:	0705                	addi	a4,a4,1
 2c2:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2c4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2c8:	0785                	addi	a5,a5,1
 2ca:	fee79de3          	bne	a5,a4,2c4 <memset+0x16>
  }
  return dst;
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret

00000000000002d4 <strchr>:

char*
strchr(const char *s, char c)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	cb99                	beqz	a5,2f4 <strchr+0x20>
    if(*s == c)
 2e0:	00f58763          	beq	a1,a5,2ee <strchr+0x1a>
  for(; *s; s++)
 2e4:	0505                	addi	a0,a0,1
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	fbfd                	bnez	a5,2e0 <strchr+0xc>
      return (char*)s;
  return 0;
 2ec:	4501                	li	a0,0
}
 2ee:	6422                	ld	s0,8(sp)
 2f0:	0141                	addi	sp,sp,16
 2f2:	8082                	ret
  return 0;
 2f4:	4501                	li	a0,0
 2f6:	bfe5                	j	2ee <strchr+0x1a>

00000000000002f8 <gets>:

char*
gets(char *buf, int max)
{
 2f8:	711d                	addi	sp,sp,-96
 2fa:	ec86                	sd	ra,88(sp)
 2fc:	e8a2                	sd	s0,80(sp)
 2fe:	e4a6                	sd	s1,72(sp)
 300:	e0ca                	sd	s2,64(sp)
 302:	fc4e                	sd	s3,56(sp)
 304:	f852                	sd	s4,48(sp)
 306:	f456                	sd	s5,40(sp)
 308:	f05a                	sd	s6,32(sp)
 30a:	ec5e                	sd	s7,24(sp)
 30c:	1080                	addi	s0,sp,96
 30e:	8baa                	mv	s7,a0
 310:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 312:	892a                	mv	s2,a0
 314:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 316:	4aa9                	li	s5,10
 318:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 31a:	89a6                	mv	s3,s1
 31c:	2485                	addiw	s1,s1,1
 31e:	0344d863          	bge	s1,s4,34e <gets+0x56>
    cc = read(0, &c, 1);
 322:	4605                	li	a2,1
 324:	faf40593          	addi	a1,s0,-81
 328:	4501                	li	a0,0
 32a:	00000097          	auipc	ra,0x0
 32e:	1a0080e7          	jalr	416(ra) # 4ca <read>
    if(cc < 1)
 332:	00a05e63          	blez	a0,34e <gets+0x56>
    buf[i++] = c;
 336:	faf44783          	lbu	a5,-81(s0)
 33a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 33e:	01578763          	beq	a5,s5,34c <gets+0x54>
 342:	0905                	addi	s2,s2,1
 344:	fd679be3          	bne	a5,s6,31a <gets+0x22>
  for(i=0; i+1 < max; ){
 348:	89a6                	mv	s3,s1
 34a:	a011                	j	34e <gets+0x56>
 34c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 34e:	99de                	add	s3,s3,s7
 350:	00098023          	sb	zero,0(s3)
  return buf;
}
 354:	855e                	mv	a0,s7
 356:	60e6                	ld	ra,88(sp)
 358:	6446                	ld	s0,80(sp)
 35a:	64a6                	ld	s1,72(sp)
 35c:	6906                	ld	s2,64(sp)
 35e:	79e2                	ld	s3,56(sp)
 360:	7a42                	ld	s4,48(sp)
 362:	7aa2                	ld	s5,40(sp)
 364:	7b02                	ld	s6,32(sp)
 366:	6be2                	ld	s7,24(sp)
 368:	6125                	addi	sp,sp,96
 36a:	8082                	ret

000000000000036c <stat>:

int
stat(const char *n, struct stat *st)
{
 36c:	1101                	addi	sp,sp,-32
 36e:	ec06                	sd	ra,24(sp)
 370:	e822                	sd	s0,16(sp)
 372:	e426                	sd	s1,8(sp)
 374:	e04a                	sd	s2,0(sp)
 376:	1000                	addi	s0,sp,32
 378:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 37a:	4581                	li	a1,0
 37c:	00000097          	auipc	ra,0x0
 380:	176080e7          	jalr	374(ra) # 4f2 <open>
  if(fd < 0)
 384:	02054563          	bltz	a0,3ae <stat+0x42>
 388:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 38a:	85ca                	mv	a1,s2
 38c:	00000097          	auipc	ra,0x0
 390:	17e080e7          	jalr	382(ra) # 50a <fstat>
 394:	892a                	mv	s2,a0
  close(fd);
 396:	8526                	mv	a0,s1
 398:	00000097          	auipc	ra,0x0
 39c:	142080e7          	jalr	322(ra) # 4da <close>
  return r;
}
 3a0:	854a                	mv	a0,s2
 3a2:	60e2                	ld	ra,24(sp)
 3a4:	6442                	ld	s0,16(sp)
 3a6:	64a2                	ld	s1,8(sp)
 3a8:	6902                	ld	s2,0(sp)
 3aa:	6105                	addi	sp,sp,32
 3ac:	8082                	ret
    return -1;
 3ae:	597d                	li	s2,-1
 3b0:	bfc5                	j	3a0 <stat+0x34>

00000000000003b2 <atoi>:

int
atoi(const char *s)
{
 3b2:	1141                	addi	sp,sp,-16
 3b4:	e422                	sd	s0,8(sp)
 3b6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b8:	00054603          	lbu	a2,0(a0)
 3bc:	fd06079b          	addiw	a5,a2,-48
 3c0:	0ff7f793          	andi	a5,a5,255
 3c4:	4725                	li	a4,9
 3c6:	02f76963          	bltu	a4,a5,3f8 <atoi+0x46>
 3ca:	86aa                	mv	a3,a0
  n = 0;
 3cc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3ce:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3d0:	0685                	addi	a3,a3,1
 3d2:	0025179b          	slliw	a5,a0,0x2
 3d6:	9fa9                	addw	a5,a5,a0
 3d8:	0017979b          	slliw	a5,a5,0x1
 3dc:	9fb1                	addw	a5,a5,a2
 3de:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3e2:	0006c603          	lbu	a2,0(a3)
 3e6:	fd06071b          	addiw	a4,a2,-48
 3ea:	0ff77713          	andi	a4,a4,255
 3ee:	fee5f1e3          	bgeu	a1,a4,3d0 <atoi+0x1e>
  return n;
}
 3f2:	6422                	ld	s0,8(sp)
 3f4:	0141                	addi	sp,sp,16
 3f6:	8082                	ret
  n = 0;
 3f8:	4501                	li	a0,0
 3fa:	bfe5                	j	3f2 <atoi+0x40>

00000000000003fc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 402:	02b57663          	bgeu	a0,a1,42e <memmove+0x32>
    while(n-- > 0)
 406:	02c05163          	blez	a2,428 <memmove+0x2c>
 40a:	fff6079b          	addiw	a5,a2,-1
 40e:	1782                	slli	a5,a5,0x20
 410:	9381                	srli	a5,a5,0x20
 412:	0785                	addi	a5,a5,1
 414:	97aa                	add	a5,a5,a0
  dst = vdst;
 416:	872a                	mv	a4,a0
      *dst++ = *src++;
 418:	0585                	addi	a1,a1,1
 41a:	0705                	addi	a4,a4,1
 41c:	fff5c683          	lbu	a3,-1(a1)
 420:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 424:	fee79ae3          	bne	a5,a4,418 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
    dst += n;
 42e:	00c50733          	add	a4,a0,a2
    src += n;
 432:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 434:	fec05ae3          	blez	a2,428 <memmove+0x2c>
 438:	fff6079b          	addiw	a5,a2,-1
 43c:	1782                	slli	a5,a5,0x20
 43e:	9381                	srli	a5,a5,0x20
 440:	fff7c793          	not	a5,a5
 444:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 446:	15fd                	addi	a1,a1,-1
 448:	177d                	addi	a4,a4,-1
 44a:	0005c683          	lbu	a3,0(a1)
 44e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 452:	fee79ae3          	bne	a5,a4,446 <memmove+0x4a>
 456:	bfc9                	j	428 <memmove+0x2c>

0000000000000458 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 458:	1141                	addi	sp,sp,-16
 45a:	e422                	sd	s0,8(sp)
 45c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 45e:	ca05                	beqz	a2,48e <memcmp+0x36>
 460:	fff6069b          	addiw	a3,a2,-1
 464:	1682                	slli	a3,a3,0x20
 466:	9281                	srli	a3,a3,0x20
 468:	0685                	addi	a3,a3,1
 46a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 46c:	00054783          	lbu	a5,0(a0)
 470:	0005c703          	lbu	a4,0(a1)
 474:	00e79863          	bne	a5,a4,484 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 478:	0505                	addi	a0,a0,1
    p2++;
 47a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 47c:	fed518e3          	bne	a0,a3,46c <memcmp+0x14>
  }
  return 0;
 480:	4501                	li	a0,0
 482:	a019                	j	488 <memcmp+0x30>
      return *p1 - *p2;
 484:	40e7853b          	subw	a0,a5,a4
}
 488:	6422                	ld	s0,8(sp)
 48a:	0141                	addi	sp,sp,16
 48c:	8082                	ret
  return 0;
 48e:	4501                	li	a0,0
 490:	bfe5                	j	488 <memcmp+0x30>

0000000000000492 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 492:	1141                	addi	sp,sp,-16
 494:	e406                	sd	ra,8(sp)
 496:	e022                	sd	s0,0(sp)
 498:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 49a:	00000097          	auipc	ra,0x0
 49e:	f62080e7          	jalr	-158(ra) # 3fc <memmove>
}
 4a2:	60a2                	ld	ra,8(sp)
 4a4:	6402                	ld	s0,0(sp)
 4a6:	0141                	addi	sp,sp,16
 4a8:	8082                	ret

00000000000004aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4aa:	4885                	li	a7,1
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b2:	4889                	li	a7,2
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ba:	488d                	li	a7,3
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c2:	4891                	li	a7,4
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <read>:
.global read
read:
 li a7, SYS_read
 4ca:	4895                	li	a7,5
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <write>:
.global write
write:
 li a7, SYS_write
 4d2:	48c1                	li	a7,16
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <close>:
.global close
close:
 li a7, SYS_close
 4da:	48d5                	li	a7,21
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e2:	4899                	li	a7,6
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ea:	489d                	li	a7,7
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <open>:
.global open
open:
 li a7, SYS_open
 4f2:	48bd                	li	a7,15
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4fa:	48c5                	li	a7,17
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 502:	48c9                	li	a7,18
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 50a:	48a1                	li	a7,8
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <link>:
.global link
link:
 li a7, SYS_link
 512:	48cd                	li	a7,19
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 51a:	48d1                	li	a7,20
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 522:	48a5                	li	a7,9
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <dup>:
.global dup
dup:
 li a7, SYS_dup
 52a:	48a9                	li	a7,10
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 532:	48ad                	li	a7,11
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 53a:	48b1                	li	a7,12
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 542:	48b5                	li	a7,13
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 54a:	48b9                	li	a7,14
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 552:	1101                	addi	sp,sp,-32
 554:	ec06                	sd	ra,24(sp)
 556:	e822                	sd	s0,16(sp)
 558:	1000                	addi	s0,sp,32
 55a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 55e:	4605                	li	a2,1
 560:	fef40593          	addi	a1,s0,-17
 564:	00000097          	auipc	ra,0x0
 568:	f6e080e7          	jalr	-146(ra) # 4d2 <write>
}
 56c:	60e2                	ld	ra,24(sp)
 56e:	6442                	ld	s0,16(sp)
 570:	6105                	addi	sp,sp,32
 572:	8082                	ret

0000000000000574 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 574:	7139                	addi	sp,sp,-64
 576:	fc06                	sd	ra,56(sp)
 578:	f822                	sd	s0,48(sp)
 57a:	f426                	sd	s1,40(sp)
 57c:	f04a                	sd	s2,32(sp)
 57e:	ec4e                	sd	s3,24(sp)
 580:	0080                	addi	s0,sp,64
 582:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 584:	c299                	beqz	a3,58a <printint+0x16>
 586:	0805c863          	bltz	a1,616 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 58a:	2581                	sext.w	a1,a1
  neg = 0;
 58c:	4881                	li	a7,0
 58e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 592:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 594:	2601                	sext.w	a2,a2
 596:	00000517          	auipc	a0,0x0
 59a:	48250513          	addi	a0,a0,1154 # a18 <digits>
 59e:	883a                	mv	a6,a4
 5a0:	2705                	addiw	a4,a4,1
 5a2:	02c5f7bb          	remuw	a5,a1,a2
 5a6:	1782                	slli	a5,a5,0x20
 5a8:	9381                	srli	a5,a5,0x20
 5aa:	97aa                	add	a5,a5,a0
 5ac:	0007c783          	lbu	a5,0(a5)
 5b0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5b4:	0005879b          	sext.w	a5,a1
 5b8:	02c5d5bb          	divuw	a1,a1,a2
 5bc:	0685                	addi	a3,a3,1
 5be:	fec7f0e3          	bgeu	a5,a2,59e <printint+0x2a>
  if(neg)
 5c2:	00088b63          	beqz	a7,5d8 <printint+0x64>
    buf[i++] = '-';
 5c6:	fd040793          	addi	a5,s0,-48
 5ca:	973e                	add	a4,a4,a5
 5cc:	02d00793          	li	a5,45
 5d0:	fef70823          	sb	a5,-16(a4)
 5d4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5d8:	02e05863          	blez	a4,608 <printint+0x94>
 5dc:	fc040793          	addi	a5,s0,-64
 5e0:	00e78933          	add	s2,a5,a4
 5e4:	fff78993          	addi	s3,a5,-1
 5e8:	99ba                	add	s3,s3,a4
 5ea:	377d                	addiw	a4,a4,-1
 5ec:	1702                	slli	a4,a4,0x20
 5ee:	9301                	srli	a4,a4,0x20
 5f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5f4:	fff94583          	lbu	a1,-1(s2)
 5f8:	8526                	mv	a0,s1
 5fa:	00000097          	auipc	ra,0x0
 5fe:	f58080e7          	jalr	-168(ra) # 552 <putc>
  while(--i >= 0)
 602:	197d                	addi	s2,s2,-1
 604:	ff3918e3          	bne	s2,s3,5f4 <printint+0x80>
}
 608:	70e2                	ld	ra,56(sp)
 60a:	7442                	ld	s0,48(sp)
 60c:	74a2                	ld	s1,40(sp)
 60e:	7902                	ld	s2,32(sp)
 610:	69e2                	ld	s3,24(sp)
 612:	6121                	addi	sp,sp,64
 614:	8082                	ret
    x = -xx;
 616:	40b005bb          	negw	a1,a1
    neg = 1;
 61a:	4885                	li	a7,1
    x = -xx;
 61c:	bf8d                	j	58e <printint+0x1a>

000000000000061e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 61e:	7119                	addi	sp,sp,-128
 620:	fc86                	sd	ra,120(sp)
 622:	f8a2                	sd	s0,112(sp)
 624:	f4a6                	sd	s1,104(sp)
 626:	f0ca                	sd	s2,96(sp)
 628:	ecce                	sd	s3,88(sp)
 62a:	e8d2                	sd	s4,80(sp)
 62c:	e4d6                	sd	s5,72(sp)
 62e:	e0da                	sd	s6,64(sp)
 630:	fc5e                	sd	s7,56(sp)
 632:	f862                	sd	s8,48(sp)
 634:	f466                	sd	s9,40(sp)
 636:	f06a                	sd	s10,32(sp)
 638:	ec6e                	sd	s11,24(sp)
 63a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63c:	0005c903          	lbu	s2,0(a1)
 640:	18090f63          	beqz	s2,7de <vprintf+0x1c0>
 644:	8aaa                	mv	s5,a0
 646:	8b32                	mv	s6,a2
 648:	00158493          	addi	s1,a1,1
  state = 0;
 64c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 64e:	02500a13          	li	s4,37
      if(c == 'd'){
 652:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 656:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 65a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 65e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 662:	00000b97          	auipc	s7,0x0
 666:	3b6b8b93          	addi	s7,s7,950 # a18 <digits>
 66a:	a839                	j	688 <vprintf+0x6a>
        putc(fd, c);
 66c:	85ca                	mv	a1,s2
 66e:	8556                	mv	a0,s5
 670:	00000097          	auipc	ra,0x0
 674:	ee2080e7          	jalr	-286(ra) # 552 <putc>
 678:	a019                	j	67e <vprintf+0x60>
    } else if(state == '%'){
 67a:	01498f63          	beq	s3,s4,698 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 67e:	0485                	addi	s1,s1,1
 680:	fff4c903          	lbu	s2,-1(s1)
 684:	14090d63          	beqz	s2,7de <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 688:	0009079b          	sext.w	a5,s2
    if(state == 0){
 68c:	fe0997e3          	bnez	s3,67a <vprintf+0x5c>
      if(c == '%'){
 690:	fd479ee3          	bne	a5,s4,66c <vprintf+0x4e>
        state = '%';
 694:	89be                	mv	s3,a5
 696:	b7e5                	j	67e <vprintf+0x60>
      if(c == 'd'){
 698:	05878063          	beq	a5,s8,6d8 <vprintf+0xba>
      } else if(c == 'l') {
 69c:	05978c63          	beq	a5,s9,6f4 <vprintf+0xd6>
      } else if(c == 'x') {
 6a0:	07a78863          	beq	a5,s10,710 <vprintf+0xf2>
      } else if(c == 'p') {
 6a4:	09b78463          	beq	a5,s11,72c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6a8:	07300713          	li	a4,115
 6ac:	0ce78663          	beq	a5,a4,778 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b0:	06300713          	li	a4,99
 6b4:	0ee78e63          	beq	a5,a4,7b0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6b8:	11478863          	beq	a5,s4,7c8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6bc:	85d2                	mv	a1,s4
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	e92080e7          	jalr	-366(ra) # 552 <putc>
        putc(fd, c);
 6c8:	85ca                	mv	a1,s2
 6ca:	8556                	mv	a0,s5
 6cc:	00000097          	auipc	ra,0x0
 6d0:	e86080e7          	jalr	-378(ra) # 552 <putc>
      }
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	b765                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6d8:	008b0913          	addi	s2,s6,8
 6dc:	4685                	li	a3,1
 6de:	4629                	li	a2,10
 6e0:	000b2583          	lw	a1,0(s6)
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e8e080e7          	jalr	-370(ra) # 574 <printint>
 6ee:	8b4a                	mv	s6,s2
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	b771                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f4:	008b0913          	addi	s2,s6,8
 6f8:	4681                	li	a3,0
 6fa:	4629                	li	a2,10
 6fc:	000b2583          	lw	a1,0(s6)
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	e72080e7          	jalr	-398(ra) # 574 <printint>
 70a:	8b4a                	mv	s6,s2
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bf85                	j	67e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 710:	008b0913          	addi	s2,s6,8
 714:	4681                	li	a3,0
 716:	4641                	li	a2,16
 718:	000b2583          	lw	a1,0(s6)
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	e56080e7          	jalr	-426(ra) # 574 <printint>
 726:	8b4a                	mv	s6,s2
      state = 0;
 728:	4981                	li	s3,0
 72a:	bf91                	j	67e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 72c:	008b0793          	addi	a5,s6,8
 730:	f8f43423          	sd	a5,-120(s0)
 734:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 738:	03000593          	li	a1,48
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e14080e7          	jalr	-492(ra) # 552 <putc>
  putc(fd, 'x');
 746:	85ea                	mv	a1,s10
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e08080e7          	jalr	-504(ra) # 552 <putc>
 752:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 754:	03c9d793          	srli	a5,s3,0x3c
 758:	97de                	add	a5,a5,s7
 75a:	0007c583          	lbu	a1,0(a5)
 75e:	8556                	mv	a0,s5
 760:	00000097          	auipc	ra,0x0
 764:	df2080e7          	jalr	-526(ra) # 552 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 768:	0992                	slli	s3,s3,0x4
 76a:	397d                	addiw	s2,s2,-1
 76c:	fe0914e3          	bnez	s2,754 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 770:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 774:	4981                	li	s3,0
 776:	b721                	j	67e <vprintf+0x60>
        s = va_arg(ap, char*);
 778:	008b0993          	addi	s3,s6,8
 77c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 780:	02090163          	beqz	s2,7a2 <vprintf+0x184>
        while(*s != 0){
 784:	00094583          	lbu	a1,0(s2)
 788:	c9a1                	beqz	a1,7d8 <vprintf+0x1ba>
          putc(fd, *s);
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	dc6080e7          	jalr	-570(ra) # 552 <putc>
          s++;
 794:	0905                	addi	s2,s2,1
        while(*s != 0){
 796:	00094583          	lbu	a1,0(s2)
 79a:	f9e5                	bnez	a1,78a <vprintf+0x16c>
        s = va_arg(ap, char*);
 79c:	8b4e                	mv	s6,s3
      state = 0;
 79e:	4981                	li	s3,0
 7a0:	bdf9                	j	67e <vprintf+0x60>
          s = "(null)";
 7a2:	00000917          	auipc	s2,0x0
 7a6:	26e90913          	addi	s2,s2,622 # a10 <malloc+0x128>
        while(*s != 0){
 7aa:	02800593          	li	a1,40
 7ae:	bff1                	j	78a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7b0:	008b0913          	addi	s2,s6,8
 7b4:	000b4583          	lbu	a1,0(s6)
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	d98080e7          	jalr	-616(ra) # 552 <putc>
 7c2:	8b4a                	mv	s6,s2
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bd65                	j	67e <vprintf+0x60>
        putc(fd, c);
 7c8:	85d2                	mv	a1,s4
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	d86080e7          	jalr	-634(ra) # 552 <putc>
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b565                	j	67e <vprintf+0x60>
        s = va_arg(ap, char*);
 7d8:	8b4e                	mv	s6,s3
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	b54d                	j	67e <vprintf+0x60>
    }
  }
}
 7de:	70e6                	ld	ra,120(sp)
 7e0:	7446                	ld	s0,112(sp)
 7e2:	74a6                	ld	s1,104(sp)
 7e4:	7906                	ld	s2,96(sp)
 7e6:	69e6                	ld	s3,88(sp)
 7e8:	6a46                	ld	s4,80(sp)
 7ea:	6aa6                	ld	s5,72(sp)
 7ec:	6b06                	ld	s6,64(sp)
 7ee:	7be2                	ld	s7,56(sp)
 7f0:	7c42                	ld	s8,48(sp)
 7f2:	7ca2                	ld	s9,40(sp)
 7f4:	7d02                	ld	s10,32(sp)
 7f6:	6de2                	ld	s11,24(sp)
 7f8:	6109                	addi	sp,sp,128
 7fa:	8082                	ret

00000000000007fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7fc:	715d                	addi	sp,sp,-80
 7fe:	ec06                	sd	ra,24(sp)
 800:	e822                	sd	s0,16(sp)
 802:	1000                	addi	s0,sp,32
 804:	e010                	sd	a2,0(s0)
 806:	e414                	sd	a3,8(s0)
 808:	e818                	sd	a4,16(s0)
 80a:	ec1c                	sd	a5,24(s0)
 80c:	03043023          	sd	a6,32(s0)
 810:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 814:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 818:	8622                	mv	a2,s0
 81a:	00000097          	auipc	ra,0x0
 81e:	e04080e7          	jalr	-508(ra) # 61e <vprintf>
}
 822:	60e2                	ld	ra,24(sp)
 824:	6442                	ld	s0,16(sp)
 826:	6161                	addi	sp,sp,80
 828:	8082                	ret

000000000000082a <printf>:

void
printf(const char *fmt, ...)
{
 82a:	711d                	addi	sp,sp,-96
 82c:	ec06                	sd	ra,24(sp)
 82e:	e822                	sd	s0,16(sp)
 830:	1000                	addi	s0,sp,32
 832:	e40c                	sd	a1,8(s0)
 834:	e810                	sd	a2,16(s0)
 836:	ec14                	sd	a3,24(s0)
 838:	f018                	sd	a4,32(s0)
 83a:	f41c                	sd	a5,40(s0)
 83c:	03043823          	sd	a6,48(s0)
 840:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 844:	00840613          	addi	a2,s0,8
 848:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 84c:	85aa                	mv	a1,a0
 84e:	4505                	li	a0,1
 850:	00000097          	auipc	ra,0x0
 854:	dce080e7          	jalr	-562(ra) # 61e <vprintf>
}
 858:	60e2                	ld	ra,24(sp)
 85a:	6442                	ld	s0,16(sp)
 85c:	6125                	addi	sp,sp,96
 85e:	8082                	ret

0000000000000860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 860:	1141                	addi	sp,sp,-16
 862:	e422                	sd	s0,8(sp)
 864:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 866:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86a:	00000797          	auipc	a5,0x0
 86e:	1c67b783          	ld	a5,454(a5) # a30 <freep>
 872:	a805                	j	8a2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 874:	4618                	lw	a4,8(a2)
 876:	9db9                	addw	a1,a1,a4
 878:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87c:	6398                	ld	a4,0(a5)
 87e:	6318                	ld	a4,0(a4)
 880:	fee53823          	sd	a4,-16(a0)
 884:	a091                	j	8c8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 886:	ff852703          	lw	a4,-8(a0)
 88a:	9e39                	addw	a2,a2,a4
 88c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 88e:	ff053703          	ld	a4,-16(a0)
 892:	e398                	sd	a4,0(a5)
 894:	a099                	j	8da <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 896:	6398                	ld	a4,0(a5)
 898:	00e7e463          	bltu	a5,a4,8a0 <free+0x40>
 89c:	00e6ea63          	bltu	a3,a4,8b0 <free+0x50>
{
 8a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a2:	fed7fae3          	bgeu	a5,a3,896 <free+0x36>
 8a6:	6398                	ld	a4,0(a5)
 8a8:	00e6e463          	bltu	a3,a4,8b0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ac:	fee7eae3          	bltu	a5,a4,8a0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8b0:	ff852583          	lw	a1,-8(a0)
 8b4:	6390                	ld	a2,0(a5)
 8b6:	02059713          	slli	a4,a1,0x20
 8ba:	9301                	srli	a4,a4,0x20
 8bc:	0712                	slli	a4,a4,0x4
 8be:	9736                	add	a4,a4,a3
 8c0:	fae60ae3          	beq	a2,a4,874 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c8:	4790                	lw	a2,8(a5)
 8ca:	02061713          	slli	a4,a2,0x20
 8ce:	9301                	srli	a4,a4,0x20
 8d0:	0712                	slli	a4,a4,0x4
 8d2:	973e                	add	a4,a4,a5
 8d4:	fae689e3          	beq	a3,a4,886 <free+0x26>
  } else
    p->s.ptr = bp;
 8d8:	e394                	sd	a3,0(a5)
  freep = p;
 8da:	00000717          	auipc	a4,0x0
 8de:	14f73b23          	sd	a5,342(a4) # a30 <freep>
}
 8e2:	6422                	ld	s0,8(sp)
 8e4:	0141                	addi	sp,sp,16
 8e6:	8082                	ret

00000000000008e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e8:	7139                	addi	sp,sp,-64
 8ea:	fc06                	sd	ra,56(sp)
 8ec:	f822                	sd	s0,48(sp)
 8ee:	f426                	sd	s1,40(sp)
 8f0:	f04a                	sd	s2,32(sp)
 8f2:	ec4e                	sd	s3,24(sp)
 8f4:	e852                	sd	s4,16(sp)
 8f6:	e456                	sd	s5,8(sp)
 8f8:	e05a                	sd	s6,0(sp)
 8fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fc:	02051493          	slli	s1,a0,0x20
 900:	9081                	srli	s1,s1,0x20
 902:	04bd                	addi	s1,s1,15
 904:	8091                	srli	s1,s1,0x4
 906:	0014899b          	addiw	s3,s1,1
 90a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 90c:	00000517          	auipc	a0,0x0
 910:	12453503          	ld	a0,292(a0) # a30 <freep>
 914:	c515                	beqz	a0,940 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 916:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 918:	4798                	lw	a4,8(a5)
 91a:	02977f63          	bgeu	a4,s1,958 <malloc+0x70>
 91e:	8a4e                	mv	s4,s3
 920:	0009871b          	sext.w	a4,s3
 924:	6685                	lui	a3,0x1
 926:	00d77363          	bgeu	a4,a3,92c <malloc+0x44>
 92a:	6a05                	lui	s4,0x1
 92c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 930:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 934:	00000917          	auipc	s2,0x0
 938:	0fc90913          	addi	s2,s2,252 # a30 <freep>
  if(p == (char*)-1)
 93c:	5afd                	li	s5,-1
 93e:	a88d                	j	9b0 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 940:	00000797          	auipc	a5,0x0
 944:	0f878793          	addi	a5,a5,248 # a38 <base>
 948:	00000717          	auipc	a4,0x0
 94c:	0ef73423          	sd	a5,232(a4) # a30 <freep>
 950:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 952:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 956:	b7e1                	j	91e <malloc+0x36>
      if(p->s.size == nunits)
 958:	02e48b63          	beq	s1,a4,98e <malloc+0xa6>
        p->s.size -= nunits;
 95c:	4137073b          	subw	a4,a4,s3
 960:	c798                	sw	a4,8(a5)
        p += p->s.size;
 962:	1702                	slli	a4,a4,0x20
 964:	9301                	srli	a4,a4,0x20
 966:	0712                	slli	a4,a4,0x4
 968:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 96a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96e:	00000717          	auipc	a4,0x0
 972:	0ca73123          	sd	a0,194(a4) # a30 <freep>
      return (void*)(p + 1);
 976:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 97a:	70e2                	ld	ra,56(sp)
 97c:	7442                	ld	s0,48(sp)
 97e:	74a2                	ld	s1,40(sp)
 980:	7902                	ld	s2,32(sp)
 982:	69e2                	ld	s3,24(sp)
 984:	6a42                	ld	s4,16(sp)
 986:	6aa2                	ld	s5,8(sp)
 988:	6b02                	ld	s6,0(sp)
 98a:	6121                	addi	sp,sp,64
 98c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	e118                	sd	a4,0(a0)
 992:	bff1                	j	96e <malloc+0x86>
  hp->s.size = nu;
 994:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 998:	0541                	addi	a0,a0,16
 99a:	00000097          	auipc	ra,0x0
 99e:	ec6080e7          	jalr	-314(ra) # 860 <free>
  return freep;
 9a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a6:	d971                	beqz	a0,97a <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9aa:	4798                	lw	a4,8(a5)
 9ac:	fa9776e3          	bgeu	a4,s1,958 <malloc+0x70>
    if(p == freep)
 9b0:	00093703          	ld	a4,0(s2)
 9b4:	853e                	mv	a0,a5
 9b6:	fef719e3          	bne	a4,a5,9a8 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9ba:	8552                	mv	a0,s4
 9bc:	00000097          	auipc	ra,0x0
 9c0:	b7e080e7          	jalr	-1154(ra) # 53a <sbrk>
  if(p == (char*)-1)
 9c4:	fd5518e3          	bne	a0,s5,994 <malloc+0xac>
        return 0;
 9c8:	4501                	li	a0,0
 9ca:	bf45                	j	97a <malloc+0x92>
