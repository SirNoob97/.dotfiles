#!/bin/bash

function evalsshid {
  eval $(ssh-agent -t 25200)
  ssh-add -q -t 25200
}
