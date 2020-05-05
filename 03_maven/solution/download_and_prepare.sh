#!/bin/sh

# Download and unpack the sources
wget https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/src/apache-tomcat-6.0.53-src.tar.gz
tar xzf apache-tomcat-6.0.53-src.tar.gz

# Remove the archives - not needed any longer
rm apache-tomcat-6.0.53-src.tar.gz

# Rename directory
mv apache-tomcat-6.0.53-src tomcat
cd tomcat

# Restructure directories
mkdir -p src/main/java
mkdir -p src/main/javadoc
mkdir -p src/main/resources
mkdir -p src/test/java
mkdir -p src/test/resources
mv java/javax src/main/java/
mv java/org src/main/java/
mv test/javax src/test/java/
mv test/org src/test/java/
mv test/deployment src/test/resources/
rmdir java
rmdir test

# Remove broken tests
rm src/test/java/org/apache/catalina/tribes/group/interceptors/TestNonBlockingCoordinator.java
rm src/test/java/org/apache/catalina/tribes/group/interceptors/TestOrderInterceptor.java
rm src/test/java/org/apache/catalina/tribes/group/TestGroupChannelMemberArrival.java
cp ../files/src/test/javaorg/apache/catalina/tribes/test/TribesTestSuite.java test/org/apache/catalina/tribes/test/TribesTestSuite.java

# Move resources to different folder
rsync -r --include '*/' --include '*.properties' --include '*.xml' --include '*.xsd' --include '*.dtd' --exclude '*' --prune-empty-dirs --remove-source-files src/main/java/ src/main/resources/

# Remove ANT artifacts
rm build.properties.default
rm build.xml

# Copy pom.xml
cp ../files/tomcat/pom.xml .

# Eclipse
rm eclipse.classpath
rm eclipse.project
cp ../files/.classpath .
cp ../files/.project .

# Build
mvn clean compile assembly:single

# Start
java -jar target/tomcat-engine-6.0-SNAPSHOT-jar-with-dependencies.jar start
