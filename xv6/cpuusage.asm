
_cpuusage:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "procinfo.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 28             	sub    $0x28,%esp
  19:	8b 41 04             	mov    0x4(%ecx),%eax
  int pid = 1;
  if(argc > 1) pid = atoi(argv[1]);
  1c:	83 39 01             	cmpl   $0x1,(%ecx)
  1f:	7e 10                	jle    31 <main+0x31>
  21:	83 ec 0c             	sub    $0xc,%esp
  24:	ff 70 04             	push   0x4(%eax)
  27:	e8 64 02 00 00       	call   290 <atoi>
  2c:	83 c4 10             	add    $0x10,%esp
  2f:	89 c7                	mov    %eax,%edi

  struct procinfo info;
  for(int p = pid; p < pid + 20; p++){
  31:	8d 77 13             	lea    0x13(%edi),%esi
  34:	8d 5d c8             	lea    -0x38(%ebp),%ebx
  37:	eb 0e                	jmp    47 <main+0x47>
  39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c7 01             	add    $0x1,%edi
  43:	39 f7                	cmp    %esi,%edi
  45:	7f 37                	jg     7e <main+0x7e>
    if(getprocinfo(p, &info) == 0){
  47:	83 ec 08             	sub    $0x8,%esp
  4a:	53                   	push   %ebx
  4b:	57                   	push   %edi
  4c:	e8 62 03 00 00       	call   3b3 <getprocinfo>
  51:	83 c4 10             	add    $0x10,%esp
  54:	85 c0                	test   %eax,%eax
  56:	75 e8                	jne    40 <main+0x40>
      printf(1, "pid=%d name=%s priority=%d ticks=%d\n",
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	8d 45 cc             	lea    -0x34(%ebp),%eax
  5e:	ff 75 e4             	push   -0x1c(%ebp)
  for(int p = pid; p < pid + 20; p++){
  61:	83 c7 01             	add    $0x1,%edi
      printf(1, "pid=%d name=%s priority=%d ticks=%d\n",
  64:	ff 75 e0             	push   -0x20(%ebp)
  67:	50                   	push   %eax
  68:	ff 75 c8             	push   -0x38(%ebp)
  6b:	68 08 08 00 00       	push   $0x808
  70:	6a 01                	push   $0x1
  72:	e8 29 04 00 00       	call   4a0 <printf>
  77:	83 c4 20             	add    $0x20,%esp
  for(int p = pid; p < pid + 20; p++){
  7a:	39 f7                	cmp    %esi,%edi
  7c:	7e c9                	jle    47 <main+0x47>
             info.pid, info.name, info.priority, info.cpu_ticks_total);
    }
  }
  exit();
  7e:	e8 90 02 00 00       	call   313 <exit>
  83:	66 90                	xchg   %ax,%ax
  85:	66 90                	xchg   %ax,%ax
  87:	66 90                	xchg   %ax,%ax
  89:	66 90                	xchg   %ax,%ax
  8b:	66 90                	xchg   %ax,%ax
  8d:	66 90                	xchg   %ax,%ax
  8f:	66 90                	xchg   %ax,%ax
  91:	66 90                	xchg   %ax,%ax
  93:	66 90                	xchg   %ax,%ax
  95:	66 90                	xchg   %ax,%ax
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a1:	31 c0                	xor    %eax,%eax
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	53                   	push   %ebx
  a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  b7:	83 c0 01             	add    $0x1,%eax
  ba:	84 d2                	test   %dl,%dl
  bc:	75 f2                	jne    b0 <strcpy+0x10>
    ;
  return os;
}
  be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c1:	89 c8                	mov    %ecx,%eax
  c3:	c9                   	leave
  c4:	c3                   	ret
  c5:	8d 76 00             	lea    0x0(%esi),%esi
  c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cf:	00 

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
  d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  da:	0f b6 02             	movzbl (%edx),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 2d                	jne    10e <strcmp+0x3e>
  e1:	eb 4a                	jmp    12d <strcmp+0x5d>
  e3:	eb 1b                	jmp    100 <strcmp+0x30>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
  e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ef:	00 
  f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  f7:	00 
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 
 100:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 104:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 107:	84 c0                	test   %al,%al
 109:	74 15                	je     120 <strcmp+0x50>
 10b:	83 c1 01             	add    $0x1,%ecx
 10e:	0f b6 19             	movzbl (%ecx),%ebx
 111:	38 c3                	cmp    %al,%bl
 113:	74 eb                	je     100 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 115:	29 d8                	sub    %ebx,%eax
}
 117:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 11a:	c9                   	leave
 11b:	c3                   	ret
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 120:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 124:	31 c0                	xor    %eax,%eax
 126:	29 d8                	sub    %ebx,%eax
}
 128:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 12b:	c9                   	leave
 12c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	31 c0                	xor    %eax,%eax
 132:	eb e1                	jmp    115 <strcmp+0x45>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 

00000140 <strlen>:

uint
strlen(const char *s)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 146:	80 3a 00             	cmpb   $0x0,(%edx)
 149:	74 15                	je     160 <strlen+0x20>
 14b:	31 c0                	xor    %eax,%eax
 14d:	8d 76 00             	lea    0x0(%esi),%esi
 150:	83 c0 01             	add    $0x1,%eax
 153:	89 c1                	mov    %eax,%ecx
 155:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 159:	75 f5                	jne    150 <strlen+0x10>
    ;
  return n;
}
 15b:	89 c8                	mov    %ecx,%eax
 15d:	5d                   	pop    %ebp
 15e:	c3                   	ret
 15f:	90                   	nop
  for(n = 0; s[n]; n++)
 160:	31 c9                	xor    %ecx,%ecx
}
 162:	5d                   	pop    %ebp
 163:	89 c8                	mov    %ecx,%eax
 165:	c3                   	ret
 166:	66 90                	xchg   %ax,%ax
 168:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16f:	00 

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 174:	8b 4d 10             	mov    0x10(%ebp),%ecx
 177:	8b 45 0c             	mov    0xc(%ebp),%eax
 17a:	8b 7d 08             	mov    0x8(%ebp),%edi
 17d:	fc                   	cld
 17e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	8b 7d fc             	mov    -0x4(%ebp),%edi
 186:	c9                   	leave
 187:	c3                   	ret
 188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18f:	00 

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19a:	0f b6 10             	movzbl (%eax),%edx
 19d:	84 d2                	test   %dl,%dl
 19f:	75 1a                	jne    1bb <strchr+0x2b>
 1a1:	eb 25                	jmp    1c8 <strchr+0x38>
 1a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 
 1b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	84 d2                	test   %dl,%dl
 1b9:	74 0d                	je     1c8 <strchr+0x38>
    if(*s == c)
 1bb:	38 d1                	cmp    %dl,%cl
 1bd:	75 f1                	jne    1b0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1c8:	31 c0                	xor    %eax,%eax
}
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1d5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1d8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1d9:	31 db                	xor    %ebx,%ebx
{
 1db:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1de:	eb 27                	jmp    207 <gets+0x37>
    cc = read(0, &c, 1);
 1e0:	83 ec 04             	sub    $0x4,%esp
 1e3:	6a 01                	push   $0x1
 1e5:	57                   	push   %edi
 1e6:	6a 00                	push   $0x0
 1e8:	e8 3e 01 00 00       	call   32b <read>
    if(cc < 1)
 1ed:	83 c4 10             	add    $0x10,%esp
 1f0:	85 c0                	test   %eax,%eax
 1f2:	7e 1d                	jle    211 <gets+0x41>
      break;
    buf[i++] = c;
 1f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1f8:	8b 55 08             	mov    0x8(%ebp),%edx
 1fb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1ff:	3c 0a                	cmp    $0xa,%al
 201:	74 1d                	je     220 <gets+0x50>
 203:	3c 0d                	cmp    $0xd,%al
 205:	74 19                	je     220 <gets+0x50>
  for(i=0; i+1 < max; ){
 207:	89 de                	mov    %ebx,%esi
 209:	83 c3 01             	add    $0x1,%ebx
 20c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 20f:	7c cf                	jl     1e0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 218:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21b:	5b                   	pop    %ebx
 21c:	5e                   	pop    %esi
 21d:	5f                   	pop    %edi
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret
  buf[i] = '\0';
 220:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 223:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 225:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 229:	8d 65 f4             	lea    -0xc(%ebp),%esp
 22c:	5b                   	pop    %ebx
 22d:	5e                   	pop    %esi
 22e:	5f                   	pop    %edi
 22f:	5d                   	pop    %ebp
 230:	c3                   	ret
 231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23f:	00 

00000240 <stat>:

int
stat(const char *n, struct stat *st)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 245:	83 ec 08             	sub    $0x8,%esp
 248:	6a 00                	push   $0x0
 24a:	ff 75 08             	push   0x8(%ebp)
 24d:	e8 01 01 00 00       	call   353 <open>
  if(fd < 0)
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	78 27                	js     280 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 259:	83 ec 08             	sub    $0x8,%esp
 25c:	ff 75 0c             	push   0xc(%ebp)
 25f:	89 c3                	mov    %eax,%ebx
 261:	50                   	push   %eax
 262:	e8 04 01 00 00       	call   36b <fstat>
  close(fd);
 267:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 26a:	89 c6                	mov    %eax,%esi
  close(fd);
 26c:	e8 ca 00 00 00       	call   33b <close>
  return r;
 271:	83 c4 10             	add    $0x10,%esp
}
 274:	8d 65 f8             	lea    -0x8(%ebp),%esp
 277:	89 f0                	mov    %esi,%eax
 279:	5b                   	pop    %ebx
 27a:	5e                   	pop    %esi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 280:	be ff ff ff ff       	mov    $0xffffffff,%esi
 285:	eb ed                	jmp    274 <stat+0x34>
 287:	90                   	nop
 288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28f:	00 

00000290 <atoi>:

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	53                   	push   %ebx
 294:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	0f be 02             	movsbl (%edx),%eax
 29a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 29d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2a0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2a5:	77 2e                	ja     2d5 <atoi+0x45>
 2a7:	eb 17                	jmp    2c0 <atoi+0x30>
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2b7:	00 
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 
    n = n*10 + *s++ - '0';
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ca:	0f be 02             	movsbl (%edx),%eax
 2cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2d0:	80 fb 09             	cmp    $0x9,%bl
 2d3:	76 eb                	jbe    2c0 <atoi+0x30>
  return n;
}
 2d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2d8:	89 c8                	mov    %ecx,%eax
 2da:	c9                   	leave
 2db:	c3                   	ret
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	8b 45 10             	mov    0x10(%ebp),%eax
 2e7:	8b 55 08             	mov    0x8(%ebp),%edx
 2ea:	56                   	push   %esi
 2eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ee:	85 c0                	test   %eax,%eax
 2f0:	7e 13                	jle    305 <memmove+0x25>
 2f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2f4:	89 d7                	mov    %edx,%edi
 2f6:	66 90                	xchg   %ax,%ax
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    *dst++ = *src++;
 300:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 301:	39 f8                	cmp    %edi,%eax
 303:	75 fb                	jne    300 <memmove+0x20>
  return vdst;
}
 305:	5e                   	pop    %esi
 306:	89 d0                	mov    %edx,%eax
 308:	5f                   	pop    %edi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret

0000030b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30b:	b8 01 00 00 00       	mov    $0x1,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <exit>:
SYSCALL(exit)
 313:	b8 02 00 00 00       	mov    $0x2,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <wait>:
SYSCALL(wait)
 31b:	b8 03 00 00 00       	mov    $0x3,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <pipe>:
SYSCALL(pipe)
 323:	b8 04 00 00 00       	mov    $0x4,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <read>:
SYSCALL(read)
 32b:	b8 05 00 00 00       	mov    $0x5,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <write>:
SYSCALL(write)
 333:	b8 10 00 00 00       	mov    $0x10,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <close>:
SYSCALL(close)
 33b:	b8 15 00 00 00       	mov    $0x15,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <kill>:
SYSCALL(kill)
 343:	b8 06 00 00 00       	mov    $0x6,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <exec>:
SYSCALL(exec)
 34b:	b8 07 00 00 00       	mov    $0x7,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <open>:
SYSCALL(open)
 353:	b8 0f 00 00 00       	mov    $0xf,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <mknod>:
SYSCALL(mknod)
 35b:	b8 11 00 00 00       	mov    $0x11,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <unlink>:
SYSCALL(unlink)
 363:	b8 12 00 00 00       	mov    $0x12,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <fstat>:
SYSCALL(fstat)
 36b:	b8 08 00 00 00       	mov    $0x8,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <link>:
SYSCALL(link)
 373:	b8 13 00 00 00       	mov    $0x13,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <mkdir>:
SYSCALL(mkdir)
 37b:	b8 14 00 00 00       	mov    $0x14,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <chdir>:
SYSCALL(chdir)
 383:	b8 09 00 00 00       	mov    $0x9,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <dup>:
SYSCALL(dup)
 38b:	b8 0a 00 00 00       	mov    $0xa,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <getpid>:
SYSCALL(getpid)
 393:	b8 0b 00 00 00       	mov    $0xb,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <sbrk>:
SYSCALL(sbrk)
 39b:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <sleep>:
SYSCALL(sleep)
 3a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <uptime>:
SYSCALL(uptime)
 3ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <getprocinfo>:
SYSCALL(getprocinfo)
 3b3:	b8 16 00 00 00       	mov    $0x16,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <setpriority>:
SYSCALL(setpriority)
 3bb:	b8 17 00 00 00       	mov    $0x17,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <getpriority>:
SYSCALL(getpriority)
 3c3:	b8 18 00 00 00       	mov    $0x18,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret
 3cb:	66 90                	xchg   %ax,%ax
 3cd:	66 90                	xchg   %ax,%ax
 3cf:	66 90                	xchg   %ax,%ax
 3d1:	66 90                	xchg   %ax,%ax
 3d3:	66 90                	xchg   %ax,%ax
 3d5:	66 90                	xchg   %ax,%ax
 3d7:	66 90                	xchg   %ax,%ax
 3d9:	66 90                	xchg   %ax,%ax
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	89 cb                	mov    %ecx,%ebx
 3e8:	83 ec 3c             	sub    $0x3c,%esp
 3eb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ee:	85 d2                	test   %edx,%edx
 3f0:	0f 89 9a 00 00 00    	jns    490 <printint+0xb0>
 3f6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fa:	0f 84 90 00 00 00    	je     490 <printint+0xb0>
    neg = 1;
    x = -xx;
 400:	f7 da                	neg    %edx
    neg = 1;
 402:	b8 01 00 00 00       	mov    $0x1,%eax
 407:	89 45 c0             	mov    %eax,-0x40(%ebp)
 40a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 40c:	31 f6                	xor    %esi,%esi
 40e:	66 90                	xchg   %ax,%ax
 410:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 417:	00 
 418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41f:	00 
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 f7                	mov    %esi,%edi
 426:	f7 f3                	div    %ebx
 428:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 42b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 42d:	0f b6 92 8c 08 00 00 	movzbl 0x88c(%edx),%edx
  }while((x /= base) != 0);
 434:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 436:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 43a:	73 e4                	jae    420 <printint+0x40>
  if(neg)
 43c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 43f:	85 c0                	test   %eax,%eax
 441:	74 07                	je     44a <printint+0x6a>
    buf[i++] = '-';
 443:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 448:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 44a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 44e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 451:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 
    putc(fd, buf[i]);
 460:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 463:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 466:	83 ee 01             	sub    $0x1,%esi
 469:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 46c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 46f:	6a 01                	push   $0x1
 471:	50                   	push   %eax
 472:	57                   	push   %edi
 473:	e8 bb fe ff ff       	call   333 <write>
  while(--i >= 0)
 478:	83 c4 10             	add    $0x10,%esp
 47b:	39 f3                	cmp    %esi,%ebx
 47d:	75 e1                	jne    460 <printint+0x80>
}
 47f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 482:	5b                   	pop    %ebx
 483:	5e                   	pop    %esi
 484:	5f                   	pop    %edi
 485:	5d                   	pop    %ebp
 486:	c3                   	ret
 487:	90                   	nop
 488:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48f:	00 
  neg = 0;
 490:	31 c0                	xor    %eax,%eax
 492:	e9 70 ff ff ff       	jmp    407 <printint+0x27>
 497:	90                   	nop
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4af:	0f b6 13             	movzbl (%ebx),%edx
 4b2:	83 c3 01             	add    $0x1,%ebx
 4b5:	84 d2                	test   %dl,%dl
 4b7:	0f 84 a0 00 00 00    	je     55d <printf+0xbd>
 4bd:	8d 45 10             	lea    0x10(%ebp),%eax
 4c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 4c3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c6:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4c9:	eb 28                	jmp    4f3 <printf+0x53>
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 4d9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4dc:	6a 01                	push   $0x1
 4de:	50                   	push   %eax
 4df:	56                   	push   %esi
 4e0:	e8 4e fe ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 4e5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4e9:	83 c4 10             	add    $0x10,%esp
 4ec:	84 d2                	test   %dl,%dl
 4ee:	74 6d                	je     55d <printf+0xbd>
    c = fmt[i] & 0xff;
 4f0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 4f3:	83 f8 25             	cmp    $0x25,%eax
 4f6:	75 d8                	jne    4d0 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 4f8:	0f b6 13             	movzbl (%ebx),%edx
 4fb:	84 d2                	test   %dl,%dl
 4fd:	74 5e                	je     55d <printf+0xbd>
    c = fmt[i] & 0xff;
 4ff:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 502:	80 fa 25             	cmp    $0x25,%dl
 505:	0f 84 25 01 00 00    	je     630 <printf+0x190>
 50b:	83 e8 63             	sub    $0x63,%eax
 50e:	83 f8 15             	cmp    $0x15,%eax
 511:	77 0d                	ja     520 <printf+0x80>
 513:	ff 24 85 34 08 00 00 	jmp    *0x834(,%eax,4)
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 526:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 529:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 52d:	6a 01                	push   $0x1
 52f:	51                   	push   %ecx
 530:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 533:	56                   	push   %esi
 534:	e8 fa fd ff ff       	call   333 <write>
        putc(fd, c);
 539:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 53d:	83 c4 0c             	add    $0xc,%esp
 540:	88 55 e7             	mov    %dl,-0x19(%ebp)
 543:	6a 01                	push   $0x1
 545:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 548:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 549:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 54c:	56                   	push   %esi
 54d:	e8 e1 fd ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 552:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 556:	83 c4 10             	add    $0x10,%esp
 559:	84 d2                	test   %dl,%dl
 55b:	75 93                	jne    4f0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 55d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 560:	5b                   	pop    %ebx
 561:	5e                   	pop    %esi
 562:	5f                   	pop    %edi
 563:	5d                   	pop    %ebp
 564:	c3                   	ret
 565:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	8b 17                	mov    (%edi),%edx
 56d:	b9 10 00 00 00       	mov    $0x10,%ecx
 572:	89 f0                	mov    %esi,%eax
 574:	6a 00                	push   $0x0
 576:	e8 65 fe ff ff       	call   3e0 <printint>
  for(i = 0; fmt[i]; i++){
 57b:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 57f:	83 c3 02             	add    $0x2,%ebx
 582:	83 c4 10             	add    $0x10,%esp
 585:	84 d2                	test   %dl,%dl
 587:	74 d4                	je     55d <printf+0xbd>
        ap++;
 589:	83 c7 04             	add    $0x4,%edi
 58c:	e9 5f ff ff ff       	jmp    4f0 <printf+0x50>
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 598:	8b 07                	mov    (%edi),%eax
        ap++;
 59a:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 59d:	85 c0                	test   %eax,%eax
 59f:	0f 84 9b 00 00 00    	je     640 <printf+0x1a0>
        while(*s != 0){
 5a5:	0f b6 10             	movzbl (%eax),%edx
 5a8:	84 d2                	test   %dl,%dl
 5aa:	0f 84 a2 00 00 00    	je     652 <printf+0x1b2>
 5b0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5b3:	89 c7                	mov    %eax,%edi
 5b5:	89 d0                	mov    %edx,%eax
 5b7:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ba:	89 fb                	mov    %edi,%ebx
 5bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5c6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 5c9:	6a 01                	push   $0x1
 5cb:	57                   	push   %edi
 5cc:	56                   	push   %esi
 5cd:	e8 61 fd ff ff       	call   333 <write>
        while(*s != 0){
 5d2:	0f b6 03             	movzbl (%ebx),%eax
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	84 c0                	test   %al,%al
 5da:	75 e4                	jne    5c0 <printf+0x120>
 5dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5e3:	83 c3 02             	add    $0x2,%ebx
 5e6:	84 d2                	test   %dl,%dl
 5e8:	0f 85 d5 fe ff ff    	jne    4c3 <printf+0x23>
 5ee:	e9 6a ff ff ff       	jmp    55d <printf+0xbd>
 5f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5f8:	83 ec 0c             	sub    $0xc,%esp
 5fb:	8b 17                	mov    (%edi),%edx
 5fd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 602:	89 f0                	mov    %esi,%eax
 604:	6a 01                	push   $0x1
 606:	e8 d5 fd ff ff       	call   3e0 <printint>
  for(i = 0; fmt[i]; i++){
 60b:	e9 6b ff ff ff       	jmp    57b <printf+0xdb>
        putc(fd, *ap);
 610:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 612:	83 ec 04             	sub    $0x4,%esp
 615:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 618:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 61b:	6a 01                	push   $0x1
 61d:	51                   	push   %ecx
 61e:	56                   	push   %esi
 61f:	e8 0f fd ff ff       	call   333 <write>
 624:	e9 52 ff ff ff       	jmp    57b <printf+0xdb>
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 630:	83 ec 04             	sub    $0x4,%esp
 633:	88 55 e7             	mov    %dl,-0x19(%ebp)
 636:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 639:	6a 01                	push   $0x1
 63b:	e9 08 ff ff ff       	jmp    548 <printf+0xa8>
          s = "(null)";
 640:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 643:	b8 28 00 00 00       	mov    $0x28,%eax
 648:	bf 2d 08 00 00       	mov    $0x82d,%edi
 64d:	e9 65 ff ff ff       	jmp    5b7 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 652:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 656:	83 c3 02             	add    $0x2,%ebx
 659:	84 d2                	test   %dl,%dl
 65b:	0f 85 8f fe ff ff    	jne    4f0 <printf+0x50>
 661:	e9 f7 fe ff ff       	jmp    55d <printf+0xbd>
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax
 670:	66 90                	xchg   %ax,%ax
 672:	66 90                	xchg   %ax,%ax
 674:	66 90                	xchg   %ax,%ax
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 a0 08 00 00       	mov    0x8a0,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69f:	00 
 6a0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a4:	39 ca                	cmp    %ecx,%edx
 6a6:	73 30                	jae    6d8 <free+0x58>
 6a8:	39 c1                	cmp    %eax,%ecx
 6aa:	72 04                	jb     6b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ac:	39 c2                	cmp    %eax,%edx
 6ae:	72 f0                	jb     6a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6b6:	39 f8                	cmp    %edi,%eax
 6b8:	74 36                	je     6f0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6bd:	8b 42 04             	mov    0x4(%edx),%eax
 6c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	74 40                	je     707 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6c7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6c9:	5b                   	pop    %ebx
  freep = p;
 6ca:	89 15 a0 08 00 00    	mov    %edx,0x8a0
}
 6d0:	5e                   	pop    %esi
 6d1:	5f                   	pop    %edi
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d8:	39 c2                	cmp    %eax,%edx
 6da:	72 c4                	jb     6a0 <free+0x20>
 6dc:	39 c1                	cmp    %eax,%ecx
 6de:	73 c0                	jae    6a0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 6e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6e6:	39 f8                	cmp    %edi,%eax
 6e8:	75 d0                	jne    6ba <free+0x3a>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6f0:	03 70 04             	add    0x4(%eax),%esi
 6f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	8b 02                	mov    (%edx),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6fd:	8b 42 04             	mov    0x4(%edx),%eax
 700:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 c0                	jne    6c7 <free+0x47>
    p->s.size += bp->s.size;
 707:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 70a:	89 15 a0 08 00 00    	mov    %edx,0x8a0
    p->s.size += bp->s.size;
 710:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 713:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 716:	89 0a                	mov    %ecx,(%edx)
}
 718:	5b                   	pop    %ebx
 719:	5e                   	pop    %esi
 71a:	5f                   	pop    %edi
 71b:	5d                   	pop    %ebp
 71c:	c3                   	ret
 71d:	8d 76 00             	lea    0x0(%esi),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 72c:	8b 15 a0 08 00 00    	mov    0x8a0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	8d 78 07             	lea    0x7(%eax),%edi
 735:	c1 ef 03             	shr    $0x3,%edi
 738:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 8d 00 00 00    	je     7d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 745:	8b 48 04             	mov    0x4(%eax),%ecx
 748:	39 f9                	cmp    %edi,%ecx
 74a:	73 64                	jae    7b0 <malloc+0x90>
  if(nu < 4096)
 74c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 751:	39 df                	cmp    %ebx,%edi
 753:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 756:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 75d:	eb 0a                	jmp    769 <malloc+0x49>
 75f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 762:	8b 48 04             	mov    0x4(%eax),%ecx
 765:	39 f9                	cmp    %edi,%ecx
 767:	73 47                	jae    7b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 769:	89 c2                	mov    %eax,%edx
 76b:	39 05 a0 08 00 00    	cmp    %eax,0x8a0
 771:	75 ed                	jne    760 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 773:	83 ec 0c             	sub    $0xc,%esp
 776:	56                   	push   %esi
 777:	e8 1f fc ff ff       	call   39b <sbrk>
  if(p == (char*)-1)
 77c:	83 c4 10             	add    $0x10,%esp
 77f:	83 f8 ff             	cmp    $0xffffffff,%eax
 782:	74 1c                	je     7a0 <malloc+0x80>
  hp->s.size = nu;
 784:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	83 c0 08             	add    $0x8,%eax
 78d:	50                   	push   %eax
 78e:	e8 ed fe ff ff       	call   680 <free>
  return freep;
 793:	8b 15 a0 08 00 00    	mov    0x8a0,%edx
      if((p = morecore(nunits)) == 0)
 799:	83 c4 10             	add    $0x10,%esp
 79c:	85 d2                	test   %edx,%edx
 79e:	75 c0                	jne    760 <malloc+0x40>
        return 0;
  }
}
 7a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7a3:	31 c0                	xor    %eax,%eax
}
 7a5:	5b                   	pop    %ebx
 7a6:	5e                   	pop    %esi
 7a7:	5f                   	pop    %edi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7b0:	39 cf                	cmp    %ecx,%edi
 7b2:	74 4c                	je     800 <malloc+0xe0>
        p->s.size -= nunits;
 7b4:	29 f9                	sub    %edi,%ecx
 7b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7bf:	89 15 a0 08 00 00    	mov    %edx,0x8a0
}
 7c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c8:	83 c0 08             	add    $0x8,%eax
}
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 a0 08 00 00 a4 	movl   $0x8a4,0x8a0
 7d7:	08 00 00 
    base.s.size = 0;
 7da:	b8 a4 08 00 00       	mov    $0x8a4,%eax
    base.s.ptr = freep = prevp = &base;
 7df:	c7 05 a4 08 00 00 a4 	movl   $0x8a4,0x8a4
 7e6:	08 00 00 
    base.s.size = 0;
 7e9:	c7 05 a8 08 00 00 00 	movl   $0x0,0x8a8
 7f0:	00 00 00 
    if(p->s.size >= nunits){
 7f3:	e9 54 ff ff ff       	jmp    74c <malloc+0x2c>
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b9                	jmp    7bf <malloc+0x9f>
