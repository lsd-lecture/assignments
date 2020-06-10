# Assignment 8: All your container are belong to us

Nachdem jetzt ein maven-basierter Build existiert und über Jenkins eine Continuous Integration gewährleistet ist, ist der letzte Schritt ein Continuous Deployment zu realisieren. D.h. das jede Änderung direkt gebaut, getestet und auf ein Live-System gespielt wird. Für das Deployment haben sich in den letzten Jahren Container als Technologie durchgesetzt. Für dieses Assignment verwenden wir [Docker](https://docker.io) als Container-Laufzeit.

## Docker

Informieren Sie sich über Docker auf der [Webseite des Projektes](https://docker.io). Sinnvollerweise gehen Sie das [Tutorial](https://docs.docker.com/get-started/) durch, bevor Sie versuchen einen eigenen Container zu bauen. Am einfachsten führen Sie das Tutorial auf Ihrem Server aus.


## Bauen eines Containers für Tomcat

Erzeugen Sie in einem ersten Schritt (ohne Verwendung von Jenkins) einen Docker-Container, der Ihren selbtsgebauten Tomcat enthält. Hierzu können Sie von den Build-Ergebnissen der Assignments 4 oder 5 ausgehen, d.h. das dort erstellte `target`-Verzeichnis und das Startskript verwenden. Testen Sie, ob der von Ihnen gebaute Container funktioniert, bevor Sie weitermachen.

Lassen Sie Tomcat extern auf Port 8088 laufen, damit es nicht zu Konflikten mit Jenkins kommt. (Siehe hierzu die Option `-p` von Docker).


## Jenkins + Docker

Integrieren Sie das Bauen des Docker-Containers für Tomcat in Ihre Jenkins Pipeline, sodass ein Container erzeugt wird, wenn der Build erfolgreich war. Verwenden Sie dazu das pipeline-basierte Jenkins-Projekt, d.h. erweitern Sie das `Jenkinsfile` um die entsprechenden Schritte.

Folgendes Verhalten wird erwartet:

  1. Eine Änderungen am Quelltext stößt (über Polling) das Bauen und Testen von Tomcat an
  2. Die Ergebnisse werden in einen Docker-Container verpackt
  3. Ein bereits laufender Docker-Container von Tomcat wird gestoppt
  4. Der neue Docker-Container wird gestartet und ist über Port 8088 erreichbar


## Abgabe

_Abgabe_:

  * Checken Sie das erweiterte `Jenkinsfile`, das `Dockerfile` und eventuell weitere Skripte in Ihr GitHub-Repository ein
  * Nehmen Sie einen Link zu dem laufenden Container in die Dokumentation Ihres Projektes auf, sodass man von der Jenkins-Webseite aus direkt zum Container gelangen kann
  * Dokumentieren Sie kurz, was Sie sonst noch tun mussten, um das Ziel zu erreichen
