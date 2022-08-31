#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  char host[HOST_NAME_MAX + 1];

  if (gethostname(host, sizeof(host)) != 0) {
    printf("Cant retrieve hostname!!!");
    exit(EXIT_FAILURE);
  }

  printf("%s", host);

  return 0;
}
