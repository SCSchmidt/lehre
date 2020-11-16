Korrelation
===========

Um Zusammenhänge zu erfassen, gibt es für jedes Skalenniveau
unterschiedliche Methoden:

-   für nominale Daten: Cramérs V

-   für ordinale Daten: Kendalls Tau

-   für metrische Daten: Pearson-Bravais r

für nominale Daten kurz wiederholt:
-----------------------------------

Cramérs V kennen wir schon. Nachdem der Chi-Qudrat-Test einen
Zusammenhang aufgezeigt hat, können wir Cramérs V nutzen, um die Stärke
des Zusammenhangs zu untersuchen. Chi-Quadrat ist in base
vorinstalliert, für Cramérs V brauchen wir das Paket `lsr`.

Als Beispiel stellen wir uns vor, wir hätten eine Wiese und untersuchen,
ob zwei Grasarten Sonnenplätze oder nicht Sonnenplätze bevorzugen.

Wir erstellen einmal eine kleine Stichprobe, zwei Test-Quadranten und
zählen aus:

Gras 1 in der Sonne: 27 Halme, Gras 2 in der Sonne 21 Halme, Gras 1
nicht in der Sonne 15 Halme, Gras 2 nicht in der Sonne 41 Halme.

Daraus bauen wir einen Datensatz:

``` r
df <- cbind(c(27, 15),c(21,41)) # cbind = "column bind" und kombiniert zwei Vektoren zu einem Datensatz

colnames(df) <- c("Gras1", "Gras2") # ich benenne die Spalten
rownames(df) <- c("Sonne", "keineSonne") # ich benenne die Zeilen
```

Jetzt können wir als erstes den Chi-Quadrat-Test rechnen:

``` r
chisq.test(df)
```

Und der p-wert ist so klein, das ist sicherlich ein Zusammenhang.

Jetzt der Cramers V:

``` r
library(lsr)

cramersV(df)
```

Auch das zeigt uns: Ja, den Zusammenhang gibt es. Nicht sehr stark, aber
er ist da.

Ein Problem will ich mit unserem Piraten-Datensatz verdeutlichen.
Schauen wir uns an, ob das Tragen eines Kopftuches (headband) und auf
welchem College die Piraten waren einen Zusammenhang hat. Vielleicht war
das ja nur bei einem der beiden Colleges ein Trend:

``` r
library(yarrr)
data(pirates)

table(pirates$headband, pirates$college)

e <- chisq.test(table(pirates$headband, pirates$college))

e
```

Wie kann man das Ergebnis interpretieren?

Denkt dran, man kann sich die Residuals (also die Abweichungen vom
erwarteten zu beobachteten Wert) anschauen:

``` r
e$residuals
```

Jetzt noch der Cramers V:

``` r
cramersV(table(pirates$headband, pirates$college))
```

Der Wert ist 0,03. Was sagt uns das?

Wenn ein Datensatz sehr groß wird (und 1000 Piraten ist sehr groß), wird
der Chi-Quadrat schon kleine Abweichungen als signifikant erachten. Der
Cramers V ist allerdings etwas sensibler gegenüber großen Datensätzen
und sieht einfach keinen nennenswerten Zusammenhang, weil die
Abweichungen sehr klein sind im Verhältnis zur Stichprobengröße.

Kendalls Tau für ordinale Daten
-------------------------------

Rechnen wir doch einfach das Bsp aus der Präsentation nach: Wir haben
einen Datensatz mit 4 Wolfsrudeln, deren Anzahl von Wölfen und Größe
ihres Territoriums. Wir brauchen für den Test zwei Vektoren, die in der
richtigen Reihenfolge diese beiden Wertereihen darstellen:

``` r
ha <-  c(2, 1, 4, 1.5)
nWoelfe <-  c(6, 9, 15, 3)
```

Jetzt geben wir diese in die Korrelationstestfunktion ein. R wählt
automatisch die benötigte Version (a ist standard und b, wenn es
Bindungen gibt). Über “alternative” kann man definieren, ob man schon
glaubt, dass die erste oder zweite Gruppe größere Ränge einnimmt als die
andere. Wir testen “two.sided”, d.h. wir wissen das nicht:

``` r
 cor.test(ha, nWoelfe, method = "kendall", alternative = "two.sided")
```

Sieh an, ich hab mich nicht verrechnet. :-)

Wenn man sehr viele Daten hat (sehr lange Vektoren), die man testen
möchte, kann die Berechnung sehr lange dauern (da ja jedes Paar
gegeneinander getestet werden muss). Dann informiert euch über Spearmans
Rho
(<a href="https://www.crashkurs-statistik.de/spearman-korrelation-rangkorrelation/" class="uri">https://www.crashkurs-statistik.de/spearman-korrelation-rangkorrelation/</a>),
der ist eigentlich wie der folgende (Pearson und Bravais r), aber an
Rängen wie Kendalls Tau. Er gilt als “weniger genau”, aber für große
Datensätze besser geeignet.

Der Code ist simpel:

``` r
 cor.test(ha, nWoelfe, method = "spearman", alternative = "two.sided")
```

Jetzt aber geht es noch um metrische Daten:

Pearson und Bravais’ R
======================

Für diesen Test können wir den gleichen Befehl nutzen, müssen nur die
Methode ändern. Und den Datensatz, denn mit Vektoren der Länge 4 ist der
Pearson-und Bravais’ R nicht glücklich.

Nehmen wir doch also einfach Größe- und Gewicht der Piraten:

``` r
cor.test(pirates$height, pirates$weight, method = "pearson", alternative = "two.sided")
```

Das Ergebnis sagt uns folgendes:

Der p-Wert ist sehr sehr klein, er wird über eine Testgröße t berechnet,
die den Wert 81,16 hat. Ein dafür wichtiger Freiheitsgrad (df) hat den
Wert 998 (erinnert ihr euch: n - 2, wir haben 1000 Piraten).

Das Konfidenzintervall liegt bei einem R-Wert zwischen 0,92 und 0,94.

Der in diesem Test errechnete Korrelationskoeffizient ist 0,93.

Wir haben also einen sehr sicheren und sehr starken Zusammenhang
zwischen der Größe und dem Gewicht der Piraten.

Applaus!

**Aufgabe: Ist das bei den Pinguinen genauso? Gibt es einen Zusammenhang
zwischen der Schnabellänge und Schnabeldicke?**
