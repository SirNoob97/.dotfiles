#!/bin/bash - 

# To avoid parent projects, more friendly with my computer.
mvnMultiCompile() {
  local projects=$(find . -type f -name 'pom.xml')
  
  for i in $projects; do
    mvn -f $i clean compile
  done
}
