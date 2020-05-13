#!/bin/sh
mvn clean compile package site site:stage
mkdir -p result
mkdir -p result/webapps
cp engine/target/tomcat-engine-6.0-SNAPSHOT-jar-with-dependencies.jar result/
cp -r engine/conf result/
cp examples/target/examples.war result/webapps
cp manager/target/manager.war result/webapps
cp host-manager/target/host-manager.war result/webapps
cp ROOT/target/ROOT.war result/webapps
cp docs/target/docs.war result/webapps
cd result && tar czf ../target/tomcat.tgz * && cd ..
