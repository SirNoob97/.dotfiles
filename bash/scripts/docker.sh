#!/bin/bash

function dkrminone {
  sudo docker rmi $(dk images -a | grep '^<none>' | awk --field-separator=' ' '{ print $3 }')
}

function dkrmimavenlatest {
  local projs=$(find . -type f -name 'pom.xml' -printf '%h\n')

  sudo docker rmi $(for i in $projs; do echo $(basename $i):latest; done)
}
