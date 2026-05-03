#include "types.h"
#include "user.h"
#include "procinfo.h"

int main(void)
{
  int pid1, pid2;
  struct procinfo info;

  pid1 = fork();
  if(pid1 == 0){
    // CPU-bound child
    volatile int x = 0;
    for(int i = 0; i < 100000000; i++) x++;
    printf(1, "busy child finished work\n");
    exit();
  }

  pid2 = fork();
  if(pid2 == 0){
    // Sleeping child
    sleep(200);
    exit();
  }

  sleep(50); // give children time to run

  getprocinfo(pid1, &info);
  printf(1, "busy pid %d used %d ticks\n", pid1, info.cpu_ticks_total);

  getprocinfo(pid2, &info);
  printf(1, "sleeping pid %d used %d ticks\n", pid2, info.cpu_ticks_total);

  wait(); wait();
  exit();
}
