#!/bin/zsh

export skip_global_compinit=1

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME/bin

export PATH=/usr/share/maven/bin:$PATH

export SPRING_HOME=/opt/spring-2.3.3.RELEASE
export PATH=$SPRING_HOME/bin:$PATH

export PATH=/opt/firefox/firefox:$PATH
