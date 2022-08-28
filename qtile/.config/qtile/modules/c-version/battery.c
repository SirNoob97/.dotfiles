#include <ctype.h>
#include <dirent.h>
#include <libnotify/notification.h>
#include <libnotify/notify.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CAPACITY_FILE "/sys/class/power_supply/BAT0/capacity"
#define STATUS_FILE "/sys/class/power_supply/BAT0/status"
#define CHARGING_STATE "charging"
#define DISCHARGING_STATE "discharging"
#define FULL_STATE "full"

enum battery_percentage {
  TWELVE_PERCENT = 12,
  TWENTY_PERCENT = 20,
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

void send_notification(int current_capacity) {
  notify_init(__FILE__);
  notify_set_app_name(__FILE__);

  NotifyNotification *notify;
  notify = notify_notification_new("Low Battery", "Battery level below 12%", NULL);
  notify_notification_set_timeout(notify, 10000);
  notify_notification_set_category(notify, "Power Monitoring");
  notify_notification_set_urgency(notify, NOTIFY_URGENCY_NORMAL);
  notify_notification_show(notify, NULL);
}

char *set_icon(struct battery *info) {
  if (strcmp(CHARGING_STATE, info->status) == 0)
    return "ﮣ";

  if (strcmp(FULL_STATE, info->status) == 0)
    return "";

  if (ONE_HUNDRED_PERCENT > info->capacity && (NINETY_PERCENT - 1) < info->capacity) return "";
  if (NINETY_PERCENT > info->capacity && (EIGHTY_PERCENT - 1) < info->capacity) return "";
  if (EIGHTY_PERCENT > info->capacity && (SEVENTY_PERCENT - 1) < info->capacity) return "";
  if (SEVENTY_PERCENT > info->capacity && (SIXTY_PERCENT - 1) < info->capacity) return "";
  if (SIXTY_PERCENT > info->capacity && (FIFTY_PERCENT - 1) < info->capacity) return "";
  if (FIFTY_PERCENT > info->capacity && (FOURTY_PERCENT - 1) < info->capacity) return "";
  if (FOURTY_PERCENT > info->capacity && (THIRTY_PERCENT - 1) < info->capacity) return "";
  if (THIRTY_PERCENT > info->capacity && (TWENTY_PERCENT - 1) < info->capacity) return "";

  if (TWENTY_PERCENT > info->capacity) {
    send_notification(info->capacity);
    return "";
  }

  return "?";
}

int main(int argc, char *argv[]) {
  struct battery info = fetch_info();

  info.icon[0] = '\0';

  strcpy(info.icon, set_icon(&info));

  printf("%d%% %s", info.capacity, info.icon);

  return 0;
}
