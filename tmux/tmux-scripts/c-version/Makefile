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
HOSTNAME = hostname
LOADAVG = load_average
UPTIME = uptime
BINS = $(shell find . -type f -perm -u+x \( -name $(LOADAVG) -or -name $(UPTIME) -or -name $(HOSTNAME) \) -print)

all: $(HOSTNAME) $(LOADAVG) $(UPTIME)

$(HOSTNAME):
> @$(CC) $(CFLAGS) -o $@ $@.c

$(LOADAVG):
> @$(CC) $(CFLAGS) -o $@ $@.c

$(UPTIME):
> @$(CC) $(CFLAGS) -o $@ $@.c

clean:
> @rm -rf $(BINS)

.PHONY: clean
