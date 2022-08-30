SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:

ifeq ($(origin .RECIPEPREFIX), undefined)
	$(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

CC = gcc
CFLAGS = -Wall -O2
LDFLAGS = -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/libpng16 -pthread -lnotify -lgdk_pixbuf-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0
BATTERY = battery
NETWORK = network
TIME = time
BINS = $(shell find . -type f -perm -u+x \( -name $(TIME) -or -name $(BATTERY) -or -name $(NETWORK) \) -print)

all: $(BATTERY) $(NETWORK) $(TIME)

$(BATTERY):
> @$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $@.c

$(NETWORK):
> @$(CC) $(CFLAGS) -o $@ $@.c

$(TIME):
> @$(CC) $(CFLAGS) -o $@ $@.c

clean:
> @rm -rf $(BINS)

.PHONY: clean
