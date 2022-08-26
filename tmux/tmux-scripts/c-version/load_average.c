#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LOADAVG_FILE "/proc/loadavg"

int main(int argc, char **argv) {
  FILE *file;

  if ((file = fopen(LOADAVG_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", LOADAVG_FILE);
    exit(EXIT_FAILURE);
  }
  double av1, av5, av15;
  int rc = fscanf(file, "%lf %lf %lf", &av1, &av5, &av15);
  fclose(file);

  if (rc < 2) {
    printf("Cannot read from file: %s!!!\n", LOADAVG_FILE);
    exit(EXIT_FAILURE);
  }

  printf("%.2f %.2f %.2f", av1, av5, av15);

  return 0;
}
