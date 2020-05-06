#!/bin/sh
cd target
export CATALINA_HOME=`pwd`
java -jar tomcat-engine-6.0-SNAPSHOT-jar-with-dependencies.jar start

