## Daten einladen

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
install.packages("openxlsx") # 

library(openxlsx)

mydata <- read.xlsx("Pfad/zur/Datei/meineDatei.xlsx", sheet = 1)
```

## Speichern von Daten

Daten, die man modifiziert hat, möchte man manchmal einfach speichern,
damit man den Code, den man dafür geschrieben hat, nicht jedes mal
wieder laufen lassen muss. Außerdem kollaboriert man ja manchmal mit
Menschen, die kein R haben.

Für ersteres gibt es wie beim Einladen, so auch beim Schreiben von Daten
zwei Wege.

Um einen Datensatz namens `Datensatz` als Semikolon-separierte
csv-Tabelle zu schreiben, inder Kommas als Dezimaltrenner benutzt
werden, geht folgendermaßen:

``` r
write.table(Datensatz, 
           "Pfad/zum/Ordner/name_des_datensatzes.csv", 
           row.names = FALSE, 
           sep = ";",
           dec = ",",
           fileEncoding = "UTF-8")

write.csv2(Datensatz, "Pfad/zum/Ordner/name_des_datensatzes.csv", row.names = FALSE, sep = ",")
```

`row.names = FALSE` spezifiziert, dass man keine Zeilennamen haben
möchte, die R normalerweise automatisch erstellt. Manchmal möchte man
sie aber abspeichern, dann sollte man das auf `TRUE` setzen.

`fileEncoding = "UTF-8` ist immer eine gute Idee. So wird
sichergestellt, dass “ä”, “ö”, “ü” etc richtig gespeichert werden. Wenn
ich weiß, dass Daten in UTF-8 abgespeichert sind, kann ich das Argument
`encoding = "UTF-8"` beim Einladen der Tabelle in R nutzen, um
sicherzustellen, dass das alles klappt.

Um eine Excel-Tabelle zu schreiben, nehmt ihr wieder das Paket
`openxlsx`

``` r
write.xlsx(Datensatz, "Pfad/zum/Ordner/name_des_datensatzes.xlsx")
```

## Beispieldatensatz

Als Beispieldaten habe ich euch einen von mir abgewandelten Datensatz
des Pakets `archdata` per Email geschickt, es ist eine Tabelle über
Bronzezeitliche italienische Tassen. Ich hoffe, ihr habt ihn
heruntergeladen und gespeichert

Ladet den Datensatz ein.

``` r
#CSV-Datei
BACups <- read.csv2(".../BACups_tempered.csv", 
                     sep = ";", # Separator zwischen den Spalten ist Semikolon
                     dec = ",") # Dezimaltrenner Komma

# Excel-Datei:
library(openxlsx)
BACups <- read.xlsx(".../BACups_tempered.xlsx", sheet = 1)
```

Schaut euch den Datensatz an (In der Konsole`head(BACups)` oder in der
Environment drauf klicken).

Jede REIHE ist ein Objekt (eine bronzezeitliche Tasse) und jede SPALTE
beschreibt die Tasse mit einer Variablen:

-   ID – Identifikationsnummer
-   RD – Randdurchmesser
-   ND – Nackendurchmesser
-   SD – Schulterdurchmesser
-   H – Höhe
-   NH – Nackenhöhe
-   Phase – Phase
-   Temp – Magerung (hinzugedichtet)
-   TempCoarse – Grobheit der Magerung (hinzugedichtet)

Jetzt haben wir die Daten “im Programm”, jetzt können wir mit der
Visualisierung weitermachen, mit [ggplot und
Säulendiagrammen](https://github.com/SCSchmidt/lehre/blob/R-Kurs-Koblenz/analysis/paper/2h_Kurs_ggplot_S%C3%A4ulen.md)!
