#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>

int main(int argc, char **argv) {
  char *fileName = "/proc/loadavg";
  FILE *file = fopen(fileName, "r");

  if (file == NULL) {
    printf("Cannot open file: %s!!!\n", fileName);
    exit(1);
  }

  char c = fgetc(file);
  char output[2] = "";
  char delim = ' ';
  int fields = 3;

  while (c != EOF && fields > 0) {
    if (c == delim) {
      fields--;
    }

    strncat(output, &c, 1);
    c = fgetc(file);
  }

  printf("%s\n", output);

  fclose(file);
  return 0;
}
