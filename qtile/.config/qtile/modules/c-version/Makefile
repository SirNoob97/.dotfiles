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
TIME = time
BINS = $(shell find . -type f -perm -u+x -name $(TIME))

all: $(TIME)

$(TIME):
> @$(CC) $(CFLAGS) -o $@ $@.c

clean:
> @rm -rf $(BINS)

.PHONY: clean
