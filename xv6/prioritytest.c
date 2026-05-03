#include "types.h"
#include "user.h"
#include "procinfo.h"

int main(void)
{
  int pids[3];
  int priorities[3] = {10, 5, 1};

  for(int i = 0; i < 3; i++){
    pids[i] = fork();
    if(pids[i] == 0){
      sleep(10); // wait for parent to set priority
      volatile int x = 0;
      for(int j = 0; j < 100000000; j++) x++;
      struct procinfo info;
      getprocinfo(getpid(), &info);
      printf(1, "child %d pid %d priority %d ticks %d done\n",
             i, getpid(), info.priority, info.cpu_ticks_total);
      exit();
    }
  }

  for(int i = 0; i < 3; i++){
    setpriority(pids[i], priorities[i]);
    printf(1, "pid %d priority set to %d\n", pids[i], priorities[i]);
  }

  wait(); wait(); wait();
  exit();
}
