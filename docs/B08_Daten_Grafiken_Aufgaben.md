Eigene Daten in Grafiken umwandeln
==================================

In den meisten Fällen möchte man ja seine eigenen Daten visualisieren.
Deshalb wird hier das Thema behandelt, wie man Daten aus einer csv- oder
xlsx-Tabelle in R einlädt, um damit weiter zu arbeiten..

Daten einladen
--------------

Je nachdem, wie die eigenen Daten gespeichert sind, benötigt man
unterschiedliche Funktionen in R. Was base-r am einfachsten kann, ist
eine csv-Datei einladen. Der Befehl dafür heißt “read.csv2” (eine
Weiterentwicklung von read.csv). Mit diesem Befehl können wir auch
spezifizieren, mit welchem Zeichen die Spalten voneinander getrennt
wurden. Im Beispiel gebe ich an, dass eine Semikolon-getrennte Tabelle
ist (mit `sep = ";"`. Außerdem ist es ein deutscher Datensatz und der
Dezimaltrenner ist das Komma (`dec= ","`). Das ist wichtig, sonst denkt
R, das wären keine Zahlen sondern Text:

``` r
mydata <- read.csv2("Pfad/zur/Datei/meineDatei.csv", sep = ";", dec = ",")
```

Für Excel-Daten muss man ein eigenes Paket installieren. Ich empfehle
“openxlsx”. Hier kann ich z. B. spezifizieren, welches sheet in der
Excel-Arbeitsmappe als Tabelle eingelesen werden soll:

``` r
install.packages("openxlsx") # wie immer: nur für nicht-Cloud user!
library(openxlsx)

mydata <- read.xlsx("Pfad/zur/Datei/meineDatei.xlsx", sheet = 1)
```

Speichern von Daten
-------------------

Daten, die man modifiziert hat, möchte man manchmal einfach speichern,
damit man den Code, den man dafür geschrieben hat, nicht jedes mal
wieder laufen lassen muss. Außerdem kollaboriert man ja manchmal mit
Menschen, die kein R haben.

Für ersteres gibt es wie beim Einladen, so auch beim Schreiben von Daten
zwei Wege.

Um einen Datensatz namens `df` als komma-separierte csv-Tabelle zu
schreiben, geht das folgendermaßen:

``` r
write.csv2(df, "Pfad/zum/Ordner/name_des_datensatzes.csv", row.names = FALSE, sep = ",")
```

`row.names = FALSE` spezifiziert, dass man keine Zeilennamen haben
möchte, die R normalerweise automatisch erstellt. Manchmal möchte man
sie aber abspeichern, dann sollte man das auf `TRUE` setzen.

Um eine Excel-Tabelle zu schreiben, nehmt ihr wieder das Paket
`openxlsx`

``` r
write.xlsx(df, "Pfad/zum/Ordner/name_des_datensatzes.xlsx")
```

Wenn man mit der Ordnerstruktur von `rrtools` arbeitet, sollten solche
Daten in dem Ordner “data/derived\_data/” gespeichert werden.

Beispieldatensatz
-----------------

Als Beispieldaten gebe ich euch den Datensatz des Pakets YARRR, es ist
eine Tabelle über Piraten. Er liegt unter “Materialordner/Datensatz” in
dem OpenOlat-Kurs. Speichert die Excel-Tabelle in dem Ordner
“data/data\_raw” eures Projekts (siehe letzte Stunde, wo mit rrtools ein
eigenes Projekt erstellt wurde).

Ladet den Datensatz ein.

``` r
pirates <- read.csv2("../data/data_raw/pirates.csv", 
                     sep = ";", 
                     dec = ",")
```

Schaut euch den Datensatz an (`head()` oder auf drauf klicken).

Wie ihr seht gibt es eine ganze Menge Informationen zu den Piraten.

Aufgaben
========

Schreibt ein Rmarkdown-Dokument, das in eine html-Datei umgewandelt
werden kann und in dem ihr die folgenden drei Fragen behandelt. Zu jeder
Frage schreibt ihr bitte eine Überschrift, dann in normalen Text die
Fragestellung, öffnet einen Code-Chunk (Strg+Alt+i), schreibt darin den
Code, der für die Beantwortung der Frage notwendig ist, schaut euch das
Ergebnis an und interpretiert das Ergebnis danach wieder in normalem
Text. Zwei-drei Stichpunkte genügen.

Denkt daran, mit `library()` das Paket zu laden, das ihr für die
Aufgaben benötigt.

### 1. Bartlänge

Wie verteilt sich die Bartlänge der Piraten?

Bitte erstellt ein Histogramm und gebt ihm einen Titel.

Was fällt euch auf? Habt ihr eine Vermutung, was das bedeutet?

Mit `fill =` innerhalb der Klammern hinter `aes` könnt ihr eine weitere
Variable darstellen lassen. Schaut, ob sich eure Vermutung bestätigt!

### 2. Schwerter

Gibt es einen Schwert-Typ, der am häufigsten benutzt wird?

Wie könnt ihr das herausfinden?

Welcher Schwerttyp ist keine besonders gute Waffe?

### 3. Größe und Gewicht

Als nächstes visualisiert bitte die Größe und das Gewicht der Piraten
als Streudiagramm und markiert, ob sie ein Kopfband tragen oder nicht.
Beschriftet die Achsen und die Legende.

Was denkt ihr, gibt es einen Zusammenhang zwischen dem Tragen eines
Stirnbandes und dem Gewicht?

Wie man soetwas statistisch sauber testet, lernen wir später. Aber eine
visuelle Einschätzung gibt meist schon gute Hinweise.

### 4. Filtern der Daten

Häufig ist es ja wichtig, die Daten zu trennen in zwei unterschiedliche
Datensätze.

Erstellt einen Datensatz `female_pirates` und einen `male_pirates` und
speichert ihn in dem Ordner “/data/derived\_data”

**Viel Erfolg!**

Sprecht euch untereinander ab und wenn die ganze Gruppe nicht
weiterkommt, schreibt mir!

Hinweis: Das Rmarkdown-Dokument soll später von anderen gegengelesen
werden. Versucht euch deshalb an die “Style Guide” Vorgaben zu halten.
