# Funktionen schreiben

Wir haben jetzt schon Funktionen angewandt und im Einzelfall auch
definiert.

Die Syntax dafür ist immer gleich:

    myfunction <- function(x){
      das wird mit x passieren
      }

Die neue Funktion heißt “`myfunction`”, sie wird auf eine Variable `x`
angewandt und was mit `x` passiert, wird in den geschweiften Klammern
definiert. `x` ist dabei der Platzhalter für das Objekt, dass der Nutzer
dann in die Funktion hineingeben wird.

Stellen wir uns vor, ich möchte eine Funktion für die Berechnung des
doppelten Mittelwertes von Vektoren. Die könnte z. B. so aussehen:

``` r
# Funktionsdefinition: doppelter Mittelwert
zwei_m <- function(x){
  2*sum(x)/length(x)
  }
```

Ich rechne zwei mal die Summe von x (d.h. x muss ein Vektor sein) und
teile dies durch die Länge des Vektors (Anzahl der Einträge). Ich nenne
die Funktion zwei_m.

zwei_m kann ich jetzt anwenden:

``` r
# Pakete und Daten laden
library(palmerpenguins)
data(penguins)

# Funktion anwenden
zwei_m(penguins$body_mass_g)
## [1] NA
```

Tja. Doof, ne. Das Problem kennen wir ja schon. Im Datensatz sind
NA-Werte, aber die Funktion hat noch keine Möglichkeit damit umzugehen.

Erweitern wir sie also!

``` r
# Funktionsdefinition: doppelter Mittelwert
zwei_m <- function(x){ 
  x <- na.omit(x)  # entferne aus x alle NA und überschreibe x damit ("Überschreibung" passiert nur innerhalb der Formel)
  2*sum(x)/length(x)
  }
```

Testen wir es also:

``` r
# Funktion anwenden
zwei_m(penguins$body_mass_g)
## [1] 8403.509
```

Yay!

In der Funktion habe ich definiert, dass das, was ich eingebe, erst
durch die Funktion `na.omit()` geschickt wird und sich dabei selbst
überschreibt. Damit wird dann weitergerechnet und - taadaaaaa - es gibt
kein Problem mehr!

Ich kann also in der Definition einer Funktion, andere Funktionen
aufrufen und mehrere Berechnungen “hintereinanderschalten”.

Es heißt, wenn man eine Abfolge von Berechnungen mehr als 3mal benutzt,
sollte man sie in eine Funktion packen, damit man den Code nicht immer
kopieren und einfügen muss. Außerdem kann man so Fehler vermeiden, weil
man nur noch die Funktion aufrufen muss und nicht mehr den ganzen Code
wiederholen.

Häufig braucht man dafür Möglichkeiten so etwas zu sagen “für jeden
dieser Werte, mach das”. Oder “wenn das dabei rauskomm, dann mach was
anderes als wenn dieses dabei herauskommt”. Das eröffnet das Thema der
**Schleifen**.

## Schleifen

Grundsätzlich lassen sich drei Formen von Schleifen unterscheiden:

-   die for-Schleife

-   die while-Schleife

-   die repeat (oder do-while) -Schleife

![](https://wgruber.github.io/R-Intro/Images/10_R_Loops.PNG)

In die muss man sich jeweils etwas eindenken, aber so sehr komplex sind
sie auch wieder nicht. In der Abbildung bedeutet *init* - initial, also
Beginn. *v element seq* ist die Frage ob es noch ein Element in der
Sequenz gibt. Wenn ja (T), wird der loop ausgeführt, wenn falsch (F),
endet er. *condit* im zweiten Bild, ist die Kondition / Bedingunge
(siehe unten). Solange sie wahr ist (T), wird die schleife ausgeführt.
Bei dem repeat loop (siehe auch unten), ist die *condit* -
Bedingungsabfrage am Ende des loops und, wenn T (wahr), wird
abgebrochen.

### Die for-Schleife

Sinn und Zweck der for-Schleife ist es, einen Code x mal auszuführen.
Die Variable x ist hierbei eine ganze Zahl (*integer*) oder jeder Wert
innerhalb eines Vektors. Das kann zum Beispiel so aussehen:

``` r
# Anzahl Iterationen definieren
x <- 5

# for-Schleife
for(i in 0:x) {
   print(i)
  }
## [1] 0
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
```

`for i in ...` ist dabei der Bereich, der sagt: für jedes Element i in …
(oben dem Bereich 0 bis x, also 5) mache bitte das folgende { in
geschweiften Klammern, hier: einfach nur “print”, d.h. drucke aus}.

Ich stelle mir einen Vektor mit Wörtern vor. Dann kann ich das auch so
machen:

``` r
# Vektor definieren
x <- c("Mein", "Pinguin", "ist", "niedlich")

# for-Schleife
for(i in x) {
  print(i)
  }
## [1] "Mein"
## [1] "Pinguin"
## [1] "ist"
## [1] "niedlich"
```

### Die while-Schleife

Die while-Schleife dienst grundsätzlich dazu, einen Code so lange
auszuführen, wie eine bestimmte Bedingung erfüllt ist.

Das kann z. B. so aussehen:

``` r
# Zählvariable definieren
i <- 0 

# While-Schleife definieren
while (i < 5) {
   i <- i+1;
   print(i);
   }
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
```

Was passiert?

Solange i kleiner als 5 ist, wird: i + 1 gerechnet und damit i
überschrieben und gedruckt.

Hier muss ich also immer eine Veränderung in der Schleife haben, die
dazu führt, dass die “while”-Bedingung irgendwann erreicht ist, sonst
läuft sie unendlich weiter…

Wie man merkt, wird dabei die “Entscheidung”, ob es weitergeht, immer
erst “oben” in der Funktion getroffen. D.h. während die Funktion im
Kreislauf läuft, wird bis zum Ende alles ausgeführt, wenn oben der
“while”-Befehl noch nicht erfüllt war. Deshalb wird i hier auch bis 5
gedruckt, denn im Kopf steht “solange i kleiner ist als 5 addiere eins
hinzu und druck es aus”. Man nennt das “Kopf-gesteuert”.

Unter bestimmten Umständen kann es sinnvoll sein, am Schleifenfuß die
Bedingung zu prüfen, unter der die Schleife ausgeführt wird. Diese
Anforderung erfüllt die

### repeat-Schleife (do while-Schleife)

Die Syntax lautet:

``` r
# Zählvariable definieren
i <- 0
repeat {
   i = i + 1;
   if (i == 5) break;
   print(i)
   }
## [1] 1
## [1] 2
## [1] 3
## [1] 4
```

Also, wiederhole (repeat) das addieren von 1 und drucken von i, aber
wenn i == 5, dann unterbrich den Vorgang (break).

Damit haben wir eigentlich schon die nächste Möglichkeit der Steuerung
von automatischen Prozessen kennengelernt: Die Bedingung.

### Bedingungen

Normalerweise wird ein R-Code Zeile für Zeile, von oben nach unten,
ausgeführt. Manchmal möchte man aber eine Zeile - oder einen ganzen
Block von Zeilen - nur unter einer bestimmten Bedingung durchführen.
Dazu bietet sich in R die If-Anweisung an.

Dabei gilt immer if / falls (die Bedingung in der Runden Klammer wahr
ist) {dann mach das in der geschweiften Klammer}:

``` r
# Prüfzahl definieren
d <- 100

# If-Bedingung
  if (d >= 90) {
    print(paste("Sehr gut.", d , "ist größer als 90"))
    }
## [1] "Sehr gut. 100 ist größer als 90"
```

Also, wenn d größer 90 ist, dann drucke diesen zusammengefügten Satz
(Funktion `paste()` setzt einen string aus mehreren Teilen zusammen)
“sehr gut”, der Wert d, “ist größer als 90”.

Ihr könnt ja mal ausprobieren, das d auf 85 zu setzen. Was passiert
dann?

Richtig. Gar nichts.

Sehr häufig möchte man aber, dass dann etwas anderes bestimmtes
passiert.

Dafür gibt es “else if”

``` r
# Prüfzahl definieren
punkte <- 85

# If-else-Bedingung
if (punkte >= 90) {
  print(paste("Sehr gut.", d , "ist größer als 90"))
  } else if (punkte >= 80 & punkte < 90) {
  print("Gut");    
  } else {
  print(paste("Nicht genügend.", d , "ist zu klein"));    
  }
## [1] "Gut"
```

Also: Wenn (`if`) die Variable `punkte` größer als 90 ist, drucke “Sehr
gut”

falls dem nicht so ist (`else if`) und die Variable Punkte liegt
zwischen 80 und 90, drucke “Gut”

und falls keine dieser Bedingungen erfüllt ist (`else`), drucke “nicht
genügend. der Wert ist zu klein”.

Immer wird die Bedingung dabei in runde Klammern gesetzt und die Aktion
in geschweifte.

Was macht der folgende Code?

``` r
# Prüfgröße definieren
x <- c(1, 3, 8)

# If-else-Bedingung definieren
if (mean(x) > 3) {
  print(mean(x))
  } else {
  print("Der Mittelwert liegt unter 4")
    }
```

**Aufgabe:** Diskutiert im Team:

1.  Was macht der Code?

2.  Was sollte gedruckt werden?

3.  Was muss angepasst werden, dass auch Mittelwerte größer 2 angezeigt
    werden?

#### Übung: Welcher Mittelwert ist größer?

Programmiert gemeinsam mit eurer Gruppe eine Funktion, in der von zwei
Vektoren die Mittelwerte genommen werden und dann der größere der beiden
Mittelwerte ausgegeben wird.

Ihr benötigt

1.  Das Berechnen der beiden Mittelwerte

2.  Der Vergleich, welcher der beiden Mittelwerte größer ist

3.  Den print-Befehl (Hinweis: Das Ergebnis einer Funktion kann man
    darin auch unterbringen)

4.  zwei kleine Mini-Vektoren zum Testen.

#### Übung: Welche Spezies hat den längsten Schnabel?

In der Praxis kommt es recht häufig vor, dass man Gruppenvergleiche mit
Hilfe einer for-Schleife macht. Schreibt doch mal eine Schleife, die für
jede Spezies unterschiedliche statistische Kennziffern zur Schnabellänge
ausgibt.

Ich gebe Euch hier mal ein Beispiel, wie man so einen Vergleich aufbauen
kann:

``` r
# Vektor erstellen
inseln <- unique(penguins$island) # enthält nur "einzigartige" Werte

# for-Schleife
for(insel in inseln) { # Iteration über jede Insel
  penguins_islands <- subset(penguins, island == insel) # Auswahl d. Insel
  mittel <- (mean(penguins_islands$body_mass_g, na.rm =TRUE)) # Mittel pro Insel
  stabw <- (sd(penguins_islands$body_mass_g, na.rm =TRUE)) # Stabw pro Insel 
  print(paste("Auf der Insel", insel, "wiegen die Pinguine im Durchschnitt", 
              round(mittel/100, 0), "+/-", round(stabw/100, 0), "kg.")) 
  }
```

Viel Erfolg!

## Zusammenfassend

Das Schreiben von kleinen Programmabläufen und Funktionen scheint von
weitem erst einmal unheimlich kompliziert. Ist es aber nicht! Wenn ich
sowieso Code schreibe, dann kann ich ihn auch in einer Funktion
zusammenfassen. Es fügt meistens lediglich eine kleine weitere
Abstraktionsstufe hinzu. Man kann sich eine Menge Arbeit sparen, wenn
man das an der richtigen Stelle anwendet.
