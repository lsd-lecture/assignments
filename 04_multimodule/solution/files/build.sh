#!/bin/sh
mvn clean package
mkdir -p target
mkdir -p target/webapps
cp engine/target/tomcat-engine-6.0-SNAPSHOT-jar-with-dependencies.jar target/
cp -r engine/conf target/
cp examples/target/examples.war target/webapps
cp manager/target/manager.war target/webapps
cp host-manager/target/host-manager.war target/webapps
cp ROOT/target/ROOT.war target/webapps
cp docs/target/docs.war target/webapps
