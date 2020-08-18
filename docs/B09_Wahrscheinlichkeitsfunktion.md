Wahrscheinlichkeitsfunktionen
=============================

Es gibt eine ganze Reihe verschiedene wichtige
Wahrscheinlichkeitsdichtefunktionen, die für die Modellierung (d.h.
mathematische Beschreibung) unterschiedlicher Prozesse, Wertereihen u.ä.
benutzt werden. Auf die beiden wichtigsten gehen wir hier ausführlich
ein (Standardnormalverteilung und Binomialverteilung) und die anderen
werden nur kurz erläutert.

Standardnormalverteilung
------------------------

Wenn eine normalverteilte Variable ganz bestimmten Parametern folgt, ist
sie **standardnormalverteilt**.

Daten lassen sich von einer Normalverteilung in die
Standardnormalverteilung überführen. Die sogenannte z-Tranformation geht
auch in R ganz einfach. Schauen wir uns zuerst einmal die Gewichtsdaten
von nur einer Spezies Pinguine in einem Histogramm an:

``` r
library(ggplot2)
library(tidyr)
library(dplyr)

library(palmerpenguins)
data("penguins")


chinstraps <- penguins %>%
  filter(species == "Chinstrap")


ggplot()+
  geom_histogram(data = chinstraps, aes(x = body_mass_g), na.rm = TRUE)
```

Das sieht relativ normalverteilt aus, mit ein paar Lücken.

Jetzt können wir die funktion `scales` nutzen, um “body\_mass\_g” der
Chinstraps-Pinguine in eine standardnormalverteilte Zahlenreihe zu
bringen:

``` r
chinstraps$body_mass_g_z <- scale(chinstraps$body_mass_g)
```

Schauen wir uns jetzt das noch einmal an:

``` r
ggplot()+
  geom_histogram(data = chinstraps, aes(x = body_mass_g_z), na.rm = TRUE)
```

Tada! Auf der x-Achse sehen wir, dass die Zahlenwerte sich verändert
haben.

Wir können ja mal ausrechnen, wie viele der Werte zwischen -1 und 1
liegen:

``` r
chinstraps_1s <- chinstraps %>% #neuen datensatz kreiieren
  filter(body_mass_g_z >= -1 & body_mass_g_z <= 1) # in dem die chinstraps liegen, deren z-transformiertes Gewicht zwischen -1 und 1 liegt
```

Eigentlich müssten das jetzt etwa 68% sein. Rechnen wir also aus, wie
viele 68 % derChinstrap-Pinguine sind. Dazu nutzen wir die praktische
kleine Funktion `nrow`, die die Zeilen in einem Datensatz zählt und
damit bei uns die Anzahl der Pinguine in dem Datensatz. Das
multiplizieren wir mit 68 und teilen durch 100. nrow nutzen wir auch, um
den Datensazu chinstraps\_1s auszuzählen:

``` r
theorie_1s_chinstraps <- nrow(chinstraps)*68/100

nrow_chinstraps_1s <- nrow(chinstraps_1s)
```

Und die beiden Zahlen vergleichen wir einfach dadurch, dass wir sie
voneinander abziehen:

``` r
theorie_1s_chinstraps - nrow_chinstraps_1s
```

Der Unterschied liegt nur bei 3-4 Individuen. Das ist eine total
akzeptable Abweichung bei einer Stichprobengröße von 68
Chinstraps-Pinguinen!

Aber hmh. Kann ich das nicht testen?

Yes, we can!

Es gibt für jedes Skalenniveau Tests, die prüfen, ob Daten
normalverteilt sind.

Sind meine Daten normalverteilt?
================================

metrischen Daten: optisch und mit shapiro-wilk
----------------------------------------------

### Q-Q-plot

Optisch die Normalverteilung abzuschätzen ist sinnvoll, dann hat man
schon einmal eine Idee.

Nehmen wir also unseren Datensatz der Chinstrap-Pinguine und deren
Gewicht. Ein Q-Q-plot ist ein “Quantil-Quantil-Plot”: Die
Beobachtungswerte eines Merkmals werden der Größe nach geordnet und
abgetragen. Als Vergleich dienen die Quantile der Normalverteilung
(theoretische Verteilung), diese werden als Linie abgetragen. Wenn die
abgetragene Messwertreihe normalverteilt ist, stimmen die empirischen
und die theoretischen Quantile annähernd überein, d. h. die Werte liegen
auf einer Diagonalen.

Große systematische Abweichungen von dieser Diagonalen geben einen
Hinweis darauf, die Messwerte doch nicht normalverteilt sind. Das
Quantil-Quantil-Diagramm kann keinen Verteilungstest ersetzen.

Das Paket, in dem Q-Q-plots für R umgesetzt wurden, heißt `ggpubr`,
installieren wir es also:

``` r
install.packages("ggpubr")
```

Und wenden es an:

``` r
library(ggpubr)
ggqqplot(chinstraps$body_mass_g)
```

Man sieht: auf der x-Achse wird die theoretische Verteilung abgetragen
und auf der y-Achse die unserer Stichprobe (sample). Die Linie zeigt den
Idealverlauf an.

Fast alle Punkte liegen in der grauen Zone, die das Konfidenzintervall
von 95% darstellt. Das sieht also nicht ganz schlecht aus (wenn auch
nicht so ganz exakt).

Nur um einmal aufzuzeigen, wie das aussieht, wenn die Daten nicht
normalverteilt sind, können wir das Gewicht aller Pinguine nehmen: Da
sind mehrere Spezies drin und damit wird das eine Wertereihe sein, die
nicht normalverteilt ist:

``` r
ggqqplot(penguins$body_mass_g)
```

### Kerndichtefunktion (KDE)

Schauen wir deshalb doch mit der Visualisierung als Kerndichtefunktion
(engl. *kernel-density estimation*) weiter.

Die Dichtefunktion ist eine Abstraktion eines Histogramms. Man stelle
sich vor, dass jeder Datenpunkt auf der x-Achse abgetragen wird. Über
jeden Punkt wird eine kleine Gaußsche Glockenkurve gemalt. Die Werte
dieser Kurven werden übereinander addiert. Logisch ist, da wo viele
Punkte nah beieinander liegen, werden ganz viele Werte zusammenaddiert,
weil die Glockenkurven sich überlappen. Die Addition der Kurven wird
aufgezeichnet und dann lässt sich anhand der daraus resultierenden
Kerndichtefunktion zeigen, an welchen Stellen, viele Werte liegen und an
welchen wenige. Die y-Achse zeigt allerdings nicht mehr die absolute
Häufigkeit, wie bei einem Histogramm, sondern einen relativ abstrakten
Dichtewert. (Mehr Infos unter:
<a href="http://archaeoinformatics.net/kernel-density-estimation-visualised-in-r/" class="uri">http://archaeoinformatics.net/kernel-density-estimation-visualised-in-r/</a>).

In ggplot ist die Funktion dafür `geom_density`.

``` r
ggplot(chinstraps) +
  geom_density(aes(x = body_mass_g)) 
```

Wenn ich mir das anschaue, sieht das der Normalverteilung recht ähnlich.

Aber ganz sicher bin ich mir nicht.

Testen wir also die protoappeninen Gefäße jetzt mit dem richtigen Test:
Shapiro, los geht’s!

``` r
  shapiro.test(chinstraps$body_mass_g)
```

Ok, ok, was ist hier passiert?

Der Shapiro-Wilk Test testet, ob es einen signifikanten Unterschied
zwischen der Normalverteilung und den z-transformierten Daten der
eigenen Messwertreihe gibt. Da der Test die Daten selber transformiert,
müssen wir ihm nicht die z-transformierten Werte geben.

Nehmen wir das Ergebnis einmal auseinander.

R sagt:

        Shapiro-Wilk normality test

    data:  chinstraps$body_mass_g
    W = 0.98449, p-value = 0.5605

-   In der ersten Zeile noch einmal, welchen Test wir angewandt haben
-   in der zweiten Zeile, auf welchen Datensatz
-   und die dritte Zeile wird spannend. Da steht
-   W = 0,98499
-   p = 0,5605

*W* ist die in der Vorlesung erwähnte Testgröße, die mit einer
theoretischen Verteilung im Bezug auf die Wahrscheinlichkeit abgeglichen
wird, dass dieser Wert entsteht.

*p* ist die Wahrscheinlichkeit, dass wir uns irren, wenn wir die H\_0 -
Hypothese ablehnen.

Was war H\_0 noch einmal?

H\_0 ist: Es gibt keinen signifikatanten Unterschied zwischen der
Normalverteilung und meiner Messwertreihe.

Wir irren uns also mit einer Chance von 56 %, wenn wir das ablehnen und
behaupten würden, es gäbe einen Unterschied zwischen der
Normalverteilung und der Messwertreihe.

Applaus, das bedeutet, wir können davon ausgehen, dass unsere Daten
normalverteilt sind! Die Chinstrap-Pinguine sind in ihrem Gewicht
normalverteilt!

Ist das mit den anderen Pinguinarten auch so?

**Aufgabe: Erstellt ein QQ-plot, eine Kerndichteschätzung und macht
einen Shapiro-Wilk-Test für das Gewicht der Adelie - und der
Gentoo-Pinguine!**

Neben der Normalverteilung gibt es auch andere Verteilungsarten, die
wichtig für die Statistik sind:

Die Binomialverteilung
----------------------

Die Binomialverteilung kommt von “bi – nomen”, d. h. eine Verteilung
zweier nominaler Werte einer Variablen. Es darf nur diese zwei
Ausprägungen geben, die zusammengerechnet 100% des Datenstzes ausmachen.
Manche haben eine theoretische Verteilung, z. B. in menschlichen Gruppen
sind in der Regel 52% der geborenen Kinder weiblich und 48% männlich.
Intersexualität ist natürlich bekannt, deshalb ist das Beispiel nicht
ganz richtig, aber es wird noch immer häufig zitiert. Außerdem kann man
Anwesenheits- Abwesenheitsmerkmale nennen. Denn wenn eine Variable nur
“anwesend” und “abwesend” kodiert (dichotom oder binär), dann entsteht
immer automatisch eine Binomialverteilung.

Binomialtest
------------

Der Binomialtest testet die Häufigkeit eines Auftretens zweier
**nominalen** Werte gegenüber einer angenommenen theoretischen
Verteilung. Unser Beispiel sieht so aus:

Bei den Pinguinen gibt es männliche und weibliche. Wir testen, ob es
dort eine Ungleichverteilung gibt.

Wir stellen deshalb eine Hypothese auf: Der Weibchen- und Männchenanteil
der Pinguine ist genau 52:48.

Daraus entwickeln wir die statistischen Hypothesen:

-   H\_0 = Die Stichprobe lässt keinen Rückschluss auf die
    Grundgesamtheit zu und es kann keine Überrepräsentation von Männchen
    oder Weibchen im Datensatz festgestellt werden

-   H\_1 = ungerichtet: Es gibt Unterschiede in der Häufigkeit des
    Auftretens nach Geschlecht; gerichtet: es gibt mehr Männchen oder
    mehr Weibchen im Datensatz

Der Binomialtest ist in R base umgesetzt und sehr leicht ausführbar.
Zuerst zählen wir aus, wie viele Männchen und Weibchen wir haben. Dafür
gibt es einen einfachen Trick: Wir lassen R zählen, wie häufig
`penguins$sex == "male"` wahr ist (TRUE) und dadurch, dass wir das wie
eine Zahl behandelt und die Funktion `sum` (aufsummieren) darauf
ausführen, wandelt er alle TRUE in “1” um. Das gleiche noch einmal für
Frauen, daran denken, dass in manchen Datensätzen nichts steht
(`na.rm = TRUE`) und voilà

``` r
m <- sum(penguins$sex == "male", na.rm = TRUE)
w <- sum(penguins$sex == "female", na.rm = TRUE)
```

Wir haben die beiden Zahlen.

``` r
# Das ist die allgemeine Syntax binom.test(nsuccesses, ntrials, p, alternative="two.sided" OR "greater" OR "lesser")

# wir sagen: keine Ahnung, in welche Richtung das Ungleichgewicht geht:

binom.test(m, (m + w), 0.48, alternative = "two.sided")
```

Der Output sagt:

        Exact binomial test

    data:  m and (m + w)
    number of successes = 168, number of trials = 333, p-value = 0.3805
    alternative hypothesis: true probability of success is not equal to 0.48
    95 percent confidence interval:
     0.4494698 0.5594584
    sample estimates:
    probability of success 
                 0.5045045 

Am Anfang, welchen Test wir gemacht haben `Exact binomial test` und was
unsere beiden Datensätze waren `data:  m and (m + w)`. Die Anzahl von
“Erfolgen” (Männchen), die Anzahl der “Versuche” (alle betrachteten
Pinguine) und einen `p-Wert` von 0,38.

Die Alternativhypothese wird noch einmal genannt: “Die wahre
Wahrscheinlichkeit, dass man ein Männchen”zieht" ist nicht gleich 48%."

Es wird das 95%-Konfidenzintervall angegeben. Hier sehen wir, dass mit
einer Wahrscheinlichkeit von 95% der “wahre” Chance, zufällig ein
Männchen aus unseren Pinguinen zu ziehen zwischen 44,9% und 55,9% liegt.
Das sample-estimate gibt einem eine Chance von 50,5%, ein Männchen zu
erwischen.

Das heißt: In unserer Stichprobe sind 50,5% Männchen. Die Chance, dass
wir uns irren, wenn wir behaupten, dass in der Grundgesamtheit nicht 48%
Männchen sind, ist 38%. Deswegen weisen wir die Nullhypothese nicht
zurück. Es gibt keine signifikante Abweichung von der angenommenen
Verteilung.

**Aufgabe: Schaut noch einmal im Piratendatensatz, ist dort die
Verteilung der Männer und Frauen auch annähernd gleich? **

Denkt daran:

    library(yarrr)
    data("pirates")

Die Poisson-Verteilung
----------------------

Die Poisson-Verteilung wird dann eingesetzt, wenn man die Häufigkeit
eines Ereignisses über eine gewisse Zeit betrachtet. z. B., wie hoch ist
die Anzahl der Mutationen in einer DNA-Sequenz, wie hoch ist die Anzahl
der α-Teilchen, die eine radioaktive Substanz pro Sekunde aussendet.

Die Poisson-Verteilung kann als Annäherung an die Binomialverteilung
genommen werden, wenn n \> 100 gilt und der Erwartungswert der
binomialverteilten Zufallsgröße \< 10 ist. Das ist günstig, weil die
Poissonverteilung leichter zu berechnen ist als die Binomialverteilung.

Lest euch diese Seite durch, die die Informationen gut zusammenfasst:
<a href="https://matheguru.com/stochastik/poisson-verteilung.html" class="uri">https://matheguru.com/stochastik/poisson-verteilung.html</a>

Probiert vor allem den slider ganz unten aus!

In R lässt sich die Poissonverteilung zB so generieren:

``` r
p_bsp <- rpois(1000, 10) # rpois(n, lambda-value)
```

und dann plotten:

``` r
ggplot()+
  geom_density(aes(x = p_bsp))
```

Wir können testen, ob eine Messreihe einer bestimmten Häufigkeit pro
Zeiteinheit folgt, in dem wir den `poisson.test` machen. Als Werte
werden angegeben: 1. x = die Anzal von Events (was auch immer wir
gezählt hatten), 2. T = wie viele Zeiteinheiten verstrichen sind, in der
die Zählung stattfand und 3. r = das hypothetische Verhältnis, gegen das
ich testen möchte. Wie bei den anderen Tests kann ich als Alternative
“two.sided”, “less” oder “greater” angeben. Außerdem kann ich das
Konfidenzintervall bestimmen (`conf.level`).

Möchte ich also testen, ob pro Tag 4 Füchse vor meine Kamerafalle laufen
und ich habe eine Kamera 20 Tage dastehen gehabt und in der Zeit kamen
75 Füchse vorbei, dann kann ich das mit diesem Code untersuchen:

``` r
poisson.test(75, T = 20, r = 4,
    alternative = c("two.sided"),
    conf.level = 0.95)
```

    ## 
    ##  Exact Poisson test
    ## 
    ## data:  75 time base: 20
    ## number of events = 75, time base = 20, p-value = 0.615
    ## alternative hypothesis: true event rate is not equal to 4
    ## 95 percent confidence interval:
    ##  2.949613 4.700657
    ## sample estimates:
    ## event rate 
    ##       3.75

Das Ergebnis sagt mir: Die Wahrscheinlichkeit ist 61 % dass wir uns
irren, wenn wir die Alternativhypothese annehmen. Der wahre Wert pro Tag
liegt mit 95%iger Wahrscheinlichkeit zwischen 2,9 und 4,7. In unserem
Beispiel (sample estimate) kamen 3,75 Füche pro Tag. Wir können also
davon ausgehen, dass es keinen statistisch signifikanten Unterschied zu
unserer Annahme (es sind 4 Füche pro Tag) gibt.

**Aufgabe** Überlegt, wofür ihr einen Poisson-Test evtl. noch gebrauchen
könntet!

Die logistische Verteilung
--------------------------

Die logistische Verteilung ähnelt der Normalverteilung in der Form, hat
aber einen “schwereren Schwanz”, d.h. höhere “Kurtosis”, d.h. sie
längere Randbereiche.

Die logistische Verteilung wird genutzt um z. B. Lebensdauern von
Geräten zu modellieren oder für die Beschreibung von Wachstumsprozessen
mit Sättigungstendenz.

![](https://upload.wikimedia.org/wikipedia/commons/4/4a/Logistic_a0_b05.png)

(blau die Dichteverteilung, rot die kumulative Funktion)

In R kann ich eine zufällige Stichprobe aus der logistischen
Verteilungsfunktion mit `rlogis` generieren, wobei n die Anzahl der
gezogenen Werte ist, location die Verschiebung auf der X-Achse und scale
wie breit sie wird:

``` r
# rlogis(n,location,scale)

logis_bsp <- rlogis(1000, 4, 1)

ggplot()+
  geom_density(aes(x = logis_bsp))
```

**Aufgabe**: Probiert doch einmal ein paar unterschiedliche Werte aus!
Wie verändert sich die Verteilung?

Logarithmische Normalverteilung (lognormal)
-------------------------------------------

Die logaritmische Normalverteilung kann nur positive Werte annehmen. Da
sie die Verteilung von y = ln(x) beschreibt, wobei ln den natürlichen
Logarithmus zur Basis 10 beschreibt. Das ist für viele natürliche
Phänomene damit eine etwas bessere Beschreibung als die
Normalverteilung, da z.B. Körpergröße keine Minuswerte annehmen kann.
Viele Variationen natürlicher Phänomene lassen sich mit der
Log-Normalverteilung beschreiben, da sich hier viele kleine prozentuale
Abweichungen zusammenwirken, also miteinander multiplizieren. In der
Ökologie lassen sich z. B. die Häufigkeiten von Arten, Wasserführung
eines Sees oder Nähstoffkonzentrationen in Gewässern als
Log-Normalverteilung darstellen.

Die Besonderheit der logarithmischen Normalverteilung ist, dass diese
durch den Mittelwert und die Standardabweichung der Logarithmen
definiert wird. Dadurch entstehen teilweise sehr unterschiedlich
aussehende Kurven, die aber stets rechts einen längeren “Schwanz” haben
als links, da die Werte auf der x-Achse nicht unter 0 fallen können:

![](https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Lognormal_distribution_PDF.svg/1280px-Lognormal_distribution_PDF.svg.png)

In R kann die Funktion `rlnorm` genutzt werden, um eine Stichprobe aus
aus der Verteilung mit den gesetzten Parametern zu ziehen.

``` r
lnorm_bsp <- rlnorm(1000, meanlog=0, sdlog=0.5)

ggplot()+
  geom_density(aes(x = lnorm_bsp))
```

**Aufgabe**: Wieso heißen beiden gegebenen Argumente in der Funktionin
rlnorm “meanlog” und “sdlog”? Was vermutet ihr, bedeutet das? Wie groß
ist der Einfluss von den beiden Werten? Probiert ein wenig aus!

Herzlichen Glückwunsch!
-----------------------

Wir haben gelernt, wie man eine Verteilung untersucht, um festzustellen,
ob sie normalverteilt ist! Wir haben mit dem binomial-Test geschaut, ob
sich eine Variable einer bestimmten Verteilung entsprechend verhält und
haben dafür einen Wahrscheinlichkeitswert errechnet und noch eine ganze
Reihe anderer Wahrscheinlichkeitsverteilungen kennengelernt!
