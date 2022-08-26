#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  time_t rawtime = time(0);
  struct tm *timeinfo = localtime(&rawtime);

  if (rawtime == -1 || timeinfo == NULL) {
    printf("Failure to obtain the current time!!!");
    exit(EXIT_FAILURE);
  }

  printf("%d-%02d-%02d %02d:%02d", timeinfo->tm_year + 1900,
         timeinfo->tm_mon + 1, timeinfo->tm_mday, timeinfo->tm_hour,
         timeinfo->tm_min);

  return 0;
}
