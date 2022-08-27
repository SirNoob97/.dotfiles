#include <bits/types/__locale_t.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CAPACITY_FILE "/sys/class/power_supply/BAT0/capacity"
#define STATUS_FILE "/sys/class/power_supply/BAT0/status"

static __thread char upbuf[256];

struct battery {
  int capacity;
  char status[32];
};

struct battery fetch_info() {
  struct battery info = {.capacity = 0, .status[0] = '\0'};

  FILE *fcap;
  if ((fcap = fopen(CAPACITY_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", CAPACITY_FILE);
    exit(EXIT_FAILURE);
  }

  int rc = fscanf(fcap, "%d", &info.capacity);
  fclose(fcap);

  if (rc < 1) {
    printf("Cannot read from file: %s!!!\n", CAPACITY_FILE);
    exit(EXIT_FAILURE);
  }

  FILE *fstat;
  if ((fstat = fopen(STATUS_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", STATUS_FILE);
    exit(EXIT_FAILURE);
  }

  rc = fscanf(fstat, "%31s", info.status);
  fclose(fstat);

  if (rc < 1) {
    printf("Cannot read from file: %s!!!\n", STATUS_FILE);
    exit(EXIT_FAILURE);
  }

  return info;
}

int main() {
  upbuf[0] = '\0';
  char notification[255];
  notification[0] = '\0';
  struct battery info = fetch_info();

  sprintf(upbuf, "%d %s", info.capacity, info.status);
  printf("%s", upbuf);

  sprintf(notification, "notify-send -u normal -t 10000 'battery' 'battery level: %s'", upbuf);
  system(notification);

  return 0;
}
