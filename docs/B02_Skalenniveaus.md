### Skalenniveaus

Wir hatten über **Skalenniveaus** geredet und ich hatte auch erwähnt,
dass es dafür äquivalente in R gibt.

Der class-Befehl zeigt, welches Datenformat die Daten haben.

-   `boolean`: Das sind TRUE / FALSE - Angaben, man braucht sie häufig
    innerhalb von Funktionen, um bestimmte Parameter einzustellen

-   `factor` und `character` sind nominal, wobei `character` Buchstaben
    enthalten muss, `factor` nicht. Ein `factor` hat `level`, das sind
    die Werte, die in dem Vektor, der die `class factor` hat, enthalten
    sind

-   `ordered factor` ist ordinal

-   `numeric` und `integer`: metrisch

-   Es gibt zwei Typen bei den metrischen Daten, nämlich: `integer`
    (ganze Zahlen) und `double` (Kommazahlen, Dezimalzahlen)

Diese Typen findet man mit dem Befehl `typeof` heraus.

Um das alles einmal auszuprobieren, nehmen wir wieder den
Pinguin-Datensatz:

Zuerst laden wir das Paket:

``` r
library(palmerpenguins)
```

Und dann die Daten:

``` r
data("penguins")
```

Schauen wir uns als erstes den Gesamten Datensatz an:

``` r
class(penguins)
```

Der Output erzählt uns, dass es sich um eine Tabelle, einen `Data frame`
handelt.

Jetzt nehmen wir doch einmal nur eine Spalte der Tabelle, die erste,
“species”

``` r
class(penguins$species)
```

Ahja. Es ist ein Vektor mit factor - Daten, also mit Daten auf nominalem
Skalenniveau. Finden wir doch einmal heraus, welche Werte in dieser
Spalte stehen:

``` r
levels(penguins$species)
```

Ok, es sind genau 3 unterschiedliche Werte, die in dieser Spalte
vorkommen: “Adelie”, “Chinstrap” und “Gentoo”. Jetzt wissen wir schon,
dass es nicht mehr als drei Spezies in dem Datensatz gibt.

**Aufgabe:** Finde das gleiche zu der Spalte “island” heraus!

Wie gesagt, gibt es Unterschiede bei metrischen Daten. Schauen wir uns
also einmal die Schnabellänge (bill\_length\_mm) und die
Flügel-Flossenlänge (flipper\_length\_mm) an:

``` r
class(penguins$bill_length_mm)
class(penguins$flipper_length_mm)
```

Während die Schnabellänge eine `numeric` ist, ist die Flossenlänge nur
`integer`. Woran könnte das liegen? Beide Angaben sind in Millimeter
angegeben.

Ordinale Daten sind irgendwie logischerweise in R einfach
`factor`-Daten, deren Werte (`level`) eine Ordnung zugewiesen bekommen
haben. Das kann man recht einfach mit dem Befehl `ordered`. In dem
Pinguin-Datensatz gibt es dafür leider keine geeignete Spalte. Wir
spielen das trotzdem mit einer der nominalen Informationen durch, da das
für die Diagramm-Erstellung später durchaus sinnvoll sein kann.

Nehmen wir die Spalte “island”:

``` r
class(penguins$island)
```

Sie ist ein `factor`. Jetzt finden wir die `levels` heraus:

``` r
levels(penguins$island)
```

Wie ihr seht, sind die drei Inseln in alphabetischer Reihenfolge
aufgeführt. Das wollen wir jetzt ändern, da wir finden, dass die
Reihenfolge Torgersen - Dream - Biscoe viel sinnvoller ist, weil die
Inseln dann von Nord nach Süd aufgelistet werden. Das tun wir so:

``` r
penguins$island <- ordered(penguins$island, levels = c("Torgersen", "Dream", "Biscoe"))
```

Wir überschreiben mit der Zuweisung den bisherigen Stand der Dinge (\<-
). Die Funktion `ordered` braucht als Input als erstes welchen Datensatz
wir ordnen wollen und dann die Reihenfolge der `levels`. Diese “sammeln”
wir in einer Klammer hinter einem c: `c()`.

Schauen wir uns das Ergebnis an:

``` r
levels(penguins$island)
```

Tada! Es sollte geklappt haben.

Und noch etwas kann ich: Zahlen in Text umwandeln!

Manchmal ist das sinnvoll, nicht jede Zahl als Zahl zu verstehen,
sondern als Abkürzung für eine Kategorie. Bringen wir doch einmal die
Information zum Gewicht der Pinguine durcheinander. Wir gucken sie uns
vorher an:

``` r
class(penguins$body_mass_g)
```

Alles klar, integer.

Jetzt wandeln wir die Spalte in eine Text-Spalte um:

``` r
penguins$body_mass_g <-  as.character(penguins$body_mass_g)
```

Und gucken uns das Ergebnis an:

``` r
class(penguins$body_mass_g)
```

Das dumme ist nur, jetzt können wir damit keinen Mittelwert mehr
errechnen:

``` r
mean(class(penguins$body_mass_g)
```

Die Fehlermeldung ist eigentlich eindeutig. Wir haben den Computer
angewiesen, mit Text zu rechnen. Da er nicht von alleine auf die Idee
kommt, den Text in Zahlen umzuwandeln, gibt er uns den Fehler aus.

Aber, naja, wir wollen ja nicht, dass wir in der Folge falsche
Ergebnisse bekommen, deshalb benutzen wir jetzt folgenden Trick:

Der Vektor penguins$body\_mass\_g wurde von uns mit einem anderen
Datentyp überschrieben als er vorher war.

Was passiert, wenn wir einfach die Daten noch einmal neu einladen?

Also den data-Befehl noch einmal benutzen?

Ha! Damit überschreiben wir die falschen Daten einfach wieder. Solange
wir unsere Originaldaten irgendwo haben und diese NICHT ÜBERSCHREIBEN
(deswegen legen wir sie immer in einem anderen Ordner ab als die Daten,
die wir aus R hinaus wieder irgendwo abspeichern, nämlich im Ordner raw
data, dazu später mehr). Die Originaldaten sind im Paket palmerpenguins
unangetastet geblieben, weil wir sie nicht exportiert haben.

Und man braucht das alles nicht neu zu schreiben oder so, nein, man
scrollt in seinem Skript-Dokument einfach nach oben und wiederholt den
Befehl, der da noch irgendwo steht.

Tatsächlich ist das relativ häufig notwendig, wenn man versucht etwas
umzusetzen, was man noch nie gemacht hat und ein paar unterschiedliche
Dinge ausprobieren möchte…. muss… ;-)

Allgemeiner Tipp: Wenn nur ein Teil des Skripts funktioniert, immer erst
einmal stehen lassen, kopieren und an der Kopie rumprobieren bis alles
klappt. Wenn man die Lösung irgendwann hat, kommentiert man sie sich und
löscht alles, was vorher nicht geklappt hatte.