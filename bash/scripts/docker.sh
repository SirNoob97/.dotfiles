#!/bin/bash

dkrminone() {
  dk rmi $(dk images -a | grep '<none>' | awk --field-separator=' ' '{ print $3 }')
}
