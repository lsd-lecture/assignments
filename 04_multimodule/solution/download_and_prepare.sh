#!/bin/sh

create_sub_project()
{
  mkdir -p $1/src/main/java
  mkdir -p $1/src/main/resources
  mkdir -p $1/src/main/webapp

  mv engine/webapps/$1/* $1/src/main/webapp/

  if [ -d "$1/src/main/webapp/WEB-INF/classes" ]; then
    mv $1/src/main/webapp/WEB-INF/classes/* $1/src/main/java
    rsync -r --include '*/' --include '*.properties' --include '*.xml' --include '*.xsd' --include '*.dtd' --exclude '*' --prune-empty-dirs --remove-source-files   $1/src/main/java/ $1/src/main/resources/
  fi

  rmdir engine/webapps/$1

  cp ../files/$1/pom.xml $1/pom.xml
}

mkdir tomcat
cd tomcat

# Download and unpack the sources
wget https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/src/apache-tomcat-6.0.53-src.tar.gz
tar xzf apache-tomcat-6.0.53-src.tar.gz

# Remove the archives - not needed any longer
rm apache-tomcat-6.0.53-src.tar.gz

# Split up for multi module build

# Tomcat itself
mv apache-tomcat-6.0.53-src engine

mkdir -p engine/src/main/java
mkdir -p engine/src/main/javadoc
mkdir -p engine/src/main/resources
mkdir -p engine/src/test/java
mkdir -p engine/src/test/resources

mv engine/java/javax engine/src/main/java/
mv engine/java/org engine/src/main/java/
mv engine/test/javax engine/src/test/java/
mv engine/test/org engine/src/test/java/
mv engine/test/deployment engine/src/test/resources/

# Move resources to different folder
rsync -r --include '*/' --include '*.properties' --include '*.xml' --include '*.xsd' --include '*.dtd' --exclude '*' --prune-empty-dirs --remove-source-files engine/src/main/java/ engine/src/main/resources/

rsync -r --include '*/' --include '*.properties' --include '*.xml' --include '*.xsd' --include '*.dtd' --exclude '*' --prune-empty-dirs --remove-source-files engine/src/test/java/ engine/src/test/resources/

rmdir engine/java
rmdir engine/test

# Remove broken tests
rm -rf engine/src/test/java/org/apache/catalina/startup/TestTomcat.java
rm -rf engine/src/test/java/org/apache/catalina/tribes/group/interceptors/TestNonBlockingCoordinator.java
rm -rf engine/src/test/java/org/apache/catalina/tribes/test/TribesTestSuite.java
rm -rf engine/src/test/java/org/apache/catalina/tribes/test/channel/TestDataIntegrity.java
rm -rf engine/src/test/java/org/apache/catalina/tribes/group/TestGroupChannelMemberArrival.java
rm -rf engine/src/test/java/org/apache/catalina/tribes/group/interceptors/*

# Remove long running tests
rm -rf engine/src/test/java/org/apache/catalina/tribes/test/channel
rm -rf engine/src/test/java/org/apache/catalina/tribes/group
rm -rf engine/src/test/java/org/apache/catalina/core

# POM
cp ../files/engine/pom.xml engine/pom.xml

# Remove unnecessary files
rm engine/build.properties.default
rm engine/build.xml
rm engine/eclipse.classpath
rm engine/eclipse.project
rm engine/dist.xml
rm engine/extras.xml

# Patch users
cp ../files/engine/conf/tomcat-users.xml engine/conf

# Prepare web applications
create_sub_project examples
create_sub_project host-manager
create_sub_project manager
create_sub_project ROOT
create_sub_project docs

# Special case RELEASE-NOTES
cp engine/RELEASE-NOTES ROOT/src/main/webapp/RELEASE-NOTES.txt

# Copy scripts
cp ../files/build.sh .
cp ../files/run.sh .

# Remove webapps folder
rmdir engine/webapps

# Copy main pom
cp ../files/pom.xml .

./build.sh
