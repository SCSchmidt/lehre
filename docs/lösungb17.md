Lösung Aufgabe logistische Regression (B 17)
--------------------------------------------

``` r
library(palmerpenguins)
data("penguins")

penguins <- subset(penguins, penguins$species == "Gentoo")
penguins$sex <-  as.character(penguins$sex) # das muss sein, weil ich einem Faktor keine anderen Werte geben kann als die, die vorher definiert wurden (female und male)
penguins$sex[penguins$sex == "female"] <- "0"
penguins$sex[penguins$sex != "0"] <- "1"

penguins$sex <- as.numeric(as.character(penguins$sex))
```

1.  Logit berechnen:

**Aufgabe** Füllt diese Syntax aus und berechnet das logit!

1.  **Aufgabe** Die Summary-Statistik des Logit auswerfen lassen:

``` r
mylogit <- glm(sex ~ body_mass_g + flipper_length_mm, data = penguins, family = "binomial")


summary(mylogit)
```

    ## 
    ## Call:
    ## glm(formula = sex ~ body_mass_g + flipper_length_mm, family = "binomial", 
    ##     data = penguins)
    ## 
    ## Deviance Residuals: 
    ##      Min        1Q    Median        3Q       Max  
    ## -2.04876  -0.12327   0.00105   0.08416   2.63288  
    ## 
    ## Coefficients:
    ##                     Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)       -1.158e+02  3.196e+01  -3.624  0.00029 ***
    ## body_mass_g        1.064e-02  2.627e-03   4.051 5.11e-05 ***
    ## flipper_length_mm  2.864e-01  1.168e-01   2.451  0.01424 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 164.893  on 118  degrees of freedom
    ## Residual deviance:  37.321  on 116  degrees of freedom
    ##   (5 observations deleted due to missingness)
    ## AIC: 43.321
    ## 
    ## Number of Fisher Scoring iterations: 8

1.  **Aufgabe:** Diskutiert die Ergebnisse in eurer Gruppe! Was sagt das
    Estimate? Wie signifikant sind die Ergebnisse?

2.  **Aufgabe:** Berechnet die Veränderung der Chance, wenn das Gewicht
    zwischen 4000-5000 oder 5000 - 6000 liegt, die Länge der Flossen
    aber der Mittelwert bleibt.

Denkt daran, die Syntax von values trennt die Werte der beiden Parameter
mit Semikolon, aber die Spezifizierung der Schritte der Werte des ersten
Parameter muss mit Komma von dem Parameterwerten getrennt werden. Es
gibt die Möglichkeit, den Mittelwert eines Parameters festzulegen, indem
an seine Stelle `mean` schreibt:
`values = "Spannbreite d. 1. Parameters den ich betrachten möchte,Schritte für Gruppenbildung;Mittelwert 2. Parameters"`

``` r
library(glm.predict)
```

    ## Warning: package 'glm.predict' was built under R version 4.0.2

    ## Loading required package: MASS

    ## Loading required package: parallel

``` r
predicts(model = mylogit, values = "4000-6000,1000;mean", position = 1) 
```

    ##      val1_mean   val1_lower  val1_upper val2_mean val2_lower val2_upper
    ## 1 0.0005066115 8.802296e-08 0.003595002 0.4008935  0.2164937  0.6079295
    ## 2 0.4062227073 2.223809e-01 0.599995885 0.9990156  0.9952290  0.9999997
    ##      dc_mean   dc_lower   dc_upper body_mass_g_val1 body_mass_g_val2
    ## 1 -0.4003868 -0.6065967 -0.2164906             4000             5000
    ## 2 -0.5927928 -0.7775814 -0.3914064             5000             6000
    ##   flipper_length_mm
    ## 1          217.2353
    ## 2          217.2353

Wie kann man dieses Ergebnis diskutieren?

Jetzt berechnet noch die odds Ratio

``` r
exp(coef(mylogit))
```

    ##       (Intercept)       body_mass_g flipper_length_mm 
    ##      4.913956e-51      1.010699e+00      1.331594e+00

und visualisieren den Faktor Gewicht:

``` r
library(ggplot2)
  ggplot(data = penguins, 
         aes(body_mass_g , # logit-modell unabhängige Variable
             sex)) + # abhängige variable
  geom_point(alpha = 0.2) + # Transparenz
  geom_smooth(method = "glm", # Methode
              method.args = list(family = "binomial")) + # binomial angeben
  labs(title = "Logistic Regression Model",  # Beschriftungen
       x = "in Abhängigkeit von Gewicht", 
       y = "Chance Männchen zu sein")
```

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 5 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 5 rows containing missing values (geom_point).

![](lösungb17_files/figure-markdown_github/unnamed-chunk-5-1.png)
