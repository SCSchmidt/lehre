# Lineare Regression

Vorhin hatten wir das Thema Korrelation und dabei den R-Wert von
Pearson-Bravais von der Größe und des Gewichts der Piraten und der
Pinguin-Schnabellänge und -dicke bestimmt.

Jetzt erstellen wir noch eine Linare Regression daraus. Also laden wir
als erstes die Datenpakete:

``` r
# Pakete und Daten laden
library(yarrr)
data(pirates)
```

## Lineare Regression

Die lineare Regression legt eine “best-fit”-Linie zwischen die Punkte.
Sie soll möglichst gut den Punktverlauf abbilden.

Die Berechnung in R erfolgt sehr einfach mit dem Befehl `lm` (= “linear
model”). So ein Modell wird häufig “fit” genannt (“Passung”).

``` r
# Regressionsmodell als Objekt definieren
fit <- lm(weight ~ height, data = pirates) # Berechnung: 1. Variable ist die abhängige Variable, 2. Variable die "vorhersagende" Variable
```

Schaut man sich dieses Modell dann einmal mit `summary` an, erhält man
eine ganze Reihe an Informationen:

``` r
# Zudammenfassung des Modells
summary(fit)
#> 
#> Call:
#> lm(formula = weight ~ height, data = pirates)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -12.3592  -2.6564  -0.0708   2.7275  11.1451 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -68.87722    1.71250  -40.22   <2e-16 ***
#> height        0.81434    0.01003   81.16   <2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 3.928 on 998 degrees of freedom
#> Multiple R-squared:  0.8684, Adjusted R-squared:  0.8683 
#> F-statistic:  6587 on 1 and 998 DF,  p-value: < 2.2e-16
```

Erst einmal wird wiederholt, wie das Modell berechnet wurde, dann gibt
es einen Überblick über die Residuen und Werte Wie die Schätzung des
Y-Achsenabschnitts und des Steigungswinkels. Daraus kann man sich selber
schon die Formel für die Regressionslinie ableiten:

`y = -68.877 + 0.814 * x`

Außerdem finden wir den Hinweis auf die Standardabweichung, den t-Wert
und die Irrtumswahrscheinlichkeit für diese beiden Werte. Sowie die
Standardabweichung der Residuen, den R²-Wert und dessen
Wahrscheinlichkeit (mit einem F-Test getestet).

Bei einer Korrelations- und Regressionsanalysen ist es immer sinnvoll
die Daten erst einmal zu visualsieren. Für die beiden metrischen
Variablen Höhe und Gewicht empfiehlt sich ein Streudiagramm.

``` r
# Paket laden
library(ggplot2)

# Streudiagramm erstellen
plot <- ggplot(data = pirates, aes(x = height, y = weight)) +
  geom_point()
plot
```

![](./figures/streu-1.png)

``` r
# Paket laden
library(ggplot2)

# Streudiagramm erstellen
plot + geom_smooth(method = "lm", se = FALSE)
```

![](./figures/fit-1.png)

Wir haben nun ein Objekt `plot` definiert. Gemäß des “layering”-Prinzips
von `ggplot2` können wir diesem Objekt nun noch ein weiteres `geom`
hinzufügen.

Bei einer Regression ist es immer sinnvoll die “best fit” Linie zu
visualsieren. In R ist das ziemlich einfach, in dem ich einem
Streudiagramm den `geom_smooth()`-Befehl mit der Methode “`lm()`”
(linear model) hinzufüge. Der Befehl “`se = FALSE`” sagt aus, dass ich
jetzt *kein* Konfidenzintervall (standard error) dazu visualisieren
möchte.

``` r
# Grafik um einen Layer ergänzen
plot +
  geom_smooth(method = "lm", se = FALSE)
```

![](./figures/konfi-1.png)

Einfach oder?

Dieses Diagramm können wir jetzt noch ein bisschen verbessern. Wir
könnten doch das Konfidenzintervall angeben. Zu diesem Zweck setzen wir
einfach: `se = TRUE`.

``` r
# Grafik mit einem weiteren Layer definieren
plot <- plot +
  geom_smooth(method = "lm", se = TRUE)
plot
```

![](./figures/lin_reg_se-1.png)

Denkbar einfach. Das Konfidenzintervall ist sehr schmal, was für eine
gute Anpassung der Linie an die Punkte spricht.

Aber das kann man doch vielleicht nich ein bisschen besser machen. Wir
könnten doch dazu schreiben, wie diese Linie mathematisch beschrieben
werden kann und angeben, wie der R²-Wert der Linie aussieht.

Wir brauchen dafür das Paket `ggpmisc`. Installiert Euch das mit
`install.packages`.

Dann fügen wir dem bisherigen Plot den Befehl `stat_poly_eq()` hinzu.
`stat_poly_eq` kann die Informationen als “label” hinzugfügen. Dafür
nutzen wir `paste` (füge ein) die Formel (`..eq.label..`,) und den
R²-Wert (`..adj.rr.label..`) und separiere die beiden mit vier
Leerzeichen (symbolisiert durch die Tilde). Am Schluss färben wir diesen
Text noch grau ein.

``` r
# Paket laden
library(ggpmisc)

# Diagramm erstellen 
plot <- plot +
  stat_poly_eq(
    aes(
      label = paste(
        ..eq.label.., # kopier die Formel (equation)
        ..adj.rr.label.., # hänge die Sternchen an das R²-Label an
        sep = "~~~~" # trenn es mit vier Leerzeichen
      )
    ), 
    color = "gray50"
  )
```

Cool oder?

Eine Angabe würde uns noch interessieren, und das ist der p-Wert.

Normalerweise würde ich den p-Wert auch mit `ggpmisc` einbauen. Dort
gibt es noch eine weitere Funktion namens `stat_fit_glance()` mit der
sich der `..p.value..` einfach einfügen lässt. Im Code sieht das dann so
aus:

    # Plot mit einem weiteren Layer erstellen
    plot + 
      stat_fit_glance(
        aes(
          label = paste(
            "p-Wert: ", 
            ..p.value.., # Der eigentliche p-Wert
            sep = "")
      ),
      label.x = 'right', 
      label.y = 'bottom', 
      color = "gray50"
    )

Der pirates Datensatz ist ja kein “realer Datensatz” sondern ein
konstruiertes, simuliertes Beispiel, das Informationen zu 1000 Piraten
enthält. Bei solch hohen Fallzahlen kann der p-Wert schnell sehr klein
werden. Für die piraten ist der p-Wert so klein, dass R ihn tatsächlich
für eine Null hält und einfach nicht plottet! Deswegen wende ich hier
einen Trick an und füge mit `geom_text()` eine kleine Annotation ein,
die besagt, dass p \< 0.001 ist. Das müsst ihr aber nicht so machen,
denn `stat_fit_glance()` ist die elegantere Lösung, die für reale
Datensätze eigentlich auch ganz gut funktioniert.

``` r
# Plot mit einem weiteren Layer erstellen
plot +
  annotate(
    geom = "text", 
    x = 200,
    y = 40,
    label = "p < 0.001", 
    color = "gray50"
  )
```

![](./figures/unnamed-chunk-3-1.png)

Wenn man diese Grafik noch mit Titel und schöner Achsenbeschriftung
versieht, hat man echt eine publikationswürdige Grafik.

Achtet bei Regressionen immer darauf, was die abhängige Variable ist.
Zwischen dem Gewicht und der Größe der Piraten kann es nur einen
logischen Zusammenhang geben: Größe bestimmt Gewicht! Nicht das Gewicht
die Größe. In anderen Fällen kann das anders sein, also unklar, in
welcher der beiden Faktoren den anderen beeinflusst. Dann ist es
sinnvoll zwei unterschiedliche Regressionen zu berechnen und die
Abhängigkeit der Variablen umzudrehen.

## Residualanalyse

Wie in der Vorlesung erwähnt, muss die Verteilung der Residuen bei einer
linearen Regression bestimmte Voraussetzungen erfüllen. Dies testen wir
jetzt in einem zweiten Schritt.

Mit dem Befehl von oben `summary(fit)` konnten wir auch schon ein paar
Informationen zu den Residuen abfragen. Hier gab es den Minimalwert
(Min), das 1. Quartil (1Q), den Median, das 3. Quartil (3Q) und den
Maximalwert (Max), die einen Hinweis darauf geben, ob die Residuen
normalverteilt sind.

Außerdem gibt es noch ein paar andere Möglichkeiten, die Residuen zu
analysieren.

Den Q-Q-plot (genau wie bei dem Test auf Normalverteilung), dann einen
Plot, der die Residuen zu den vorhergesagten Werten vergleicht, um deren
Verteilung zu zeigen, ein Plot, anhand dessen man die Homoskedastizität
überprüfen kann und ein letzter Plot, der für die best-fit-Linie
besonders einflussreiche Punkte identifiziert.

All diese Plots werden mit der base - Funktion `plot` aufgerufen.

### Normalverteilung der Residuen

Der Q-Q-plot: Wenn die plot-Funktion auf eine lineare Regression
aufgerufen wird, kann man mit `which =` bestimmen, welche Teile jetzt
genau dargestellt werden sollen. `which = 2` erstellt ein Q-Q-plot. Mit
`col = "red"` färben wir die Punkte rot ein.

``` r
# Q-Q-Plot erstellen
plot(fit, which=2, col=c("red"))  # Q-Q Plot
```

![](./figures/qq_fit-1.png)

Natürlich kann man das auch so testen, wie wir es bei der
Normalverteilung gelernt haben:

``` r
# Paket laden
library(ggpubr)

# Q-Q plot erstellen
ggqqplot(fit$residuals)
```

![](./figures/qq_fitres-1.png)

Das gibt vielleicht ein bisschen publizierbareres Plot. Der Vorteil der
`plot`-Funktion von `base` ist, dass die Achsen schon beschriftet sind
und es schneller geht, wenn man nur intern gucken möchte, wie das
Ergebnis aussieht.

### Residuen und vorhergesagte Werte (residuals vs fitted)

Wenn wir die Residuen mit den vorhergesagten Werten vergleichen, können
wir sehen, ob die Residuen einem bestimmten Muster folgen. Das Ziel ist
hier, dass sie das nicht tun, also möglichst gleich verteilt sind.

Schauen wir uns das an:

``` r
# Residuals vs Fitted Plot erstellen
plot(fit, which=1, col=c("blue")) 
```

![](./figures/fitted_vs_residuals-1.png)

Die rote Linie zeigt eine Regression zwischen den Residuen und den
vorhergesagten Werten. Das “Ziel” für eine gute lineare Regression ist,
dass sie auf der 0-Achse liegt. Auch wenn es hier eine leichte Kurve
gibt, liegt sie aber doch ziemlich nahe dran und ergibt kein
distinktives Muster (z. B. eine Sinuskurve). Das zeigt, dass die
Residuen halbwegs gleichmäßig verteilt sind und damit eine Voraussetzung
für die lineare Regression erfüllt ist.

### “Scale-Location”

Hier schauen wir, ob die Homoskedastizität gegeben ist, d. h. die
Varianz der Residuen entlang der Regressionslinie etwa gleich bleibt.

Der Plot wird mit `which = 3` aufgerufen:

``` r
# Scale-Location Plot erstellen
plot(fit, which=3, col=c("blue"))
```

![](./figures/homoskedas-1.png)

Hier sollten die Punkte gleichmäßig in beide Richtungen der roten Linie
streuen.

Ein gutes und ein schlechtes Beispiel wären diese:

![](./figures/homoskedastizitaet_R.jpg) Das gute links, halbwegs
gleichmäßig verteilte Residuen und das schlechte rechts, wo die Residuen
in der linken Ecke deutlich näher an der roten Linie liegen als weiter
rechts, wo sie mehr streuen (Bildquelle und empfehlenswerte Anleitung:
<https://rpubs.com/iabrady/residual-analysis> ).

### Residuen gegen Ausreißer

Mit diesem Plot kann man die einflussreichen Punkte des Datensatzes
bestimmen. Ein einflussreicher Punkt ist einer, der wenn er entfernt /
hinzugetan wird, die Regressionslinie signifikant verändert. Dafür wird
die “Cook’sche Distanz” berechnet, ein Maß für den Einfluss eines
Punktes und die Grenzen für eine “Unbedenklichkeit” im plot mit roten
gestrichelten Linien angezeigt. Liegen Punkte außerhalb dieser “Grenze”
(der Markierung), sollte betrachtet werden, welche Rolle sie im
Datensatz spielen.

``` r
# Residuals vs. Leverage Plot erstellen
plot(fit, which=5, col=c("blue")) 
```

![](./figures/res_ausreisser-1.png)

In unserem Bsp wird die Cooksche Distanz nicht einmal mehr angezeigt,
die Schwellwerte liegen außerhalb unseres Bildbereichs. Insofern gibt es
hier keine Probleme.

Wir können also festhalten: Eine Lineare Regression ist für die
Beschreibung der Abhängigkeit des Gewichts der Piraten von ihrer Größe
ist zulässig. Die Regression kann recht sicher vorherhsagen, wie schwer
ein Pirat sein wird, wenn wir seine Größe kennen.

**Aufgabe:** Mit dem Pearson-Bravais-Test haben wir ja festgestellt,
dass der Zusammenhang zwischen Schnabeldicke und -länge nur sehr klein
zu sein scheint. Jetzt können wir an dieser Stelle einmal testen, ob die
Werte besser werden, wenn wir die Pinguine getrennt nach Art
untersuchen.

**Aufgabe:** Erstellt zwei lineare Regressionen für die
Chinstrap-Pinguine für ihre Schnabeldicke und -länge und prüft,

1.  ob die lineare Regression hier angebracht ist und

2.  welcher der beiden Parameter eher von dem anderen abzuhängen
    scheint!
