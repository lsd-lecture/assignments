# Assignment 4: Multi-Module Build mit Maven

Ziel dieser Aufgabe ist es, neben dem eigentlichen Tomcat Servlet-Container auch noch die dazugehörigen Beispiele (`examples`) und Administrationsanwendungen (`manager` und `host-manager`) sowie die Startseite (`ROOT`) mit [Maven](https://maven.apache.org) zu bauen. Hierzu wird ein sogenannter [Reactor Build](https://maven.apache.org/guides/mini/guide-multiple-modules.html) durchgeführt, bei dem mehrere Module von einer zentralen POM aus gesteuert, gebaut werden.


## Tomcat aufteilen

In den Original-Quelltexten von Tomcat befinden sich die Webanwendungen im Verzeichnis `webapps`. Diese sind:

  * `docs`: Die Dokumentation
  * `examples`: Beispiel Servlets und JSP-Seiten
  * `host-manager`: Administrationsanwendung
  * `manager`: Administrationsanwendung
  * `ROOT`: Startseite

Um einen modularen Build zu erhalten, sollen Sie jede einzelne Webanwendung in ein eigenes Maven-Projekt umwandeln. Da es sich um Webanwendungen handelt, müssen Sie diese zu einem WebArchive (war) packen. Dazu dient die Einstellung `<packaging>war</packaging>` in Ihrer `pom.xml`.

Bitte verwenden Sie `<build><finalName>`, um die erzeugten War-Dateien genauso zu nennen wie die Verzeichnisse im original Tomcat heißen (also `docs`, ..., `ROOT` inklusive Groß- und Kleinschreibung). Dies ist notwendig, damit Tomcat sie später automatisch aus dem `war` auspacken und unter dem richtigen Namen installieren kann.

Sie müssen die Quelltexte der einzelnen Webapplikationen wieder aufteilen. Alle `.java`-Dateien kommen in den Ordner `src/main/java`, alle Properties in `src/main/resources` und alle weiteren Artefakte (`web.xml`, `*.jsp` etc.) müssen in einen neuen Ordner `src/main/webapp` (Achtung: ohne "s") geschoben werden.

Beachten Sie, dass die `examples`-Webanwendung eine direkte Abhängigkeit zum Tomcat-Servletcontainer hat und modellieren Sie diese entsprechend in der `pom.xml`.

Den verbleibenden Tomcat-Servlet-Container belassen Sie in seinem ursprünglichen Maven-Projekt, nennen es aber der Eindeutigkeit wegen in `engine` um.


## Parent Build

Ausgehend von dem ursprünglichen Tomcat-Build und den Webanwendungen sollen Sie nun einen Parent-Build aufsetzen, der über eine zentrale `pom.xml` die anderen Teile automatisch und in der richtigen Reihenfolge baut. Sowohl Tomcat (`engine`) als auch die Webanwendungen sind jetzt Unterverzeichnisse des Parent-Builds. Die Verzeichnisstruktur sieht dann z.B. wie folgt aus:


```console
├── docs
│   ├── pom.xml
│   ├── src/
├── engine
│   ├── ...
│   ├── pom.xml
│   ├── src/
├── examples
│   ├── pom.xml
│   ├── src/
├── host-manager
│   ├── pom.xml
│   ├── src/
├── manager
│   ├── pom.xml
│   ├── src/
├── ROOT
│   ├── pom.xml
│   ├── src/
├── run.sh
├── build.sh
└── pom.xml
```

Auf ein `mvn clean compile package` hin sollten in den Target-Verzeichnissen der Webanwendungen entsprechende `war`-Dateien entstehen und der Tomcat gebaut werden.

Die Tests können Sie der Einfachheit halber auf einige wenige, schnellaufende Tests reduzieren.

## Tomcat zusammenstellen

Noch sind die Dateien, die Sie für einen lauffähigen Tomcat benötigen auf die Sub-Projekte verteilt. Deswegen werden Sie im nächsten Schritt ein kleines Shell-Skript (`build.sh`) schreiben, das die einzelnen Build-Artefakte zu einem Ergebnis zusammenbringt.

Das Skript soll das folgende tun:

  * Den Build mit `mvn clean compile package` anstoßen
  * Im Verzeichnis des Parent-Builds ein Unterverzeichnis `target` anlegen und darin ein weiteres Verzeichnis `webapps`
  * Das JAR mit dem Servlet-Container in `target` kopieren
  * Die WARs der Webapps in `target/webapps` kopieren
  * Das Verzeichnis `conf` (samt Inhalt) aus dem Tomcat-Projekt in `target` kopieren

Danach sollte sich der Tomcat, inklusiver aller Beispielanwendungen mit

```console
cd target ; export CATALINA_HOME=`pwd` ; java -jar tomcat-engine-6.0-SNAPSHOT-jar-with-dependencies.jar start
```

starten lassen.

Schreiben Sie sich ein weiteres Shellskript (`run.sh`), dass diese Kommandozeile automatisiert.


## IDE-Einbindung

Passen Sie die Einbindung von Tomcat in Ihre IDE (Eclipse etc.) so an, dass Sie Tomcat weiterhin per IDE starten können.

## Kriterien

Folgende Kriterien sind wichtig:

  * Build läuft nach `git clone` und `./build.sh` durch
  * Tomcat lässt sich mit `./run.sh` starten
  * [Startseite](http://localhost:8080) von Tomcat wird angezeigt
  * [Status](http://tomcat:secret@localhost:8080/manager/status) lässt sich aufrufen (User: `tomcat`, Password: `secret`)
  * [Tomcat Manager](http://tomcat:secret@localhost:8080/manager/html) lässt sich aufrufen (User: `tomcat`, Password: `secret`)
  * [Release Notes](http://localhost:8080/RELEASE-NOTES.txt) lassen sich aufrufen
  * [Change Log](http://localhost:8080/docs/changelog.html) lässt sich aufrufen
  * [Dokumentation](http://localhost:8080/docs/) lässt sich aufrufen
  * [Servlet Examples](http://localhost:8080/examples/servlets/) lassen sich aufrufen und funktionieren alls
  * [JSP-Examples](http://localhost:8080/examples/jsp/) lassen sich aufrufen und funktionieren

Die Anzeige der Quelltexte bei den JSP-Examples muss _nicht_ funktionieren, d.h. Sie können sich die Generierung der entsprechenden HTML-Dateien sparen.


## Hinweise

Diese Aufgabe beinhaltet einige Fallen und Komplexitäten, beachten Sie deswegen die folgenden Tipps.

### Automatisieren der Aufteilung

Die Vorgänge für die einzelnen Webapplikationen sind immer gleich. Sie können sich erheblich Arbeit sparen, wenn Sie das Aufteilen per Skript durchführen, anstatt es von Hand zu machen.


### Dokumentation

Wenn Sie sich den Ant-Build ansehen, werden Sie feststellen, dass die Dokumentation erst beim Bauen aus XML-Dateien per XSLT-Transformation erzeugt wird. Damit die Dokumentation auch in Ihrem Build erzeugt wird, müssen Sie ein entsprechendes Maven-Plugin benutzen. Hierzu benötigten Sie das `org.codehaus.mojo.xml-maven-plugin`-Plugin. Da die Konfiguration etwas trickreich ist, ist sie hier angegeben:

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>xml-maven-plugin</artifactId>
  <version>1.0.2</version>
  <executions>
    <execution>
      <goals>
        <goal>transform</goal>
      </goals>
    </execution>
  </executions>
  <configuration>
    <transformationSets>
      <transformationSet>
        <dir>src/main/webapp</dir>
        <includes>
          <include>**/*.xml</include>
        </includes>
        <excludes>
          <exclude>security-manager-howto.xml</exclude>
          <exclude>web.xml</exclude>
          <exclude>project.xml</exclude>
        </excludes>
        <stylesheet>src/main/webapp/tomcat-docs.xsl</stylesheet>
        <fileMappers>
        <fileMapper implementation="org.codehaus.plexus.components.io.filemappers.FileExtensionMapper">
          <targetExtension>.html</targetExtension>
        </fileMapper>
      </fileMappers>
      </transformationSet>
    </transformationSets>
  </configuration>
</plugin>
```

Mit dieser Konfiguration erzeugen Sie die HTML-Dateien im Verzeichnis `target/generated-resources/xml/xslt` aber sie sind noch nicht im Projekt eingebunden. Hierzu können Sie das `maven-war-plugin` verwenden:

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-war-plugin</artifactId>
  <version>3.2.3</version>
  <configuration>
    <webResources>
      <resource>
        <directory>target/generated-resources/xml/xslt/</directory>
      </resource>
    </webResources>
  </configuration>
</plugin>
```

### Release Notes

Die Dokumentation verlinkt als erstes auf eine Datei `/RELEASE-NOTES.txt`. Diese befinde sich aber gar nicht im `doc`-Ordner, sondern Sie finden sie unter dem Namen `RELEASE-NOTES` im Hauptverzeichnis von Tomcat. Kopieren Sie diese Datei also einfach unter dem geänderten Namen in in das `ROOT`-Projekt (_nicht_ das `doc`-Projekt).


### Zugriff auf die Administrationsanwendungen

Die Administrationsanwendungen sind per Passwort geschützt. Um einen Zugang zu aktivieren, müssen Sie in der Datei `conf/tomcat-users.xml` folgendes  einfügen:

```xml
<role rolename="manager-gui"/>
<role rolename="manager"/>
<role rolename="manager-status"/>
<user username="tomcat" password="secret" roles="manager-gui,manager-status,manager"/>
```

## Abgabe

_Abgabe_: Checken Sie den entsprechend umstrukturierten Sourcecode und die dazugehörigen `pom.xml` ein. Man sollte Ihr Repository einfach mit `git clone` clonen und mit `build.sh` bauen können.
