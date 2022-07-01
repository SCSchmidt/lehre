# Diagramme erstellen: ggplot2

ggplot2 wurde von Hadley Wickham entwickelt, es ist ein Paket mit vielen
Funktionen zur Visualisierung von Daten und folgt einer “Grammatik der
Diagramme”. Man kann sich das ein wenig wie Ebenen in einem
Zeichenprogramm vorstellen.

Erarbeiten wir uns das Schritt für Schritt.

Das Paket heißt ggplot2, aber die Funktion, die wir benutzen heit
`ggplot()`. Das Minimum an Argumenten, die wir festlegen müssen ist:
Welche Daten sollen benutzen werden (`data =` ), welche Art von Diagramm
soll entstehen (`geom_xxx`) und welche Variable auf welcher Achse
abgetragen werden soll (`aes()` von aesthetics).

Die Struktur eines Balkendiagrammes sieht z.B. dann etwa so aus:

    ggplot(data = ...) +
      geom_barplot(aes(x = ...))
      

Das + “verbindet” die beiden Zeilen und dem PC wird klar, dass das alles
zu einer Grafik gehört.

Es gibt noch viele weitere Anpassungsmöglichkeiten, die man immer mit
einem + hinzufügen kann. Einige werden wir hier kennen lernen. Man kann
mit `scales` die aesthetics bearbeiten, zum Beispiel Abstände auf der
x-Achse anpassen oder die Beschriftungen der Achsen. Mit `theme` kann
man dann jedes optische Element des Plots manuell anpassen, z.B. die
Position der Legende, Farbe der Beschriftung…

Das Lehrbuch <https://r-intro.tadaa-data.de/book/visualisierung.html>
gibt eine Menge guter Tips!

Jetzt aber zu den Diagrammen. Es geht im Folgenden um

-   Säulendiagramme

-   Streudiagramm

-   Facettierungen

-   ggplot-Hilfen

## ein Säulendiagramm

Ein Säulendiagramm eignet sich zur Darstellung von Häufigkeiten
nominaler und ordinaler Variablen. Eine ganz typische Frage ist ja: Wie
häufig gibt es etwas in der Phase x.

Dafür nehmen wir den Datensatz BACups und tragen auf der x-Achse die
Phase ab. Wie viele Datensätze (Reihen, also Tassen) es in jeder Phase
gibt, zählt R dann von alleine aus:

``` r
library(ggplot2) # 1. "Laden" des Pakets, einmal pro Sitzung!

ggplot(data = BACups)+ # data = Datensatz, der visualisiert werden soll
  geom_bar(aes(x = Phase)) #geom_bar bedeutet, ich hätte gern ein Balkendiagramm, in der aesthetic wird festgelegt, dass auf der X-Achse die Angaben aus der Spalte Phase abgetragen werden
```

![](2h_Kurs_ggplot_Säulen_files/figure-markdown_github/erstes%20Säulendiagramm-1.png)

Jetzt kann man viele Dinge verschönern

1.  B. Den Achsen eine andere Beschriftung geben:

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase))+
  labs(y = "Häufigkeit", #der y-Achse einen neuen Namen geben
       title = "Vorkommen der zwei Phasen") # dem ganzen Plot eine Überschrift geben
```

![](2h_Kurs_ggplot_Säulen_files/figure-markdown_github/erstes%20Säulendiagramm%20mit%20Achsen-Titel-1.png)

Oder einen anderen Look wählen (ein anderes Thema):

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase))+ 
  labs(y = "Häufigkeit",
       title = "Vorkommen der zwei Phasen")+
  theme_bw() #andere Möglichkeiten theme_classic, theme_grey, theme_minimal
```

![](2h_Kurs_ggplot_Säulen_files/figure-markdown_github/erstes%20Säulendiagramm%20mit%20anderem%20Thema-1.png)

Oder die Säulen bunt einfärben:

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase, 
               fill = Temper))+ # fill gibt den Balken unterschiedliche Farben, je nach den Angaben in der Spalte Temper
  labs(y = "Häufigkeit",
       title = "Vorkommen der zwei Phasen")+
  theme_bw() 
```

![](2h_Kurs_ggplot_Säulen_files/figure-markdown_github/erstes%20Säulendiagramm%20und%20jetzt%20bunt!-1.png)

Super, wenn das alles geklappt hat! Weiter geht es mit dem Thema
[Streudiagramme, Facettierung und Speichern von
Bildern](https://github.com/SCSchmidt/lehre/blob/R-Kurs-Koblenz/analysis/paper/2h_Kurs_Streudiagramm.md).
