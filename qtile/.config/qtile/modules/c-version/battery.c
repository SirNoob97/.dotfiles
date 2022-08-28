#include <ctype.h>
#include <dirent.h>
#include <libnotify/notify.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CAPACITY_FILE "/sys/class/power_supply/BAT0/capacity"
#define STATUS_FILE "/sys/class/power_supply/BAT0/status"
#define CHARGING_STATE "charging"
#define DISCHARGING_STATE "discharging"
#define FULL_STATE "full"
#define UNKNOWN_STATE "unknown"

static __thread char upbuf[256];

enum battery_percentage {
  THIRTY_PERCENT = 30,
  FOURTY_PERCENT = 40,
  FIFTY_PERCENT = 50,
  SIXTY_PERCENT = 60,
  SEVENTY_PERCENT = 70,
  EIGHTY_PERCENT = 80,
  NINETY_PERCENT = 90,
  ONE_HUNDRED_PERCENT = 100,
};

struct battery {
  int capacity;
  char status[32];
  char icon[2];
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

  if (info.status[0] >= 'A' && info.status[0] <= 'Z')
    info.status[0] = tolower(info.status[0]);

  return info;
}

void set_icon(struct battery *info) {
  if (strcmp(CHARGING_STATE, info->status) == 0) {
    strcpy(info->icon, "ﮣ");
    return;
  }

  if (strcmp(UNKNOWN_STATE, info->status) == 0) {
    strcpy(info->icon, "?");
    return;
  }

  if (strcmp(FULL_STATE, info->status) == 0) {
    strcpy(info->icon, "");
    return;
  }


}

int main() {
  char notification[255];
  struct battery info = fetch_info();

  upbuf[0] = '\0';
  notification[0] = '\0';
  info.icon[0] = '\0';

  set_icon(&info);
  sprintf(upbuf, "%d %s %s", info.capacity, info.status, info.icon);
  printf("%s", upbuf);

  NotifyNotification *notify;
  notify = notify_notification_new("Battery status", upbuf, NULL);
  notify_init("battery");
  notify_notification_show(notify, NULL);

  return 0;
}
