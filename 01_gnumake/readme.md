# Assignment 1: GNU Make

Ziel dieses Assignments ist es, ein klassisches Build-Tool (_make_) zu verwenden und damit erste Erfahrungen zu sammeln.


## Voraussetzungen

Dieses Assignment benötigt einen C-Compiler und GNU Make. Auf Linux-Systemen sind beide normalerweise standardmäßig installiert. Unter Windows kann man beide Werkzeuge ebenfalls über [Cygwin](https://www.cygwin.com/) installieren. Oft ist es allerdings einfacher, eine Linux-Umgebung zu nutzen/aufzusetzen. Hierzu können Sie entweder

  * Ein eigenes Linux in einer virtuellen Maschine installieren (z.B. [VirtualBox](https://www.virtualbox.org) mit [Ubuntu](https://www.ubuntu.com))
  * Ein Live-Linux auf Ihrem Rechner starten, z.B. [Slax](http://www.slax.org)
  * Sich mit Ihrem Fakultätsaccount auf `jonathan.sv.hs-mannheim.de` anmelden
  * Unter Android die Terminal-Emulation [Termux](https://play.google.com/store/apps/details?id=com.termux) installieren


## C-Quellen beziehen

Zusammen mit diesem Assignment finden Sie die [Quellen](crypter/) zu einem ganz einfachen Verschlüsselungsprogramm in C. Es fehlt allerdings das Makefile und Ihre Aufgabe besteht darin, dieses zu schreiben.

Um die Quellen manuell zu bauen, benötigen Sie folgende Kommandos:

```console
# Verzeichnis für die Ergebnisse anlegen
mkdir -p output

# Die einzelnen Quelldateien kompilieren
cc -o output/main.o -c main.c
cc -o output/crypto.o -c crypto.c
cc -o output/test.o -c test.c

# Die Objektdateien zu drei Executables zusammenlinken
cc -o output/encrypt output/main.o output/crypto.o
cc -o output/decrypt output/main.o output/crypto.o
cc -o output/test output/test.o output/crypto.o
```

Sie können das Ergebnis mit `./output/test` testen. Die Ausgabe sollte sein:

```console
ALL TESTS PASSED
Tests run: 4
```


## Makefile

Schreiben Sie ein Makefile, dass das Bauen und Testen des Programms automatisiert. Folgende Targets sollten mindestens vorhanden sein:

  * `all` - baut alle Dateien und führt die Tests aus
  * `clean` - löscht alle Ergebnisdateien
  * `runtest` - führt die Tests aus

Weitere Targets werden für das Erstellen der Objektdateien und das Linken benötigt. Fügen Sie diese ebenfalls ein.

Wenn `make` ohne Optionen aufgerufen wird, sollte das Target `all` ausgeführt werden.

Schauen Sie sich die Dokumentation von GNU Make zu den [Automatischen Variablen](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html) an, da diese Ihre Arbeit erheblich vereinfachen können.

Denken Sie daran, dass der Witz des Makefiles darin liegt nur die Dateien zu kompilieren, bei denen auch wirklich etwas geändert wurde. Die oben beschriebenen Kommandos also einfach ohne die Definition von Abhängigkeiten abzuarbeiten ist keine valide Lösung dieser Aufgabe.

## Test

Testen Sie Ihr Makefile und das Programm manuell. Überprüfen Sie, ob das Makefile die Abhängigkeiten korrekt beachtet.

Das Programm können Sie z.B. mit folgendem Kommando testen:

```console
$ ./output/encrypt LSDROCKS text.txt | ./output/decrypt LSDROCKS
```

Die Ausgabe sollte sein

```console
DIESXISTXEINXTEXTXZUMXTESTEN
DERXVERSCHLUESSEKUNG
MITXMEHRERENXZEILEN
```

Eine andere Alternative sieht so aus:

```console
$ ./output/encrypt LSDROCKS text.txt | ./output/decrypt LSDROCKS | diff text.txt -
```


## Abgabe

_Abgabe_: Checken Sie das entsprechend vollständige Projekt und das dazugehörige `Makefile` in Ihr Repository bei GitHub ein. Überlegen Sie sich eine sinnvolle Verzeichnisstruktur, da noch weitere Übungen folgen werden. Es muss möglich sein, Ihr Repository zu clonen, in das Verzeichnis zu gehen und das Verschlüsselungsprogramm mit `make` zu bauen und zu testen. Denken Sie also daran, keine Dateien zu vergessen.
