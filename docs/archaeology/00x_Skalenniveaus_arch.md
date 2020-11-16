Skalenniveaus
=============

Wir hatten über **Skalenniveaus** geredet und ich hatte auch erwähnt, dass es dafür Äquivalente in R gibt.

Der class-Befehl zeigt, welches Datenformat die Daten haben.

-   `boolean`: Das sind TRUE / FALSE - Angaben, man braucht sie häufig innerhalb von Funktionen, um bestimmte Parameter einzustellen

-   `factor` und `character` sind nominal, wobei `character` Buchstaben enthalten muss, `factor` nicht. Ein `factor` hat `level`, das sind die Werte, die in dem Vektor, der die `class factor` hat, enthalten sind. `character` sind nicht auf diese Weise "kategorisiert".

-   `ordered factor` ist ordinal

-   `numeric` und `integer`: metrisch

-   Es gibt zwei Typen bei den metrischen Daten, nämlich: `integer` (ganze Zahlen) und `double` (Kommazahlen, Dezimalzahlen)

Diese Typen findet man mit dem Befehl `typeof` heraus.

Um das alles einmal auszuprobieren, nehmen wir archäologische Datensätze:

Zuerst laden wir das Paket (falls es nocht nicht installiert wurde, holt das mit `install.packages("archdata")` nach):

``` r
library(archdata)
```

und den Datensatz "Bornholm"

``` r
data("Bornholm")
```

Schaut einmal in die Beschreibung des Datensatzes "Bornhom". Das geht mit

``` r
?Bornholm
```

oder über den Hilfe-Reiter im Panel rechts unten.

Um was für Daten handelt es sich? Wer hat sie erhoben? Wie wurden sie publiziert?

Schauen wir uns einmal, wie R den ganzen Datensatz organisiert. Der "class"-Befehl zeigt uns das folgende:

``` r
class(Bornholm)
```

Der Output erzählt uns, dass es sich um eine Tabelle, einen `Data frame` handelt.

Schauen wir uns diese Tabelle einmal an:

``` r
View(Bornholm)
```

Jetzt nehmen wir doch einmal nur eine Spalte der Tabelle, die "Site"

``` r
class(Bornholm$Site)
```

Ok. Was bedeutet das?

Character beschreibt, dass es sich um Text handelt, der aber nicht in Gruppen klassifziert wird. Wenn ihr euch das genauer anschaut, erkennt ihr auch warum: Alle sites kommen nur eimal vor. Eine Gruppierung wäre hier Quatsch.

Schauen wir uns ein anderes Bsp an:

``` r
class(Bornholm$Period)
```

Die Periode ist ein "factor" und damit ein nominales Skalenniveau. Das ist eigentlich logisch. Aber. Hatten wir nicht gesagt, dass gerade relative Chronologie sich hervorragend für ein ordinales Skalenniveau eignet?

Richtig!

Allerdings sind die Perioden mit 1a, 1b, 2a, 2b etc kodiert. R sortiert diese Kategorien bei `factor`-Datensätzen "per default" alphabetisch. Das wäre also schon die richtige Reihenfolge. Trotzdem können wir das noch einmal explizit machen:

``` r
# Weil die aphabetische Reihenfolge schon inhärent ist, muss ich keine Reihenfolge angeben, in der ich sie ordnen möchte, sondern nur, dass ich sie ordnen möchte:

Bornholm$Period <- ordered(Bornholm$Period) 
```

Jetzt schaut einmal nach: Was hat sich verändert?

``` r
class(Bornholm$Period)
```

Und wie sieht die Ordnung aus? Mit dem "levels"-Befehl kann ich die Kategorien einer factor-Datenreihe anzeigen lassen:

``` r
levels(Bornholm$Period)
```

Weil ich es kann, bringe ich jetzt noch einmal Unordnung in diese Reihenfolge:

``` r
Bornholm$Period <- ordered(Bornholm$Period, levels = c("3a", "1b", "1a", "2c", "3b", "2a", "2b"))
```

Und überprüfe, was passiert:

``` r
class(Bornholm$Period)
levels(Bornholm$Period)
```

Was für eine Macht! Das Chronologie-System ist zerstört!

Und noch etwas kann ich: Zahlen in Text umwandeln!

Manchmal ist das sinnvoll, nicht jede Zahl als Zahl zu verstehen, sondern als Abkürzung für eine Kategorie. Das geht so:

Zuerst schau ich, dass ich einen Zahlendatensatz habe (nehmen wir die Spalte "Number" dafür):

``` r
class(Bornholm$Number)
```

Dann diese mit "as.character" umwandeln und noch einmal überprüfen:

``` r
Bornholm$Number <-  as.character(Bornholm$Number)
class(Bornholm$Number)
```

Aber, naja, wir wollen ja nicht, dass wir gleich falsche Ergebnisse bekommen, deshalb benutzen wir jetzt folgenden Trick:

Der Vektor Bornholm$Period wurde von uns mit der falschen Reihenfolge überschrieben. Und der Bornholm$Number mit einem anderen Datentyp als er vorher war.

Was passiert, wenn wir einfach die Daten noch einmal neu einladen?

Also den data-Befehl noch einmal benutzen?

Ha! Damit überschreiben wir die falsch geordneten Daten einfach wieder. Solange wir unsere Originaldaten irgendwo haben und diese NICHT ÜBERSCHREIBEN (deswegen legen wir sie immer in einem anderen Ordner ab als die Daten, die wir aus R hinaus wieder irgendwo abspeichern, nämlich im Ordner raw data, dazu später mehr). Die Originaldaten sind im Paket archdata unangetastet geblieben, weil wir sie nicht exportiert haben.

Und man braucht das alles nicht neu zu schreiben oder so, nein, man scrollt in seinem Skript-Dokument einfach nach oben und wiederholt den Befehl, der da noch irgendwo steht.

Tatsächlich ist das relativ häufig notwendig, wenn man versucht etwas umzusetzen, was man noch nie gemacht hat und ein paar unterschiedliche Dinge ausprobieren möchte.... muss... ;-)

Allgemeiner Tipp: Was funktioniert, immer erst einmal stehen lassen, kopieren und an der Kopie rumprobieren bis es klappt. Wenn man die Lösung irgendwann hat, kommentiert man sie sich und löscht alles, was vorher nicht geklappt hatte.

Wiederholung
------------

Machen wir den Spaß noch einmal mit einem anderen Datensatz namens "BACups"

1.  Einladen:

``` r
data("BACups")
```

1.  Informationen dazu lesen:

``` r
?BACups
```

1.  Schauen wir uns den Gesamten Datensatz an:

``` r
class(BACups)
```

Was für eine Art des Datensatzes ist es?

Jetzt nehmen wir doch einmal nur eine Spalte der Tabelle, die erste, "RD", das heißt Rim Diameter, also den Randumfang:

``` r
class(BACups$RD)
```

Es ist ein `numeric` Vektor, das heißt ein Vektor auf metrischem Skalenniveau. Welchen Typs dieser Datensatz ist, könne wir, wie oben erwähnt mit `typeof` herausfinden.

``` r
typeof(BACups$RD)
```

Was bedeutet "double" noch einmal?

**Aufgabe**: Welches Skalenniveau haben die Werte in der Spalte "Phase" und "H"?

Speichern und Einladen von Daten außerhalb von R-Paketen
========================================================

Speichern von Daten
-------------------

Es gibt unterschiedliche Möglichkeiten, Daten zu speichern. Eine davon ist als R-eigenes Format "RData". Der Befehl `save(data, file = "data.RData")` kann z.B. für den Datensatz BACups so genutzt werden:

    save(BACups, "dataBACups.RData")

Auch hier kann statt nur den Namen der Datei, die ich erstelle (im Bsp "dataBACups.RData") ein bestimmter Pfad angegeben werden.

Man kann Datensätze als csv und als excel-Dateien speichern.

     write.csv(data, "Pfad/wo/gespeichet/werden/soll/Name.csv")

Für Excel-Daten muss ein extra Paket installiert werden, namens "xlsx"

    install.packages("xlsx")
    library(xlsx)

Die Syntax ist dann vergleichbar zu csv:

    write.xlsx(data, "Pfad/wo/gespeichet/werden/soll/Name.xls, sheetName = "Sheet1")

Einladen von selbsterstellten Tabellendaten
-------------------------------------------

Für jede Art des Datenformats gibt es Möglichkeiten Daten zu laden.

1.  CSV-Dateien: comma-separated values, also Tabellen, deren Spalteneinträge durch Kommas voneinander getrennt werden, sind die einfachsten und häufigst die beste Möglichkeit Daten zu speichern. Sie werden eingeladen mit dem Befehl `read.csv2("Pfad/zu/meinen/Daten")`

2.  Excel-Daten: Für Excel-Daten muss ein extra Paket installiert werden, namens "xlsx"

<!-- -->

    install.packages("xlsx")
    library(xlsx)

Danach können die Daten so eingeladen werden: `mydata <- read.xlsx("Pfad/zu/meinen/Daten/myexcel.xlsx", 1)`, wobei 1 bedeutet, dass die erste Tabelle in der Arbeitsmappe "myexcel" eingeladen wird. Man kann auch den Namen der Tabelle angeben: `mydata <- read.xlsx("c:/myexcel.xlsx", sheetName = "mysheet")`

1.  RData

RData-Daten können mit einem einfachen `load()`-Befehl wieder eingeladen werden:

    load("dataBACups.Rdata")

### Zusammenfassung

Was haben wir hier gerade gelernt? Wir haben gelernt, welche Skalenniveaus in R wie kodiert werden, wie man den Datentyp eines Objektes herausfindet und umwandelt und wie man Daten lädt und speichert. Das sind ganz grundlegende Dinge, die wir immer wieder brauchen werden!
