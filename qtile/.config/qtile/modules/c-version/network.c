/* Inspired by
 * https://gist.github.com/edufelipe/6108057
 */

#include <ifaddrs.h>
#include <linux/wireless.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

int check_wireless(const char *ifname, char *protocol) {
  int sock = -1;
  struct iwreq pwrq;
  memset(&pwrq, 0, sizeof(pwrq));
  memcpy(pwrq.ifr_name, ifname, IFNAMSIZ);

  if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
    printf("Cant create a socket for the domain: %d", AF_INET);
    exit(EXIT_FAILURE);
  }

  if (ioctl(sock, SIOCGIWNAME, &pwrq) != -1) {
    if (protocol)
      strncpy(protocol, pwrq.u.name, IFNAMSIZ);
    close(sock);
    return 1;
  }

  close(sock);
  return 0;
}

int main(int argc, char *argv[]) {
  struct ifaddrs *ifaddrs, *ifadd;

  if (getifaddrs(&ifaddrs) == -1) {
    printf("Cant get interface addresses list");
    exit(EXIT_FAILURE);
  }

  for (ifadd = ifaddrs; ifadd != NULL; ifadd = ifadd->ifa_next) {
    char protocol[IFNAMSIZ] = {0};
    int family = ifadd->ifa_addr->sa_family;

    /* IPv6 can be checked using AF_INET6 */
    if (family == AF_INET && strcmp(ifadd->ifa_name, "lo") != 0) {
      if (check_wireless(ifadd->ifa_name, protocol)) {
        printf("直");
      } else {
        printf("");
      }
    }
  }

  freeifaddrs(ifaddrs);
  return 0;
}
