# Korrelation

Ganz ähnlich wie bei dem Test auf Unterschiede, ist auch bei einer
Untersuchung auf Zusammenhänge das Skalenniveau und die Verteilung
entscheidend für die Auswahl eines geeigneten Verfahrens:

-   für nominale Daten: Cramérs V

-   für ordinale und nicht-normalverteilte metrische Daten: Kendalls Tau
    oder Spearmans Rho

-   für metrische, normatverteilte Daten: Pearson-Bravais r

## Cramers V

Cramérs V kennen wir schon. Nachdem der Chi-Qudrat-Test einen
Zusammenhang aufgezeigt hat, können wir Cramérs V nutzen, um die Stärke
des Zusammenhangs zu untersuchen. Chi-Quadrat ist in `base`
vorinstalliert, für Cramérs V brauchen wir das Paket `lsr`.

Als Beispiel stellen wir uns vor, wir hätten eine Wiese und untersucht.
Nun wollen wir wissen, ob zwei Grasarten Sonnenplätze oder
nicht-Sonnenplätze bevorzugen.

Wir erstellen einmal eine kleine Stichprobe, zwei Test-Quadranten und
zählen aus:

Gras 1 in der Sonne: 27 Halme, Gras 2 in der Sonne 21 Halme, Gras 1
nicht in der Sonne 15 Halme, Gras 2 nicht in der Sonne 41 Halme.

Daraus bauen wir einen Datensatz:

``` r
# Beispieldatensatz erstellen
df <- cbind(c(27, 15),c(21,41)) # cbind = "column bind" und kombiniert zwei Vektoren zu einem Datensatz

# Benennung
colnames(df) <- c("Gras1", "Gras2") # ich benenne die Spalten
rownames(df) <- c("Sonne", "keineSonne") # ich benenne die Zeilen
```

Jetzt können wir als erstes den Chi-Quadrat-Test rechnen:

``` r
# Test durchführen
chisq.test(df)
```

Und der p-wert ist so klein, das ist sicherlich ein Zusammenhang.

Jetzt der Cramers V:

``` r
# Paket laden
library(lsr)

# Cramers V berechnen
cramersV(df)
```

Auch das zeigt uns: Ja, den Zusammenhang gibt es. Nicht sehr stark, aber
er ist da.

Ein Problem will ich mit unserem Piraten-Datensatz verdeutlichen.
Schauen wir uns an, ob das Tragen eines Kopftuches (headband) und auf
welchem College die Piraten waren einen Zusammenhang hat. Vielleicht war
das ja nur bei einem der beiden Colleges ein Trend:

``` r
# Pakete und Daten laden 
library(yarrr)
data(pirates)

# Häufigkeitstabelle erstellen
table(pirates$headband, pirates$college)

# Testergebnis als Objekt definieren
e <- chisq.test(pirates$headband, pirates$college)
e
```

Wie kann man das Ergebnis interpretieren?

Man kann sich die Residuals (also die Abweichungen vom erwarteten zu
beobachteten Wert) anschauen:

``` r
# Residuen betrachten
e$residuals
```

Jetzt noch der Cramers V:

``` r
# Paket laden 
library(lsr)

# Cramers V berechnen
cramersV(pirates$headband, pirates$college)
```

Der Wert ist 0,03. Was sagt uns das?

Wenn ein Datensatz sehr groß wird (und 1000 Piraten ist sehr groß), wird
der Chi-Quadrat schon kleine Abweichungen als signifikant erachten. Der
Cramers V ist allerdings etwas sensibler gegenüber großen Datensätzen
und sieht einfach keinen nennenswerten Zusammenhang, weil die
Abweichungen sehr klein sind im Verhältnis zur Stichprobengröße.

## Kendalls Tau

Rechnen wir doch ein Beispiel: Wir haben einen Datensatz mit
Jahreseinkommen und Wohnfläche pro Haushalt und fragen uns ob es hier
einen Zusammenhang gibt. Wir testen vorab, ob diese Variablen
normalverteilt sind.

``` r
# Beispiele definieren 
einkommen_jahr_brutto <-  c(35.000, 37.000, 40.000, 44.000, 46.000, 
                            47.000, 50.000, 52.000, 70.000, 120.00 )
wohnflaeche_qm <-  c(30, 55, 50, 60, 67, 70, 55, 80, 100, 300)

# Pre-Test durchführen
shapiro.test(einkommen_jahr_brutto)
shapiro.test(wohnflaeche_qm)
```

Ok. das sind klassische Beispiele für schiefe Verteilungen. Machen wir
hier also mit einem paramterfreien Verfahren weiter. Wir geben unsere
Variablen in die Korrelationstestfunktion für Kendalls Tau ein. R wählt
automatisch die benötigte Version (a ist standard und b, wenn es
Bindungen gibt). Über “alternative” kann man definieren, ob man schon
glaubt, dass die erste oder zweite Gruppe größere Ränge einnimmt als die
andere. Wir testen “two.sided”, d.h. wir wissen das nicht:

``` r
# Test berechnen
cor.test(einkommen_jahr_brutto, wohnflaeche_qm, method = "kendall", alternative = "two.sided")
```

Wenn man sehr viele Daten hat (sehr lange Vektoren), die man testen
möchte, kann die Berechnung sehr lange dauern (da ja jedes Paar
gegeneinander getestet werden muss). Dann informiert euch über Spearmans
Rho
(<https://www.crashkurs-statistik.de/spearman-korrelation-rangkorrelation/>),
der ist eigentlich wie der folgende (Pearson und Bravais r), aber an
Rängen wie Kendalls Tau. Er gilt als “weniger genau”, aber für große
Datensätze besser geeignet.

Der Code ist simpel:

``` r
# Test berechnen
cor.test(einkommen_jahr_brutto, wohnflaeche_qm, method = "spearman", alternative = "two.sided")
```

## Pearson und Bravais’ R

Nehmen wir doch also einfach Größe- und Gewicht der Piraten.

Der Korrelationskoeffizient nach Pearson und Bravais gehört zu den
parametrischen Verfahren. Dementsprechend beginnen wir hier erst einmal
mit einem Test auf Normalverteilung.

``` r
# Test durchführen
shapiro.test(pirates$height)
shapiro.test(pirates$weight)
```

Puh, für das Gewicht können wir die Hypothese einer Normalverteilung
gerade noch so beibehalten :-)

Für den Korrelationstest können wir nun erneut den Befehl `cor.test()`
nutzen.

``` r
# Test durchführen
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
