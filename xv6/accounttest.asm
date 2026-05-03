
_accounttest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "procinfo.h"

int main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2;
  struct procinfo info;

  pid1 = fork();
  13:	e8 33 03 00 00       	call   34b <fork>
  if(pid1 == 0){
  18:	85 c0                	test   %eax,%eax
  1a:	75 36                	jne    52 <main+0x52>
    // CPU-bound child
    volatile int x = 0;
  1c:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  23:	ba 00 e1 f5 05       	mov    $0x5f5e100,%edx
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
    for(int i = 0; i < 100000000; i++) x++;
  30:	8b 45 c8             	mov    -0x38(%ebp),%eax
  33:	83 c0 01             	add    $0x1,%eax
  36:	89 45 c8             	mov    %eax,-0x38(%ebp)
  39:	83 ea 01             	sub    $0x1,%edx
  3c:	75 f2                	jne    30 <main+0x30>
    printf(1, "busy child finished work\n");
  3e:	83 ec 08             	sub    $0x8,%esp
  41:	68 48 08 00 00       	push   $0x848
  46:	6a 01                	push   $0x1
  48:	e8 93 04 00 00       	call   4e0 <printf>
    exit();
  4d:	e8 01 03 00 00       	call   353 <exit>
  52:	89 c3                	mov    %eax,%ebx
  }

  pid2 = fork();
  54:	e8 f2 02 00 00       	call   34b <fork>
  59:	89 c6                	mov    %eax,%esi
  if(pid2 == 0){
  5b:	85 c0                	test   %eax,%eax
  5d:	75 12                	jne    71 <main+0x71>
    // Sleeping child
    sleep(200);
  5f:	83 ec 0c             	sub    $0xc,%esp
  62:	68 c8 00 00 00       	push   $0xc8
  67:	e8 77 03 00 00       	call   3e3 <sleep>
    exit();
  6c:	e8 e2 02 00 00       	call   353 <exit>
  }

  sleep(50); // give children time to run
  71:	83 ec 0c             	sub    $0xc,%esp
  74:	6a 32                	push   $0x32
  76:	e8 68 03 00 00       	call   3e3 <sleep>

  getprocinfo(pid1, &info);
  7b:	58                   	pop    %eax
  7c:	5a                   	pop    %edx
  7d:	8d 55 c8             	lea    -0x38(%ebp),%edx
  80:	52                   	push   %edx
  81:	53                   	push   %ebx
  82:	e8 6c 03 00 00       	call   3f3 <getprocinfo>
  printf(1, "busy pid %d used %d ticks\n", pid1, info.cpu_ticks_total);
  87:	ff 75 e4             	push   -0x1c(%ebp)
  8a:	53                   	push   %ebx
  8b:	68 62 08 00 00       	push   $0x862
  90:	6a 01                	push   $0x1
  92:	e8 49 04 00 00       	call   4e0 <printf>

  getprocinfo(pid2, &info);
  97:	83 c4 18             	add    $0x18,%esp
  9a:	8d 55 c8             	lea    -0x38(%ebp),%edx
  9d:	52                   	push   %edx
  9e:	56                   	push   %esi
  9f:	e8 4f 03 00 00       	call   3f3 <getprocinfo>
  printf(1, "sleeping pid %d used %d ticks\n", pid2, info.cpu_ticks_total);
  a4:	ff 75 e4             	push   -0x1c(%ebp)
  a7:	56                   	push   %esi
  a8:	68 84 08 00 00       	push   $0x884
  ad:	6a 01                	push   $0x1
  af:	e8 2c 04 00 00       	call   4e0 <printf>

  wait(); wait();
  b4:	83 c4 20             	add    $0x20,%esp
  b7:	e8 9f 02 00 00       	call   35b <wait>
  bc:	e8 9a 02 00 00       	call   35b <wait>
  exit();
  c1:	e8 8d 02 00 00       	call   353 <exit>
  c6:	66 90                	xchg   %ax,%ax
  c8:	66 90                	xchg   %ax,%ax
  ca:	66 90                	xchg   %ax,%ax
  cc:	66 90                	xchg   %ax,%ax
  ce:	66 90                	xchg   %ax,%ax
  d0:	66 90                	xchg   %ax,%ax
  d2:	66 90                	xchg   %ax,%ax
  d4:	66 90                	xchg   %ax,%ax
  d6:	66 90                	xchg   %ax,%ax
  d8:	66 90                	xchg   %ax,%ax
  da:	66 90                	xchg   %ax,%ax
  dc:	66 90                	xchg   %ax,%ax
  de:	66 90                	xchg   %ax,%ax

000000e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e1:	31 c0                	xor    %eax,%eax
{
  e3:	89 e5                	mov    %esp,%ebp
  e5:	53                   	push   %ebx
  e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  f7:	83 c0 01             	add    $0x1,%eax
  fa:	84 d2                	test   %dl,%dl
  fc:	75 f2                	jne    f0 <strcpy+0x10>
    ;
  return os;
}
  fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 101:	89 c8                	mov    %ecx,%eax
 103:	c9                   	leave
 104:	c3                   	ret
 105:	8d 76 00             	lea    0x0(%esi),%esi
 108:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10f:	00 

00000110 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 55 08             	mov    0x8(%ebp),%edx
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 11a:	0f b6 02             	movzbl (%edx),%eax
 11d:	84 c0                	test   %al,%al
 11f:	75 2d                	jne    14e <strcmp+0x3e>
 121:	eb 4a                	jmp    16d <strcmp+0x5d>
 123:	eb 1b                	jmp    140 <strcmp+0x30>
 125:	8d 76 00             	lea    0x0(%esi),%esi
 128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12f:	00 
 130:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 137:	00 
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
 140:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 144:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 147:	84 c0                	test   %al,%al
 149:	74 15                	je     160 <strcmp+0x50>
 14b:	83 c1 01             	add    $0x1,%ecx
 14e:	0f b6 19             	movzbl (%ecx),%ebx
 151:	38 c3                	cmp    %al,%bl
 153:	74 eb                	je     140 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 155:	29 d8                	sub    %ebx,%eax
}
 157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 15a:	c9                   	leave
 15b:	c3                   	ret
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 160:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 164:	31 c0                	xor    %eax,%eax
 166:	29 d8                	sub    %ebx,%eax
}
 168:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 16b:	c9                   	leave
 16c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 16d:	0f b6 19             	movzbl (%ecx),%ebx
 170:	31 c0                	xor    %eax,%eax
 172:	eb e1                	jmp    155 <strcmp+0x45>
 174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 178:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17f:	00 

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 3a 00             	cmpb   $0x0,(%edx)
 189:	74 15                	je     1a0 <strlen+0x20>
 18b:	31 c0                	xor    %eax,%eax
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	83 c0 01             	add    $0x1,%eax
 193:	89 c1                	mov    %eax,%ecx
 195:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 199:	75 f5                	jne    190 <strlen+0x10>
    ;
  return n;
}
 19b:	89 c8                	mov    %ecx,%eax
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret
 19f:	90                   	nop
  for(n = 0; s[n]; n++)
 1a0:	31 c9                	xor    %ecx,%ecx
}
 1a2:	5d                   	pop    %ebp
 1a3:	89 c8                	mov    %ecx,%eax
 1a5:	c3                   	ret
 1a6:	66 90                	xchg   %ax,%ax
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ba:	8b 7d 08             	mov    0x8(%ebp),%edi
 1bd:	fc                   	cld
 1be:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1c6:	c9                   	leave
 1c7:	c3                   	ret
 1c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cf:	00 

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	75 1a                	jne    1fb <strchr+0x2b>
 1e1:	eb 25                	jmp    208 <strchr+0x38>
 1e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ef:	00 
 1f0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	84 d2                	test   %dl,%dl
 1f9:	74 0d                	je     208 <strchr+0x38>
    if(*s == c)
 1fb:	38 d1                	cmp    %dl,%cl
 1fd:	75 f1                	jne    1f0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 208:	31 c0                	xor    %eax,%eax
}
 20a:	5d                   	pop    %ebp
 20b:	c3                   	ret
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 215:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 218:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 219:	31 db                	xor    %ebx,%ebx
{
 21b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 21e:	eb 27                	jmp    247 <gets+0x37>
    cc = read(0, &c, 1);
 220:	83 ec 04             	sub    $0x4,%esp
 223:	6a 01                	push   $0x1
 225:	57                   	push   %edi
 226:	6a 00                	push   $0x0
 228:	e8 3e 01 00 00       	call   36b <read>
    if(cc < 1)
 22d:	83 c4 10             	add    $0x10,%esp
 230:	85 c0                	test   %eax,%eax
 232:	7e 1d                	jle    251 <gets+0x41>
      break;
    buf[i++] = c;
 234:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 238:	8b 55 08             	mov    0x8(%ebp),%edx
 23b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 23f:	3c 0a                	cmp    $0xa,%al
 241:	74 1d                	je     260 <gets+0x50>
 243:	3c 0d                	cmp    $0xd,%al
 245:	74 19                	je     260 <gets+0x50>
  for(i=0; i+1 < max; ){
 247:	89 de                	mov    %ebx,%esi
 249:	83 c3 01             	add    $0x1,%ebx
 24c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 24f:	7c cf                	jl     220 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 258:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25b:	5b                   	pop    %ebx
 25c:	5e                   	pop    %esi
 25d:	5f                   	pop    %edi
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret
  buf[i] = '\0';
 260:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 263:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 265:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 269:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26c:	5b                   	pop    %ebx
 26d:	5e                   	pop    %esi
 26e:	5f                   	pop    %edi
 26f:	5d                   	pop    %ebp
 270:	c3                   	ret
 271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27f:	00 

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	push   0x8(%ebp)
 28d:	e8 01 01 00 00       	call   393 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	push   0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 04 01 00 00       	call   3ab <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 ca 00 00 00       	call   37b <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	90                   	nop
 2c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cf:	00 

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 02             	movsbl (%edx),%eax
 2da:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2dd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2e0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2e5:	77 2e                	ja     315 <atoi+0x45>
 2e7:	eb 17                	jmp    300 <atoi+0x30>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2f7:	00 
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x30>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	8b 55 08             	mov    0x8(%ebp),%edx
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	66 90                	xchg   %ax,%ax
 338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33f:	00 
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <getprocinfo>:
SYSCALL(getprocinfo)
 3f3:	b8 16 00 00 00       	mov    $0x16,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <setpriority>:
SYSCALL(setpriority)
 3fb:	b8 17 00 00 00       	mov    $0x17,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <getpriority>:
SYSCALL(getpriority)
 403:	b8 18 00 00 00       	mov    $0x18,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	66 90                	xchg   %ax,%ax
 411:	66 90                	xchg   %ax,%ax
 413:	66 90                	xchg   %ax,%ax
 415:	66 90                	xchg   %ax,%ax
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
 428:	83 ec 3c             	sub    $0x3c,%esp
 42b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42e:	85 d2                	test   %edx,%edx
 430:	0f 89 9a 00 00 00    	jns    4d0 <printint+0xb0>
 436:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43a:	0f 84 90 00 00 00    	je     4d0 <printint+0xb0>
    neg = 1;
    x = -xx;
 440:	f7 da                	neg    %edx
    neg = 1;
 442:	b8 01 00 00 00       	mov    $0x1,%eax
 447:	89 45 c0             	mov    %eax,-0x40(%ebp)
 44a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 44c:	31 f6                	xor    %esi,%esi
 44e:	66 90                	xchg   %ax,%ax
 450:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 457:	00 
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 
  do{
    buf[i++] = digits[x % base];
 460:	89 c8                	mov    %ecx,%eax
 462:	31 d2                	xor    %edx,%edx
 464:	89 f7                	mov    %esi,%edi
 466:	f7 f3                	div    %ebx
 468:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 46b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 46d:	0f b6 92 fc 08 00 00 	movzbl 0x8fc(%edx),%edx
  }while((x /= base) != 0);
 474:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 476:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 47a:	73 e4                	jae    460 <printint+0x40>
  if(neg)
 47c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 47f:	85 c0                	test   %eax,%eax
 481:	74 07                	je     48a <printint+0x6a>
    buf[i++] = '-';
 483:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 488:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 48a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 48e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 491:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
    putc(fd, buf[i]);
 4a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4a3:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 4a6:	83 ee 01             	sub    $0x1,%esi
 4a9:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 4ac:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4af:	6a 01                	push   $0x1
 4b1:	50                   	push   %eax
 4b2:	57                   	push   %edi
 4b3:	e8 bb fe ff ff       	call   373 <write>
  while(--i >= 0)
 4b8:	83 c4 10             	add    $0x10,%esp
 4bb:	39 f3                	cmp    %esi,%ebx
 4bd:	75 e1                	jne    4a0 <printint+0x80>
}
 4bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c2:	5b                   	pop    %ebx
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret
 4c7:	90                   	nop
 4c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4cf:	00 
  neg = 0;
 4d0:	31 c0                	xor    %eax,%eax
 4d2:	e9 70 ff ff ff       	jmp    447 <printint+0x27>
 4d7:	90                   	nop
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 

000004e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4ef:	0f b6 13             	movzbl (%ebx),%edx
 4f2:	83 c3 01             	add    $0x1,%ebx
 4f5:	84 d2                	test   %dl,%dl
 4f7:	0f 84 a0 00 00 00    	je     59d <printf+0xbd>
 4fd:	8d 45 10             	lea    0x10(%ebp),%eax
 500:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 503:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 506:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 509:	eb 28                	jmp    533 <printf+0x53>
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	8d 45 e7             	lea    -0x19(%ebp),%eax
 516:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 519:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 51c:	6a 01                	push   $0x1
 51e:	50                   	push   %eax
 51f:	56                   	push   %esi
 520:	e8 4e fe ff ff       	call   373 <write>
  for(i = 0; fmt[i]; i++){
 525:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 529:	83 c4 10             	add    $0x10,%esp
 52c:	84 d2                	test   %dl,%dl
 52e:	74 6d                	je     59d <printf+0xbd>
    c = fmt[i] & 0xff;
 530:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 533:	83 f8 25             	cmp    $0x25,%eax
 536:	75 d8                	jne    510 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 538:	0f b6 13             	movzbl (%ebx),%edx
 53b:	84 d2                	test   %dl,%dl
 53d:	74 5e                	je     59d <printf+0xbd>
    c = fmt[i] & 0xff;
 53f:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 542:	80 fa 25             	cmp    $0x25,%dl
 545:	0f 84 25 01 00 00    	je     670 <printf+0x190>
 54b:	83 e8 63             	sub    $0x63,%eax
 54e:	83 f8 15             	cmp    $0x15,%eax
 551:	77 0d                	ja     560 <printf+0x80>
 553:	ff 24 85 a4 08 00 00 	jmp    *0x8a4(,%eax,4)
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 566:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 569:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 56d:	6a 01                	push   $0x1
 56f:	51                   	push   %ecx
 570:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 573:	56                   	push   %esi
 574:	e8 fa fd ff ff       	call   373 <write>
        putc(fd, c);
 579:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 57d:	83 c4 0c             	add    $0xc,%esp
 580:	88 55 e7             	mov    %dl,-0x19(%ebp)
 583:	6a 01                	push   $0x1
 585:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 588:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 589:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 58c:	56                   	push   %esi
 58d:	e8 e1 fd ff ff       	call   373 <write>
  for(i = 0; fmt[i]; i++){
 592:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 596:	83 c4 10             	add    $0x10,%esp
 599:	84 d2                	test   %dl,%dl
 59b:	75 93                	jne    530 <printf+0x50>
      }
      state = 0;
    }
  }
}
 59d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a0:	5b                   	pop    %ebx
 5a1:	5e                   	pop    %esi
 5a2:	5f                   	pop    %edi
 5a3:	5d                   	pop    %ebp
 5a4:	c3                   	ret
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5a8:	83 ec 0c             	sub    $0xc,%esp
 5ab:	8b 17                	mov    (%edi),%edx
 5ad:	b9 10 00 00 00       	mov    $0x10,%ecx
 5b2:	89 f0                	mov    %esi,%eax
 5b4:	6a 00                	push   $0x0
 5b6:	e8 65 fe ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 5bb:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 5bf:	83 c3 02             	add    $0x2,%ebx
 5c2:	83 c4 10             	add    $0x10,%esp
 5c5:	84 d2                	test   %dl,%dl
 5c7:	74 d4                	je     59d <printf+0xbd>
        ap++;
 5c9:	83 c7 04             	add    $0x4,%edi
 5cc:	e9 5f ff ff ff       	jmp    530 <printf+0x50>
 5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5d8:	8b 07                	mov    (%edi),%eax
        ap++;
 5da:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 5dd:	85 c0                	test   %eax,%eax
 5df:	0f 84 9b 00 00 00    	je     680 <printf+0x1a0>
        while(*s != 0){
 5e5:	0f b6 10             	movzbl (%eax),%edx
 5e8:	84 d2                	test   %dl,%dl
 5ea:	0f 84 a2 00 00 00    	je     692 <printf+0x1b2>
 5f0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5f3:	89 c7                	mov    %eax,%edi
 5f5:	89 d0                	mov    %edx,%eax
 5f7:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5fa:	89 fb                	mov    %edi,%ebx
 5fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5ff:	90                   	nop
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 606:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 609:	6a 01                	push   $0x1
 60b:	57                   	push   %edi
 60c:	56                   	push   %esi
 60d:	e8 61 fd ff ff       	call   373 <write>
        while(*s != 0){
 612:	0f b6 03             	movzbl (%ebx),%eax
 615:	83 c4 10             	add    $0x10,%esp
 618:	84 c0                	test   %al,%al
 61a:	75 e4                	jne    600 <printf+0x120>
 61c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 61f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 623:	83 c3 02             	add    $0x2,%ebx
 626:	84 d2                	test   %dl,%dl
 628:	0f 85 d5 fe ff ff    	jne    503 <printf+0x23>
 62e:	e9 6a ff ff ff       	jmp    59d <printf+0xbd>
 633:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 638:	83 ec 0c             	sub    $0xc,%esp
 63b:	8b 17                	mov    (%edi),%edx
 63d:	b9 0a 00 00 00       	mov    $0xa,%ecx
 642:	89 f0                	mov    %esi,%eax
 644:	6a 01                	push   $0x1
 646:	e8 d5 fd ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 64b:	e9 6b ff ff ff       	jmp    5bb <printf+0xdb>
        putc(fd, *ap);
 650:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 652:	83 ec 04             	sub    $0x4,%esp
 655:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 658:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 65b:	6a 01                	push   $0x1
 65d:	51                   	push   %ecx
 65e:	56                   	push   %esi
 65f:	e8 0f fd ff ff       	call   373 <write>
 664:	e9 52 ff ff ff       	jmp    5bb <printf+0xdb>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 55 e7             	mov    %dl,-0x19(%ebp)
 676:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 679:	6a 01                	push   $0x1
 67b:	e9 08 ff ff ff       	jmp    588 <printf+0xa8>
          s = "(null)";
 680:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 683:	b8 28 00 00 00       	mov    $0x28,%eax
 688:	bf 7d 08 00 00       	mov    $0x87d,%edi
 68d:	e9 65 ff ff ff       	jmp    5f7 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 692:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 696:	83 c3 02             	add    $0x2,%ebx
 699:	84 d2                	test   %dl,%dl
 69b:	0f 85 8f fe ff ff    	jne    530 <printf+0x50>
 6a1:	e9 f7 fe ff ff       	jmp    59d <printf+0xbd>
 6a6:	66 90                	xchg   %ax,%ax
 6a8:	66 90                	xchg   %ax,%ax
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	66 90                	xchg   %ax,%ax
 6b2:	66 90                	xchg   %ax,%ax
 6b4:	66 90                	xchg   %ax,%ax
 6b6:	66 90                	xchg   %ax,%ax
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 10 09 00 00       	mov    0x910,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6df:	00 
 6e0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e4:	39 ca                	cmp    %ecx,%edx
 6e6:	73 30                	jae    718 <free+0x58>
 6e8:	39 c1                	cmp    %eax,%ecx
 6ea:	72 04                	jb     6f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ec:	39 c2                	cmp    %eax,%edx
 6ee:	72 f0                	jb     6e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f6:	39 f8                	cmp    %edi,%eax
 6f8:	74 36                	je     730 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6fa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fd:	8b 42 04             	mov    0x4(%edx),%eax
 700:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	74 40                	je     747 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 707:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 709:	5b                   	pop    %ebx
  freep = p;
 70a:	89 15 10 09 00 00    	mov    %edx,0x910
}
 710:	5e                   	pop    %esi
 711:	5f                   	pop    %edi
 712:	5d                   	pop    %ebp
 713:	c3                   	ret
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 c2                	cmp    %eax,%edx
 71a:	72 c4                	jb     6e0 <free+0x20>
 71c:	39 c1                	cmp    %eax,%ecx
 71e:	73 c0                	jae    6e0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 720:	8b 73 fc             	mov    -0x4(%ebx),%esi
 723:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 726:	39 f8                	cmp    %edi,%eax
 728:	75 d0                	jne    6fa <free+0x3a>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 730:	03 70 04             	add    0x4(%eax),%esi
 733:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 736:	8b 02                	mov    (%edx),%eax
 738:	8b 00                	mov    (%eax),%eax
 73a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 73d:	8b 42 04             	mov    0x4(%edx),%eax
 740:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 743:	39 f1                	cmp    %esi,%ecx
 745:	75 c0                	jne    707 <free+0x47>
    p->s.size += bp->s.size;
 747:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 74a:	89 15 10 09 00 00    	mov    %edx,0x910
    p->s.size += bp->s.size;
 750:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 753:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 756:	89 0a                	mov    %ecx,(%edx)
}
 758:	5b                   	pop    %ebx
 759:	5e                   	pop    %esi
 75a:	5f                   	pop    %edi
 75b:	5d                   	pop    %ebp
 75c:	c3                   	ret
 75d:	8d 76 00             	lea    0x0(%esi),%esi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 15 10 09 00 00    	mov    0x910,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 78 07             	lea    0x7(%eax),%edi
 775:	c1 ef 03             	shr    $0x3,%edi
 778:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77b:	85 d2                	test   %edx,%edx
 77d:	0f 84 8d 00 00 00    	je     810 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 785:	8b 48 04             	mov    0x4(%eax),%ecx
 788:	39 f9                	cmp    %edi,%ecx
 78a:	73 64                	jae    7f0 <malloc+0x90>
  if(nu < 4096)
 78c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 791:	39 df                	cmp    %ebx,%edi
 793:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 796:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 79d:	eb 0a                	jmp    7a9 <malloc+0x49>
 79f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 48 04             	mov    0x4(%eax),%ecx
 7a5:	39 f9                	cmp    %edi,%ecx
 7a7:	73 47                	jae    7f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a9:	89 c2                	mov    %eax,%edx
 7ab:	39 05 10 09 00 00    	cmp    %eax,0x910
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7b3:	83 ec 0c             	sub    $0xc,%esp
 7b6:	56                   	push   %esi
 7b7:	e8 1f fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 7bc:	83 c4 10             	add    $0x10,%esp
 7bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c2:	74 1c                	je     7e0 <malloc+0x80>
  hp->s.size = nu;
 7c4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7c7:	83 ec 0c             	sub    $0xc,%esp
 7ca:	83 c0 08             	add    $0x8,%eax
 7cd:	50                   	push   %eax
 7ce:	e8 ed fe ff ff       	call   6c0 <free>
  return freep;
 7d3:	8b 15 10 09 00 00    	mov    0x910,%edx
      if((p = morecore(nunits)) == 0)
 7d9:	83 c4 10             	add    $0x10,%esp
 7dc:	85 d2                	test   %edx,%edx
 7de:	75 c0                	jne    7a0 <malloc+0x40>
        return 0;
  }
}
 7e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7e3:	31 c0                	xor    %eax,%eax
}
 7e5:	5b                   	pop    %ebx
 7e6:	5e                   	pop    %esi
 7e7:	5f                   	pop    %edi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f0:	39 cf                	cmp    %ecx,%edi
 7f2:	74 4c                	je     840 <malloc+0xe0>
        p->s.size -= nunits;
 7f4:	29 f9                	sub    %edi,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7ff:	89 15 10 09 00 00    	mov    %edx,0x910
}
 805:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 808:	83 c0 08             	add    $0x8,%eax
}
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 810:	c7 05 10 09 00 00 14 	movl   $0x914,0x910
 817:	09 00 00 
    base.s.size = 0;
 81a:	b8 14 09 00 00       	mov    $0x914,%eax
    base.s.ptr = freep = prevp = &base;
 81f:	c7 05 14 09 00 00 14 	movl   $0x914,0x914
 826:	09 00 00 
    base.s.size = 0;
 829:	c7 05 18 09 00 00 00 	movl   $0x0,0x918
 830:	00 00 00 
    if(p->s.size >= nunits){
 833:	e9 54 ff ff ff       	jmp    78c <malloc+0x2c>
 838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83f:	00 
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b9                	jmp    7ff <malloc+0x9f>
