#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LOADAVG_FILE "/proc/loadavg"

int main(int argc, char **argv) {
  FILE *file;

  if ((file = fopen(LOADAVG_FILE, "r")) == NULL) {
    printf("Cannot open file: %s!!!\n", LOADAVG_FILE);
    exit(1);
  }

  char c = fgetc(file);
  char output[2] = "";
  char delim = ' ';
  int fields = 3;

  while (c != EOF && fields > 0) {
    if (c == delim)
      fields--;

    strncat(output, &c, 1);
    c = fgetc(file);
  }

  printf("%s\n", output);

  fclose(file);
  return 0;
}
