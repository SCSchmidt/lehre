## Streudiagramme

Bei Streudiagrammen kann ich zwei Variablen einer Einheit gegeneinander
plotten.

Wir tragen auf der X- und auf der Y-Achse metrische Daten ab. Das gehört
zu den aesthetics-Elementen, deshalb tun wir die Info in die Klammern
hinter aes():

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, # Variable auf der x-Achse
                 y = ND)) #Variable auf der y-Achse
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Streudiagramm%20basics-1.png)

Jetzt können wir damit wieder die Dinge tun, die wir mit dem
Balkendiagramm gemacht hatten, also die Achsen beschriften, einen Titel
vergeben und den Style ändern:

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, 
                 y = ND)) + 
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Streudiagramm%20mit%20Titel,%20mit%20x-%20und%20y-Achsenbeschriftung-1.png)

Was kann man noch tolles machen? Die Form der Punkte von einer Variablen
bestimmen lassen! Und die Farbe!

Welches Merkmal, das ich in der Tabelle als Spalte aufgenommen habe die
Form der Punkte bestimmt lege ich mit `shape` fest, die Farbe mit
`color`.

``` r
ggplot(data = BACups)+
  geom_point(aes(x = H, 
                 y = SD, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Höhe des Gefäßes",
       y ="Schulterdurchmesser",
       title = "Höhe des Gefäßes im Verhältnis zum Schulterdurchmesser")+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Streudiagramm%20mit%20schönen%20Punkten-1.png)

## Facettierung!

Jetzt wird es nochmal richtig cool. Das Streudiagramm eben, den nochmal
nach unterschiedlichen Phasen anzulegen, das wär gut oder?

Dafür können wir `facet_grid` nehmen. In die Klammer dahinter können wir
zwei unterschiedliche Variablen setzen, die dann gegeneinander
abgetragen werden. Der Einfachheit halber, nehmen wir hier mal nur eine
und ersetzen die zweite mit einem Punkt.

``` r
  ggplot(data = BACups)+
  geom_point(aes(x = H, y = SD, shape = Temper, color = TempCoarse)) + 
  facet_grid(.~Phase)+ #Aufspalten der Grafik in zwei Teil nach Phase
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/density%20facettieren-1.png)
Nur eine einzige Zeile Code mehr und ich habe meine Daten aufgesplittet
und in exakt gleichen Plots nebeneinander dargestellt. Super praktisch!

## “Nachschlagewerke”

GGplot hat noch viel viel mehr Möglichkeiten. Um einen Überblick zu
bekommen, empfehle ich den Blogpost hier zu lesen, der vorführt, wie
sich so eine Visualisierung entwickeln kann und am Ende richtig richtig
gut aussieht:
<https://cedricscherer.netlify.com/2019/05/17/the-evolution-of-a-ggplot-ep.-1/>

Hilfen, um mit R und ggplot zurechtzukommen sind:

-   die Schummelzettel:
    <https://www.rstudio.com/wp-content/uploads/2015/06/ggplot2-german.pdf>

-   dieses R-Intro-Buch:
    <https://r-intro.tadaa-data.de/book/visualisierung.html>

-   das deutsche Wikibook zu R: <https://de.wikibooks.org/wiki/GNU_R>
    und

-   das englische R-Cookbook: <http://www.cookbook-r.com/>
