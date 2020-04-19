# Assignment 3: Ein modernes Build-Tool für Tomcat

Ziel des Assignments ist es, den antiquierten Tomcat mit einem modernen Build-Tool zu bauen. Die Schmerzen des Ant-Builds haben Sie bereits kennen gelernt. In diesem Assignment geht es nun darum, Tomcat mit [Maven](https://maven.apache.org) zu bauen.


## Maven installieren

Installieren Sie [Maven](https://maven.apache.org) gemäß der Anleitung auf der Maven-Webseite.


## Tomcat auf einen Maven-Build umstellen

Stellen Sie Ihre Tomcat-Version so um, dass sie sich mit Maven bauen lässt. Hierzu müssen Sie eine passende `pom.xml` anlegen und einige strukturelle Änderungen am Projekt vornehmen, da Maven eine spezielle Projektstruktur vorsieht.

**Achten Sie darauf, alle Änderungen in GIT zu verfolgen, damit sich die Abarbeitung dieses Assignments in Ihrem Repository widerspiegelt. Verschieben Sie z.B. Dateien mit `git mv`, damit diese Änderungen sichtbar sind.**

Hierzu einige Tipps, damit die Lösung nicht zu schwierig wird:

* Sie finden die Dependencies am einfachsten über [Maven Central](http://search.maven.org)
* Sie müssen die Ressourcen (`.properties`, `.xml`, `.dtd`, `.xsd`) von den Quellen (`.java`) trennen und in ein eigenes Verzeichnis `src/main/resources`  bzw. `src/test/resources` verschieben.
* Verwenden Sie das Plugin `maven-assembly-plugin`, um alle Dateien in ein einziges JAR zu packen. Dieses Plugin würde man in produktiven Umgebungen nicht einsetzen, es vereinfacht aber die Tests im Rahmen dieses Assignments.
* Da Maven bei jedem Bauvorgang die Tests ausführt, wollen Sie möglicherweise die Menge der Tests reduzieren, um nicht immer so lange warten zu müssen. Sie können auch die Tests erst dann dazu nehmen, wenn alles andere funktioniert.

Wenn alles geklappt hat, können Sie Tomcat einfach über `java -jar target/NAME_DES_JARS.jar start` starten. Die Servlets und JSPs werden zu diesem Zeitpunkt noch nicht funktionieren, da diese getrennt gebaut werden müssen. Das kommt in einem späteren Assignment zum Tragen.

Die von Ihnen geschriebene `pom.xml` sollte unter 100 Zeilen haben und damit deutlich kürzer sein, als das Ant-Buildfile von Tomcat (1084 Zeilen).

Ein _typischer Fehler_ besteht darin, Tomcat selbst als Dependency zu importieren. Dies ist natürlich nicht sinnvoll, da Ihr Build in diesem Fall gar nichts baut.


## Abgabe

_Abgabe_: Checken Sie den entsprechend umstrukturierten Tomcat und die dazugehörige `pom.xml` ein. Man sollte Ihr Repository einfach mit `git clone` clonen und mit `mvn clean compile assembly:single` bauen können.

# Sidequest: Server vorbereiten

Für Ihre weiteren Aufgaben stellen wir Ihnen Linux-Server zur Verfügung, die Sie verwenden können - und für spätere Übungen auch müssen. Da für die Server ein wenig Netzwerk- und Linux-Know-How nötig ist, sollten Sie dieses im Vorfeld erarbeiten.


## Linux und Netzwerke

Wir werden in nächster Zeit mit Linux-Servern arbeiten. Dafür ist es notwendig,

  * Zugriff auf die Server per ssh-Key zu erhalten,
  * Linux auf der Kommandozeile bedienen zu können und
  * ein grundlegendes Verständnis zu TCP/IP-Netzen zu erlangen.

Sie finden die ssh-Keys aus Sicherheitsgründen im [Moodle](https://moodle.hs-mannheim.de/mod/folder/view.php?id=64835). Checken Sie diese auch auf keinen Fall in Ihr GitHub-Repository ein. Die IP-Adressen der Server und die Gruppenzuordnungen finden Sie ebenfalls im [Moodle](https://moodle.hs-mannheim.de/mod/page/view.php?id=64838). Die Server sind nur aus dem Hochschulnetz erreichbar.

Folgendes Material kann Ihnen helfen

  * Linux Kommandozeile: [BashGuide](http://mywiki.wooledge.org/BashGuide)
  * ssh:
    - S. 277-284 [Beginning the Linux Command Line](https://link.springer.com/book/10.1007%2F978-1-4302-6829-1) (aus dem Hochschulnetz kostenlos)
    - Speziell unter Windows: [Key-basierte SSH Logins mit PuTTY](https://www.howtoforge.de/anleitung/key-basierte-ssh-logins-mit-putty/3/)
  * Netzwerke:
    - S. 117ff. [Christian Baun. Computernetze kompakt](http://link.springer.com/book/10.1007/978-3-662-46932-3) (aus dem Hochschulnetz kostenlos)


## User auf den Servern anlegen

Legen Sie auf den Servern für die Mitglieder Ihres Teams User an und installieren Sie entsprechend weitere SSH-Keys, damit Sie sich auch unter Ihrem User anmelden können.

Diese User sollten Sie grundsätzlich benutzen und nicht den Root-Zugang, der nur für Notfälle und bestimmte administrative Aufgaben gedacht ist.
