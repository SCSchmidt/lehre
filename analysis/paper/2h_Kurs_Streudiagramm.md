## Streudiagramme

Bei Streudiagrammen kann ich zwei metrische (aka echte Zahlen) Variablen
gegeneinander plotten. Das heißt, wir haben auf der X- und auf der
Y-Achse metrische Variablen und setzen pro Objekt im Datensatz einen
Punkt an die Stelle, wo sich die Werte in den beiden gewählten Variablen
(Spalten) treffen.

Der Befehl für ein Streudiagramm ist `geom_point`. Welche Variablen
abgetragen werden sollen, gehört zu den aesthetics-Elementen, deshalb
tun wir die Info in die Klammern hinter `aes`:

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
  geom_point(aes(x = RD, 
                 y = ND, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Streudiagramm%20mit%20schönen%20Punkten-1.png)
Wie man sieht,ist jetzt die Legendenbeschriftung aber noch nicht soo
toll: englisch und abgekürzt.

Auch das können wir ändern. Diesmal mit `scales`. Wir sagen, nimm die
Legende, die diskrete (discrete) Farben (color) zuweist,
`scale_color_discrete` und ändere den Namen. Genause mit der Form
(shape):

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, 
                 y = ND, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  scale_color_discrete(name  ="Magerungsgröße")+
  scale_shape_discrete(name  ="Magerungsart")+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Legende%20umbenennen-1.png)

Wir können die Beschriftung ändern. Dafür nutzen wir den `scales`-Befehl
und das Argument `label` und führen die gewünschten labels in der
Reihenfolge, wie sie erscheinen, auf:

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, 
                 y = ND, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  scale_color_discrete(name  ="Magerungsgröße",
                       labels = c("grob", "fein", "mittel", "sehr fein")) +
  scale_shape_discrete(name  ="Magerungsart",
                       labels = c("anorganisch", "organisch") )+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Legendenbeschriftung%20umbenennen-1.png)

Und die Farben, die sind vllt auch nicht so ganz publikationsreif. Es
gibt viele Möglichkeiten, Hexcodes, Namen, vordefinierte Paletten u.ä.
(siehe zB [hier](https://r-graph-gallery.com/ggplot2-color.html)), wie
man mit Farben in R umgehen kann. Wir wählen mal das einfachste und
nennen die Farben (`values`) in der Reihenfolge, wie wir sie den Werten
zuweisen möchten. Dazu müssen wir noch eine Sache ändern: Wenn wir eine
Legendenfarbe “händisch” ändern, muss der `scale` Befehl angepasst
werden zu `scale_color_manual`:

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, 
                 y = ND, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  scale_color_manual(name  ="Magerungsgröße",
                       labels = c("grob", "fein", "mittel", "sehr fein"),
                       values = c("blue", "orange", "red", "yellow")) +
  scale_shape_discrete(name  ="Magerungsart",
                       labels = c("anorganisch", "organisch") )+
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/Farben%20aendern-1.png)

## Facettierung!

Jetzt wird es nochmal richtig cool. Das Streudiagramm eben, den nochmal
nach unterschiedlichen Phasen anzulegen, das wär gut oder?

Dafür können wir `facet_grid` nehmen. In die Klammer dahinter können wir
zwei unterschiedliche Variablen setzen, die dann gegeneinander
abgetragen werden. Der Einfachheit halber, nehmen wir hier mal nur eine
und ersetzen die zweite mit einem Punkt.

``` r
  ggplot(data = BACups)+
  geom_point(aes(x = RD, 
                 y = ND, 
                 shape = Temper, # Form der Punkte
                 color = TempCoarse)) + # Farbe d. Punkte
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
    scale_color_manual(name  ="Magerungsgröße",
                       labels = c("grob", "fein", "mittel", "sehr fein"),
                       values = c("blue", "orange", "red", "yellow")) +
  scale_shape_discrete(name  ="Magerungsart",
                       labels = c("anorganisch", "organisch") )+
  facet_grid(.~Phase)+ #Aufspalten der Grafik in zwei Teil nach Phase
  theme_bw()
```

![](2h_Kurs_Streudiagramm_files/figure-markdown_github/geom_point%20facettieren-1.png)
Nur eine einzige Zeile Code mehr und ich habe meine Daten aufgesplittet
und in exakt gleichen Plots nebeneinander dargestellt. Super praktisch!

## Speichern!

Eins fehlt noch, das ist wichtig: Grafiken abspeichern. Auch hier gibt
es eine ganze Reihe von Möglichkeiten. Am intuitivsten finde ich
`ggsave`. ggsave nimmt die letzte ggplot-Grafik und speichert sie an dem
angegebenen Ort. DPI und Größe lassen sich einstellen:

``` r
ggsave("Pfad/wohin/grafik.png", dpi = 300, width = 15, height = 10, units = "cm")
```

## Zusammenfassung

Ganz kurz zur Rekapitulation des Kurses:

-   mit R-Skripten lassen sich Abfolgen von Befehlen automatisieren und
    wiederholen so häufig man möchte
-   wenn man mit einem Datensatz arbeiten will, muss man ihn einer
    Variablen zuweisen (`<-`)
-   ein Paket muss einmal installiert und nach jedem Neustart des
    Programms wieder neu eingeladen werden (`library()`)
-   mit dem Paket ggplot2 lassen sich leicht druckreife Grafiken
    erstellen
-   wer mehr wissen möchte, hier gibt es eine ganze Reihe an
    Skriptsammlungen: <https://scschmidt.github.io/lehre/> und außerdem:

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