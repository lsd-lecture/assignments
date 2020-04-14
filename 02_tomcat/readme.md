# Assignment 2: Anderer Leute Code

In der Praxis muss man sich oft mit fremden Code auseinandersetzen und trifft dabei häufig auf sehr große Codebasen, die über Jahrzehnte entstanden sind.

Ziel dieses Assignments wird es sein, fremden Code zu kompilieren und danach zu testen. Um eine hinreichend große Codebasis zu haben, werden wir den Quelltext von Apache Tomcat verwenden. Damit zumindest ein gewisses Legacy-Gefühl aufkommt, nehmen wir eine Version, die deutlich über 10 Jahre alt ist (6.0).


## Voraussetzungen

### Java

Sie benötigen Java, um Tomcat zu bauen und auszuführen. Als die Version 6.0 von Tomcat herauskam, war noch Java 1.5 aktuell. Sie können aber dieses Assignment problemlos mit Java 11 durchführen, müssen also nicht auf eine uralte Java-Version zurückgreifen.

### Ant

Tomcat wird mit dem Build-Werkzeug [Ant](https://ant.apache.org) gebaut. Dieses müssen Sie zuerst herunterladen und installieren. Installieren Sie es so, dass es im Pfad liegt und einfach durch Aufruf von `ant` auf der Konsole gestartet werden kann.


## Tomcat herunterladen

Laden Sie von der Seite der Apache Foundation die Version [6.0.53](https://archive.apache.org/dist/tomcat/tomcat-6/v6.0.53/src/) von [Tomcat](http://tomcat.apache.org) herunter und entpacken Sie diese.

_Achtung:_ Wenn Sie Windows verwenden, benutzen Sie die _zip_-Datei, wenn Sie Linux oder macOS verwenden, die _tar.gz_-Datei. Generell ist es empfehlenswert Linux einzusetzen, da Windows gerne Probleme verursacht!


## Änderungen verfolgen

Um die folgenden Änderungen, die Sie an den Quellen und dem Build-File vornehmen verfolgen zu können, verwenden Sie Git. Checken Sie dazu die Original-Version von Tomcat ein und verfolgen Sie danach Ihre Änderungen bis zum funktionierenden Build mit entsprechenden Checkins.

Gerne können Sie auch ein Skript schreiben, das alle manuellen Operationen durchführt und so eine Nachverfolgung und Dokumentation Ihrer Änderungen vornehmen.


## Tomcat bauen

Versuchen Sie Tomcat mit dem vorhandenen Build-Skript `build.xml` und Ant zu bauen. Wahrscheinlich müssen Sie Änderungen an den Build-Einstellungen in `build.properties.default` vornehmen, damit der Build durchläuft. Je nach Umgebung kann es auch sein, dass Sie die `build.xml` selbst anfassen müssen. Hierfür werden Sie ein grundlegendes Verständnis des Build-Vorgangs brauchen und den Aufbau der `build.xml` verstehen müssen. Schauen Sie sich die `build.xml` aufmerksam an, um die Funktionsweise abzuleiten. Hinweise finden Sie auch in der Datei `BUILDING.txt`.

Beachten Sie auch, dass Sie bevor Sie Tomcat bauen können mit `ant download` die Bibliotheken herunterladen müssen, die für das Compilieren gebraucht werden. Standardmäßig werden diese Bibliotheken außerhalb der Quellen von Tomcat abgespeichert. Mglw. wollen Sie dies ändern, damit Sie alles an einem Ort haben.


## Tomcat starten

Wenn Sie die Klassen erfolgreich kompilieren konnten, versuchen Sie Tomcat zu starten. Gehen Sie hierzu in das Verzeichnis `output/build/bin` und starten Sie ihn mit `java -cp bootstrap.jar org.apache.catalina.startup.Bootstrap`. Wenn alles geklappt hat, können Sie im Browser [http://localhost:8080](http://localhost:8080) aufrufen.

Testen Sie die Servlet- und insbesondere die JSP-Beispiele. Sie sollten alle - mit Ausnahme der Applets - funktionieren.


## Unit-Tests ausführen

Führen Sie die Unit-Tests für Tomcat aus. Diese starten Sie über das Target `test` im Build.

Es werden nicht alle Tests funktionieren. Entfernen Sie diejenigen Tests, die fehlschlagen.


## Code Basis in Eclipse importieren

Legen Sie ein Eclipse-Projekt an und fügen Sie den Quelltext von Tomcat hinzu. Wichtig ist, dass der Quellcode von Eclipse compiliert werden kann und Sie Tomcat aus Eclipse heraus starten können. Hierzu müssen Sie wahrscheinlich einige Bibliotheken in Eclipse einbinden und Einstellungen zur Java-Version vornehmen. Damit überhaupt keine Compiler-Fehler mehr auftreten, müssen Sie noch externe Bibliotheken beschaffen (siehe hierzu die Fehlermeldungen).

Wenn Sie erfolgreich waren, sollte sich Tomcat auch aus Eclipse heraus starten lassen. Hierzu müssen Sie die Hauptklasse finden. (Tipp: Schauen Sie in `catalina.sh` nach, ob Sie einen Hinweis finden). Beim Start werden einige Fehler geworfen, Tomcat sollte aber trotzdem funktionieren.

## Abgabe

Wenn Sie alle Schritte abgeschlossen haben, checken Sie die Ergebnisse in Ihr Git-Repository ein. Es muss möglich sein, Ihr Repository zu clonen und einen Build von Tomcat zu starten. Dieser muss problemlos durchlaufen.

Reflektieren Sie über den Build Vorgang und die von Ihnen gemachten Schritte. Denken Sie darüber nach, was an dem Prozess kompliziert war oder schlecht gelaufen ist und fassen Sie dies kurz in einem _kleinen Readme-Dokument_ zusammen, dass Sie ebenfalls einchecken.
