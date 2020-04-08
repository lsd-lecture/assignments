# Verschlüsselung in C

Dieses C-Programm verschlüsselt Daten mit einem einfachen (und unsicheren) XOR-Algorithmus.

Die Verschlüsselungsfunktionen sind in [crypto.h](crypto.h) deklariert. Die Kommentare erläutern die Funktionsweise. Der Schlüssel, repräsentiert durch die Struktur `KEY` besteht aus einer Zeichenkette und einer Zahl, die das Verschlüsselungsverfahren anzeiht `type`. `type` ist für die XOR-Verschlüsseung mit `1` festgelegt.

Die Funktionen sind in der `crypto.c` implementiert.


## XOR-Verschlüsselung

Bei der XOR-Verschlüsselung werden Klartext und Schlüssel per XOR miteinander verknüpft. Der Schlüssel kann ein beliebig langer Text sein. Wenn der Klartext länger als der Schlüssel ist, wird der Schlüssel einfach wiederholt. Die Zahlenwerte von Schlüssel und Klartext werden dann per XOR miteinander verknüpft. Die Entschlüsselung funktioniert genauso, indem wieder der verschlüsselte Text und der Schlüssel per XOR miteinander verknüpft werden.

Beispielsweise würde beim Schlüssel `TPERULES` (damit ist jetzt auch klar, woher diese Aufgabe ursprünglich stammt) folgendes passieren:

```console
Klartext:
    A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z
    1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
Schlüssel:
    T  P  E  R  U  L  E  S  T  P  E  R  U  L  E  S  T  P  E  R  U  L  E  S  T  P
    20 16 5  18 21 12 5  19 20 16 5  18 21 12 5  19 20 16 5  18 21 12 5  19 20 16
Ergebnis:
    U  R  F  V  P  J  B  [  ]  Z  N  ^  X  B  J  C  E  B  V  F  @  Z  R  K  M  J
    21 18 6  22 16 10 2  27 29 26 14 30 24 2  10 3  5  2  22 6  0  26 18 11 13 10
Schlüssel:
    T  P  E  R  U  L  E  S  T  P  E  R  U  L  E  S  T  P  E  R  U  L  E  S  T  P
    20 16 5  18 21 12 5  19 20 16 5  18 21 12 5  19 20 16 5  18 21 12 5  19 20 16
Ergebnis:
    A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z
    1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
```

Das Ergebnis entsteht durch das XOR-Verknüpfen der Zahlenwerte, z.B. wird `A` mit `T` verschlüsselt, indem man `1 ^ 20 = 21` rechnet. Die Entschlüsselung erfolgt dann umgekehrt, d.h. `21 ^ 20 = 1`, womit sich wieder ein `A` ergibt.
Beachten Sie, dass bei der XOR-Verschlüsselung der Schlüssel `KEY.chars` beliebig lang werden kann. Außerdem brauchen Sie zur Darstellung des verschlüsselten Textes mehr als 26 Buchstaben, nämlich 32. Nehmen Sie daher einfach noch die Zeichen `@=0, [=27, \=28, ]=29, ^=30 und _=31` mit auf.

## Test

Die Funktionen aus `crypto.c` bzw. `crypto.h` werden durch automatisierte Unit-Tests getestet.

Das hier verwendete Unit-Test-Framework verwendet zwei einfach Makros für die Tests, und vermeidet so das Einbinden eines schwergewichtigen Frameworks.

```c
#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
                                if (message) return message; } while (0)

int test_run = 0;
```

## Programm

Es gibt nur *ein* Programm, das sowohl ver- auch entschlüsseln kann. Wie es genutzt wird, bestimmt es selbst aus dem Namen, unter dem es aufgerufen wurde (siehe Wert von `argv[0]`):

  * unter dem Namen `encrypt` verschlüsselt es
  * unter dem Namen `decrypt` entschlüsselt es

Das Programm bekommt als ersten Kommandozeilen-Parameter den Schlüssel übergeben. Wenn ein zweiter Parameter gegeben ist, wird dies als Dateiname interpretiert. Andernfalls liest das Programm die Eingaben von `stdin`.

Der verschlüsselte Text wird in jedem Fall auf der Console (`stdout`) wieder ausgegeben.

Das Programm prüft auch, ob die Parameter korrekt angegeben wurden. Es läuft nicht, wenn z.B. der Schlüssel fehlt. Auch müssen falsche Zeichen im Text oder Schlüssel gemeldet werden.

```console
$ ./encrypt MYKEY
HALLO
EXGIV

$ ./decrypt MYKEY
EXGIV
HALLO

$ ./encrypt MYKEY ../test.txt
IPNVADJ_]\DWSQ\UMS_L@A_@JY\E
I\Y]OHKXFQALNVJHR^K^
@P_]THQY@KHWS_\DUNK

$ ./encrypt
Usage: KEY [file name]

$ ./encrypt aaa ../test.txt
Error: Key contains illegal characters
```

Fehlermeldungen werden grundsätzlich auf `stderr` ausgegeben.
