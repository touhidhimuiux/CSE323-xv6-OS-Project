#include "types.h"
#include "user.h"
#include "procinfo.h"

int main(int argc, char *argv[])
{
  int pid = 1;
  if(argc > 1) pid = atoi(argv[1]);

  struct procinfo info;
  for(int p = pid; p < pid + 20; p++){
    if(getprocinfo(p, &info) == 0){
      printf(1, "pid=%d name=%s priority=%d ticks=%d\n",
             info.pid, info.name, info.priority, info.cpu_ticks_total);
    }
  }
  exit();
}

