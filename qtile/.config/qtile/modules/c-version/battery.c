#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>

#define CAPACITY_FILE "/sys/class/power_supply/BAT0/capacity"
#define STATUS_FILE "/sys/class/power_supply/BAT0/status"

static __thread char upbuf[256];

int main() {
  upbuf[0] = '\0';
  FILE *capacity;
  if ((capacity = fopen(CAPACITY_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", CAPACITY_FILE);
    exit(EXIT_FAILURE);
  }
  int cap;
  int rc = fscanf(capacity, "%d", &cap);
  fclose(capacity);

  if (rc < 1) {
    printf("Cannot read from file: %s!!!\n", CAPACITY_FILE);
    exit(EXIT_FAILURE);
  }

  printf("%d", cap);

  
  FILE *status;
  if ((status = fopen(STATUS_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", STATUS_FILE);
    exit(EXIT_FAILURE);
  }

  char aux[20];
  rc = fscanf(capacity, "%19s", aux);
  fclose(capacity);

  if (rc < 1) {
    printf("Cannot read from file: %s!!!\n", STATUS_FILE);
    exit(EXIT_FAILURE);
  }

  printf("%s", aux);

  return 0;
}
