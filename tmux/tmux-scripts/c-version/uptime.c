// Inspired by https://gitlab.com/procps-ng/procps/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define UPTIME_FILE "/proc/uptime"

static __thread char upbuf[256];

void get_uptime(double *restrict uptime_secs) {
  FILE *fp;
  if ((fp = fopen(UPTIME_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", UPTIME_FILE);
    exit(1);
  }

  double up = 0, idle = 0;
  int rc = fscanf(fp, "%lf %lf", &up, &idle);
  fclose(fp);

  if (rc < 2) {
    printf("Cannot read from file: %s!!!\n", UPTIME_FILE);
    exit(1);
  }

  if (uptime_secs)
    *uptime_secs = up;
}

int main(int argc, char *argv[]) {
  upbuf[0] = '\0';

  time_t realseconds;
  if (time(&realseconds) < 0) {
    printf("'time' function retrieve: %ld!!!\n", realseconds);
    exit(1);
  }

  double uptime_secs;
  get_uptime(&uptime_secs);

  int updays = ((int)uptime_secs / (60 * 60 * 24));
  int uphours = ((int)uptime_secs / (60 * 60)) % 24;
  int upminutes = ((int)uptime_secs / (60)) % 60;
  int position = sprintf(upbuf, "up ");

  if (updays)
    position += sprintf(upbuf + position, "%d %s", updays,
                        (updays > 1) ? "days" : "day");

  if (uphours)
    position += sprintf(upbuf + position, "%2d:%02d", uphours, upminutes);
  else
    position += sprintf(upbuf + position, "%d min", upminutes);

  printf("%s", upbuf);

  return 0;
}
