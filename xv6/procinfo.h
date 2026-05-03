#include "types.h"

struct procinfo {
  int pid;
  char name[16];
  int state;
  int priority;
  uint cpu_ticks_total;
};
