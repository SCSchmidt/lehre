
Lagemaße
========

Lagemaße sind einfache Berechnungen von Werten, die uns etwas über die Verteilung der Werte aussagen soll. Am bekanntesten ist der Mittelwert, wir berechnen jedoch auch Modus, Median, Standardabweichung und Varianz.

-   Der Mittelwert berechnet sich in dem man alle Werte zusammenrechnet und durch die Anzahl der Werte teilt.
-   Der Median ist der Wert, der, wenn ich meine Wertereihe nach Größe ordne, den Datensatz in genau zwei Hälften teilt.
-   Der Modus ist der Wert, der am häufigsten vorkommt. Verteilungen können uni-modal sein (d.h. "eine Spitze" haben), oder bi- (zwei)- oder multimodal. Das ist wichtig für viele weitere statistische Überlegungen.
-   Die Standardabweichung sagt, wie wie stark die Streuung der Werte um den Mittelwert ist. Sie ist die Wurzel aus der Varianz.
-   Die Varianz ist die "mittlere quadratische Abweichung der Werte um den Mittelwert". Sie wird quadriert zur Berechnung, damit die Plus- und Minusabweichungen um den Mittelwert sich nicht aufheben. Dadurch ist die Zahl aber immer sehr groß. Die Standardabweichung ist für uns einfacher zu verstehen, weil sie diese Quadrierung wieder aufhebt.

Wir benutzen den Palmers Penguins-Datensatz, um das durchzuexerzieren und müssen ihn deshalb in R laden: einmal das Paket und dann die Daten:

``` r
library(palmerpenguins)
data("penguins")
```

Mit einem "&lt;-" wird ein Wert, den ich berechne einer Variablen zugewiesen, mit der ich später weiterrechnen kann. Das ist häufig eine gute Idee. Das Dollar-Zeichen bezeichnet den vector ("die Spalte") eines data frames ("der Tabelle"). Also "penguins$body\_mass\_g" ist die Spalte body\_mass\_g in der Tabelle penguins. Wir müssen R immer sagen, wie er mit fehlenden Werten im Datensatz umgehen soll. Mit fehlenden Werten kann R nicht rechnen, deswegen sagen wir in jedem dieser Befehle `na.rm = TRUE`, d.h. "ja (= TRUE, es ist wahr), entferne (remove) alls NAs".

Wir berchnen so die Lagemaße des Gewichts der Pinguine:

``` r
body_mass_g_mean <- mean(penguins$body_mass_g, na.rm = TRUE) # Hiermit wird der Mittelwert berechnet. (alle Werte zusammengerechnet / Anzahl der Werte)
body_mass_g_mean

body_mass_g_med <- median(penguins$body_mass_g,  na.rm = TRUE) #das ist die Berechnung des Medians. 
body_mass_g_med

tab <- table(penguins$body_mass_g) #hiermit kann man sich anschauen, wie häufig jeder Wert vorkommt (was der Modus ist)
tab 

body_mass_g_sd <- sd(penguins$body_mass_g,  na.rm = TRUE) #Standardabweichung
body_mass_g_sd

body_mass_g_var <- var(penguins$body_mass_g,  na.rm = TRUE) # Varianz
body_mass_g_var

body_mass_g_range <- range(penguins$body_mass_g,  na.rm = TRUE) # kleinster und größter Wert
body_mass_g_range
```

Euch ist vielleicht aufgefallen, dass es für den Modus keine Funktion in R zu geben scheint. Keine Ahnung warum. Aber man findet online schlaue Menschen, die eine Funktion geschrieben haben, mit der man ganz genauso den Modus abfragen kann, wie man den Median abfragen kann. Diese Funktion kann man einmal markieren und mit Strg+Enter ausführen und bekommt dann unter Environment und Functions angezeigt, dass man eine Funktion "getmode" erstellt hat. JETZT kann man sie anwenden, wie unten im Bsp.

``` r
# Funktion schreiben
getmode <- function(v) { # die Funktion heißt getmode und wird auf einen Vektor v angewendet
   uniqv <- unique(v) # die einzelnen Werte des Vektors (ohne Dopplungen) werden in einem Vektor uniqv gesammelt 
   uniqv[which.max(tabulate(match(v, uniqv)))] # welcher maximale Wert entsteht, wenn ich zähle, wie häufig die Werte von uniqv in v vorkommen (das ist der Modus)
}

mod_body_mass_g <- getmode(penguins$body_mass_g) # Modus 
mod_body_mass_g
```

**Aufgaben:** 1. Überprüft doch einmal, ob ihr mit der getmode genau den gleichen Modus bekommt, wie ihr selber mit table gefunden habt! :-)

1.  Berchnet die Lagemaße noch einmal für `penguins$flipper_length_mm`.

2.  Für welche Variablen im Datensatz können wir welche Lagemaße berechnen? Diskutiert mit eurer Gruppe!

Aussagen über die Verteilung
----------------------------

Jetzt schaut man sich diese Werte ja nicht ohne Grund an. Im Gegenteil, sie können einem eine ganze Menge über die Verteilung sagen.

-   Wenn Median = Mittelwert = Modus, handelt es sich um eine symmetrische Verteilung, wie z.B. die Normalverteilung (dazu unten mehr).

-   Wenn Modus &lt; Median &lt; Mittelwert, dann gibt es eine "linksgipflige Verteilung" (engl. *positive skew*), das heißt rechts entsteht ein langer Schwanz, während links der Anstieg steil ist. Logisch. Der Wert, der am häufigsten vorkommt, ist dann der kleinste, also ganz links. Da aber der Mittelwert relativ hoch ist, muss es ein paar wenige sehr hohe Werte geben.

-   Wenn Modus &gt; Median &gt; Mittelwert gilt, dann ist es eine "rechtsgipflige Verteilung" (*negative skew*), weil der Anstieg langsam ist und der Abfall schnell. Alles genau andersrum wie bei der linksgipfligen Verteilung.

-   Ist die Standardabweichung oder Varianz groß, ist die Verteilung "breit", sind diese Werte groß, ist sie hoch und schmal. Je kleiner Standardabweichung / Varianz sind, desto besser beschreibt der Mittelwert die ganze Zahlenreihe.

**Aufgabe:** Schaut euch die eben berechnete Werte (Pinguingewicht und Flossenlänge) noch einmal an. Wie ist das Verhältnis von Median, Modus und Mittelwert?

Wie stellt ihr euch die Verteilungen vor, nachdem ihr das und die Standardabweichungen berchnet habt? Diskutiert in der Gruppe!

Normalverteilung
================

Was ist eine Normalverteilung?

Die Normalverteilung ist eine in der Statistik häufig zitierte Beschreibung einer bestimmten Form von Messwertreihe. Sie hat folgende Eigenschaften:

-   Normalverteilungen sind symmetrisch.
-   Mittelwert, Median und Modus sind identisch, liegen genau in der Mitte und teilen die Verteilung in zwei gleich große Hälften (weil es ja der Median is).
-   Die meisten Werte liegen nah um den Mittelwert herum und je weiter man sich vom Mittelwert entfernt, desto weniger Werte findet man.

Die Normalverteilung ist wichtig, da ihr bestimmte biologische Merkmale folgen. So sind z.B. Körpergrößen in einer Population normalverteilt. Messfehler eines Instruments oder einer Person verteilen sich um den eigentlichen Wert normal. Und, und das ist für uns besonders wichtig: Ob meine Daten normalverteilt sind oder nicht, entscheidet darüber, ob ich bestimmte statistische Verfahren anwenden kann oder nicht. Sind meine Daten normalverteilt, kann ich sog. "parametrische" Verfahren benutzen, die meistens genauer sind. Dazu aber später mehr.

Erst einmal: Wir bauen uns in R selber eine Normalverteilung. R hat dafür eine Funktion `rnorm`. In ihr muss man noch angeben, wie viele Werte ich kreiieren möchte (`n =`), welchen Mittelwert (`mean =`) und welche Standardabweichung (`sd =`) die Daten haben sollen:

``` r
normal <- rnorm(100, 
                mean=5, 
                sd=2)
```

Schauen wir sie uns doch einmal genauer an!

**Aufgabe** Bitte berechnet Mittelwert, Median, Modus, Standardabweichung und Varianz von `normal`. Was hätten wir uns schon denken können?

### Wie schaut's aus?

Als nächstes visualisieren wir die Verteilung einmal. Häufig benutzt man dafür Histogramme. Über Histogramme in R kommt gleich noch mehr, aber erst einmal reicht es zu wissen, dass bei einem Histogramm auf der x-Achse immer metrische Werte eingetragen werden, die klassifiziert werden. Das ist der Unterschied zum Balkendiagramm, wo auf der x-Achse nominale Daten abgetragen werden.

``` r
library(ggplot2)
ggplot()+
  geom_histogram(aes(x = normal))
```

![](../figures/normalvert-1.png)

Das ist keine perfekt symmetrische Kurve, weil `rnorm` eine zufällige Stichprobe aus dem Bereich zieht, den wir vorgeben. Nichtsdestotrotz sind die Parameter erfüllt und es handelt sich um eine normalverteilte Datenreihe.
