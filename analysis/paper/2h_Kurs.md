# Einführung in R

Programmieren ist so schwer nicht. Ich ersetze das “klicken auf einen
button” mit “Text, der genau sagt, was getan werden soll”. Man nennt die
Umsetzungsform jedoch nicht umsonst “ProgrammierSPRACHE”. Wie bei einer
echten Sprache, muss man sich an gewisse Regeln halten. Im Gegensatz zu
normalen menschlichen Sprachen, verzeiht einem der Computer jedoch
kleine Fehler nicht. Das ist eigentlich die größte Schwierigkeit: Exakt
korrekt zu schreiben. Keine Kommafehler, keine Klammer vergessen, Groß-
und Kleinschreibung beachten… Analysen in Code (egal ob R oder Python
oder eine andere Skript- oder Programmiersprache) haben den großen
Vorteil, dass sie deutlich leichter reproduzierbar und replizierbar sind
als welche, die in Maus-gesteuerter Software erstellt werden (siehe
alles von Ben Marwick). Ich kann den Code jemand anderem geben und
er/sie kann bis ins letzte Detail nachvollziehen, was berechnet wurde.
Benutze ich keinen Code brauche ich dafür Beschreibungen, die eventuell
ausarten könnten. Über Reproduzierbarkeit hören wir nachher noch den
Vortrag von Dr. Karoune und Dr. Plomp.

Wenn sich in meinem Datensatz eine Kleinigkeit ändert, kann ich die
gesamte Analyse sehr sehr schnell einfach wieder durchführen – der Code
ist ja noch da, und der bleibt gleich. Wiederhole ich nach einem Jahr
eine Analyse mit anderen Daten, geht das sehr sehr schnell – der Code
kann einfach wieder benutzt werden.

Das ist ein Riesenvorteil.

### Warum R

R wurde 1992 von Ross Ihaka und Robert Gentleman, zwei Statistikern, in
Auckland als open und free source - Alternative zu der Sprache “S”
entwickelt. Da sie auch plattformunabhängig ist, ist sie immer und
überall benutzbar.

R wurde von Statistikern entwickelt und hat deshalb insbesondere für
statistische Analysen eine große Menge an Paketen und definierten
Funktionen, die von der Gemeinschaft beständig weiterentwickelt und
erweitert werden. Sie werden auf dem Comprehensive R Archive Network
(CRAN) zur Verfügung gestellt. Damit findet man eigentlich für jedes
Problem eine Lösung. Inzwischen kann man mir R ein GIS ersetzen, es
lassen sich interaktive und animierte Graphiken erstellen, Websites und
Präsentationsfolien bauen und sicherlich noch mehr, das ich nicht kenne…

Online gibt es eine Menge Ressourcen und Hilfestellungen, die einem die
Arbeit mit R erleichtern. Zugegebenermaßen ist der Einstieg nicht ganz
leicht, aber der Mehraufwand lohnt sich! Es gibt eine wachsende
Gemeinschaft von Archäolog\*innen, die es nutzen.

R selber hat keine schöne Benutzeroberfläche, sondern wird von der
Konsole aus “gesteuert”. Deshalb benutzern wir die Entwicklungsumgebung
Rstudio (es gibt noch andere wie RCommander, RGui), die einem Skript,
Konsole, Programmierumgebung und noch weiteres übersichtlich in Fenstern
anordnet.

## Einführung in die Grundlagen

R ist eine objektorientierte Sprache. Das heißt, alles ist in R entweder
ein Objekt oder eine Funktion. Eine Funktion “macht” immer etwas mit
einem Objekt. Wie im Mathe-Unterricht: f(x) = y = 2\*x rechnet für jedes
x den zugehörigen Wert (y) aus, der genau das Doppelte von x ist. Nur
können die Funktionen in R deutlich komplizierter werden…

Die Funktionen sind in Paketen gespeichert, die sich auf einander
beziehen: Wenn in Paket A eine Funktion f(x) liegt, in der die Funktion
g(x) aus Paket B benutzt wird, besteht eine Abhängigkeit (dependency)
von Paket A zu Paket B. Installiere ich Paket A, wird in der Regel
automatisch Paket B mitinstalliert, damit ich die Funktion f(x) auch
wirklich benutzen kann. Manchmal kommen aber trotzdem Fehlermeldungen
wie “error: could not find function”, dann kann es sein, dass eine
dependency nicht mitinstalliert wurde ODER nicht geladen wurde. Denn:
Wenn wir Funktionen aus einem Paket brauchen, müssen wir es installieren
und jedesmal, wenn wir es benutzen, am Anfang einer R-Sitzung laden (mit
der *library*-Funktion, Beispiele später). Die wichtigsten Funktionen
sind in R “base” vorinstalliert. Manchmal haben Funktionen in
unterschiedlichen Paketen den gleichen Namen. Dann gibt R eine Warnung
aus, “objects are masked”, d.h. die Funktionen des neu geladenen Pakets
“überschreiben” die alten. Nicht irritieren lassen, meistens
interessiert uns das nicht.

Funktionen erkennt man daran, dass hinter dem Funktionsbefehl oder
-namen in runden Klammern die Objekte stehen, auf die die Funktion
angewandt wird sowie Parameter, wie diese Funktion angewandt werden
soll. Ein einfaches Beispiel:

mean(x)

–\> “mean” ist der Funktionsname, auf x wird die Funktion ausgeführt.

Was könnte x, können Objekte sein? (Tatsächlich können Funktionen auch
als Objekte behandelt werden)

Wir betrachten hier nur die wichtigsten Typen von Objekten: Skalare,
Vektoren und Dataframes. Diese werden in R in der Regel durch Variablen
kodiert. Ein Skalar ist nur *ein einziger* Wert. Es kann sich um eine
Zahl handeln, als *integer* also Ganzzahl oder *numeric* als Kommazahl.
Ein Skalar kann aber auch eine Abfolge von Buchstaben sein, *character*
genannt, also ein Wort oder ein Kürzel.

Vektoren sind eine Reihe von Skalaren gleichen Typs. Also eine Reihe von
*integer* oder mehrere *character*-Einträge hintereinander. Wenn aber in
einem Vektor sowohl Zahlen als auch Texteintragungen auftauchen, werden
auch die Zahlen als Text gespeichert und man kann nicht mehr mit ihnen
rechnen. Einen Vektor kann man sich auch als Spalte einer Tabelle
vorstellen, wobei die Spalteneinträge immer die gleiche Datentypen
beinhalten müssen.

Mehrere Vektoren können zu einem *Dataframe* zusammengefasst werden. Ein
Dataframe ist wie eine Tabelle: Die unterschiedlichen Spalten können
unterschiedliche Datentypen beinhalten und besitzen Spaltennamen. Die
Zeilen werden als “row.names” entweder gezählt oder tatsächlich benannt.

Beispiele kommen gleich!

Noch eine Kleinigkeit vorneweg:

R ist case-sensitive! Groß- und Kleinschreibung sind also stets zu
beachten. Für Objektnamen (zum Beispiel von Funktionen und Variablen)
sind neben den alphanumerischen Zeichen auch der Punkt und der
Unterstrich erlaubt. Objektnamen mit Unterstrich sind allerdings eher
selten anzutreffen, häufiger wird der Punkt benutzt, um Objektbezeichner
zu strukturieren. Leerzeichen sind nie eine gute Idee!

# R basics

Hier geht es um ganz grundlegende Dinge zu R und Rstudio.

Zerst zu den zwei wichtigsten Bestandteilen:

Ein *Skript* ist eine Text-Datei, in der Code steht. Eine neue
Skript-Datei legt man mit dem kleinen Symbol links oben an, auf dem ein
weißes Blatt und ein grünes Plus zu sehen ist. Den in einem Skript
geschriebenen Code kann man ausführen, wann immer man möchte, in dem man
den Code markiert und Strg+Enter drückt. Oder man kopiert in die Konsole
und drückt Enter. Oder man klickt oben rechts auf das Dropdown-Menü
neben “Run” und wählt aus, was man auführen möchte, aber das dauert
alles länger als der Shortcut mit Strg+Enter. Man kann auch ganze
Skripte auf einmal ausführen lassen. Innerhalb eins Skripts geht R Zeile
für Zeile von oben nach unten und führt die Befehle (den Code) aus. R
geht davon aus, dass alles was in dem Skript steht, Code ist, es sei
denn es wird *auskommentiert*. Indem ich vor eine Zeile Text im Skript
das Symbol \# (den Hashtag) setze, geb ich dem Programm zu verstehen:
“In dieser Zeile steht kein Code. Ignorier es einfach”. Rstudio färbt
diese Zeile dann ein (meist grün), während der restliche Code schwarz
bleibt.

Die *Konsole* ist das Panel unten und ist der Link zum “eigentlichen R”.
Code wird hier neben dem “\>” hin kopiert (zB durch das markieren und
Strg+Enter oder “per Hand”) oder eingetippt und mit Enter abgeschickt.
“Antworten” von R erscheinen ebenfalls in der Konsole, neben einer
kleinen Zahl in eckigen Klammern ( \[1\] ), die die Zeile der Antwort
angibt.

Achtung! R ist die Sprache eines dummen Computers, der nicht damit
klarkommen, wenn wir etwas “falsch” sagen. Das kann bedeuten, dass ein
Komma oder ein Klammer fehlt und R es nicht mehr versteht. Deshalb
achtet darauf, alles genau so abzutippen.

### Taschenrechner

Man kann R wie einen Taschenrechner benutzen, die einfachen
Rechenoperationen stehen zur Verfügung.

Versucht einmal die folgenden Rechnungen in die Konsole einzutippen und
mit Enter abzuschicken:

``` r
3 + 2
```

``` r
5 - 7
```

``` r
5 * 2
```

``` r
100 / 10
```

Oder auch:

``` r
3*4+2
```

bzw:

``` r
3*(4+2)
```

Was merkt ihr an den Ergebnissen?

### Zuweisungen

Rechenergebnisse, wie z.B. das Ergebnis von 3\*(4+2) können in Variablen
gespeichert werden. Die Zuweisung des Ergebnisses zu einer Variablen
geschieht mit dem Zuweisungsoperator “\<-“ und sieht im allgemeinen
folgenderweise aus:

Variablenname \<- Befehl / Berechnung / Zahl

Wird nacheinander mehrmals der gleichen Variable verschiedene Dinge
zugewiesen, enthält die Variable das Ergebnis der letzten Zuweisung. Um
nachzusehen, was eine Variable enthält, kann man den Variablennamen in
die Konsole eingeben und mit Enter abschicken oder oben rechts unter
Environment nachsehen. R merkt sich NICHTS, es sei denn, ich weise es
einer Variablen zu. Das heißt auch, wenn ich einen Befehl / eine
Funktion / eine Formel auf einen Datensatz anwende, bleibt das nur
langfristig bestehen, wenn ich mit dem Befehl gleichzeitig entweder
meinen alten Datensatz überschreibe ODER einen neuen entstehen lasse.

Probieren wir es aus:

``` r
x <- 3*(4+2) 
```

Oben rechts ist jetzt unter dem Reiter *Environment* der Wert “x”
erschienen. Wir können dort immer ablesen, welche Variablen wir zur Zeit
definiert haben.

Mit x kann ich jetzt weiterrechnen:

``` r
y <- x+2
```

## Daten einladen

Je nachdem, wie die eigenen Daten gespeichert sind, benötigt man
unterschiedliche Funktionen in R. Was base-r am einfachsten kann, ist
eine csv-Datei einladen. Der Befehl dafür heißt “read.csv2” (eine
Weiterentwicklung von read.csv). Mit diesem Befehl können wir auch
spezifizieren, mit welchem Zeichen die Spalten voneinander getrennt
wurden. Im Beispiel gebe ich an, dass eine Semikolon-getrennte Tabelle
ist (mit `sep = ";"`. Außerdem ist es ein deutscher Datensatz und der
Dezimaltrenner ist das Komma (`dec= ","`). Das ist wichtig, sonst denkt
R, das wären keine Zahlen sondern Text:

``` r
mydata <- read.csv2("Pfad/zur/Datei/meineDatei.csv", sep = ";", dec = ",")
```

Für Excel-Daten muss man ein eigenes Paket installieren. Ich empfehle
“openxlsx”. Hier kann ich z. B. spezifizieren, welches sheet in der
Excel-Arbeitsmappe als Tabelle eingelesen werden soll:

``` r
install.packages("openxlsx") # 

library(openxlsx)

mydata <- read.xlsx("Pfad/zur/Datei/meineDatei.xlsx", sheet = 1)
```

## Speichern von Daten

Daten, die man modifiziert hat, möchte man manchmal einfach speichern,
damit man den Code, den man dafür geschrieben hat, nicht jedes mal
wieder laufen lassen muss. Außerdem kollaboriert man ja manchmal mit
Menschen, die kein R haben.

Für ersteres gibt es wie beim Einladen, so auch beim Schreiben von Daten
zwei Wege.

Um einen Datensatz namens `Datensatz` als Semikolon-separierte
csv-Tabelle zu schreiben, inder Kommas als Dezimaltrenner benutzt
werden, geht folgendermaßen:

``` r
write.table(Datensatz, 
           "Pfad/zum/Ordner/name_des_datensatzes.csv", 
           row.names = FALSE, 
           sep = ";",
           dec = ",",
           fileEncoding = "UTF-8")

write.csv2(Datensatz, "Pfad/zum/Ordner/name_des_datensatzes.csv", row.names = FALSE, sep = ",")
```

`row.names = FALSE` spezifiziert, dass man keine Zeilennamen haben
möchte, die R normalerweise automatisch erstellt. Manchmal möchte man
sie aber abspeichern, dann sollte man das auf `TRUE` setzen.

`fileEncoding = "UTF-8` ist immer eine gute Idee. So wird
sichergestellt, dass “ä”, “ö”, “ü” etc richtig gespeichert werden. Wenn
ich weiß, dass Daten in UTF-8 abgespeichert sind, kann ich das Argument
`encoding = "UTF-8"` beim Einladen der Tabelle in R nutzen, um
sicherzustellen, dass das alles klappt.

Um eine Excel-Tabelle zu schreiben, nehmt ihr wieder das Paket
`openxlsx`

``` r
write.xlsx(Datensatz, "Pfad/zum/Ordner/name_des_datensatzes.xlsx")
```

## Beispieldatensatz

Als Beispieldaten habe ich euch einen von mir abgewandelten Datensatz
des Pakets `archdata` per Email geschickt, es ist eine Tabelle über
Bronzezeitliche italienische Tassen. Ich hoffe, ihr habt ihn
heruntergeladen und gespeichert

Ladet den Datensatz ein.

``` r
#CSV-Datei
BACups <- read.csv2(".../BACups_tempered.csv", 
                     sep = ";", # Separator zwischen den Spalten ist Semikolon
                     dec = ",") # Dezimaltrenner Komma

# Excel-Datei:
library(openxlsx)
BACups <- read.xlsx(".../BACups_tempered.xlsx", sheet = 1)
```

Schaut euch den Datensatz an (In der Konsole`head(BACups)` oder in der
Environment drauf klicken).

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
      

Es gibt noch viele weitere Anpassungsmöglichkeiten. Einige werden wir
hier kennen lernen. Man kann mit `scales` die aesthetics bearbeiten, zum
Beispiel Abstände auf der x-Achse anpassen oder die Beschriftungen der
Achsen. Mit `theme` kann man dann jedes optische Element des Plots
manuell anpassen, z.B. die Position der Legende, Farbe der Beschriftung…

Das Lehrbuch <https://r-intro.tadaa-data.de/book/visualisierung.html>
gibt eine Menge guter Tips und eignet sich zum Nacharbeiten

Auf zu den Diagrammtypen jetzt:

Jetzt aber zu den Diagrammen. Es geht im Folgenden um

-   Säulendiagramme

-   Streudiagramm

-   Facettierungen

-   ggplot-Hilfen

## ein Säulendiagramm

Ein Säulendiagramm eignet sich zur Darstellung von Häufigkeiten
nominaler und ordinaler Variablen. Eine ganz typische Frage ist ja: Wie
häufig gibt es einen Typ x in der Phase y.

Dafür nehmen wir als erstes den Datensatz BACups. Den haben wir schon
oben eingeladen.

``` r
library(ggplot2) # 1. "Laden" des Pakets, einmal pro Sitzung!

ggplot(data = BACups)+ #data = bezieht sich auf den Datensatz mit dem ich arbeite, meist ein dataframe
  geom_bar(aes(x = Phase)) #geom_bar bedeutet, ich hätte gern ein Balkendiagramm, aesthetic: ich will, dass auf der X-Achse die Phasen abgetragen werden
```

Jetzt kann man viele Dinge verschönern

1.  B. Den Achsen eine andere Beschriftung geben:

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase))+
  labs(y = "Häufigkeit", #der y-Achse einen neuen Namen geben
       title = "Vorkommen der zwei Phasen") # dem ganzen Plot eine Überschrift geben
```

Oder einen anderen Look wählen (ein anderes Thema):

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase))+ 
  labs(y = "Häufigkeit",
       title = "Vorkommen der zwei Phasen")+
  theme_bw() #andere Möglichkeiten theme_classic, theme_grey, theme_minimal
```

Oder die Säulen bunt einfärben:

``` r
ggplot(data = BACups)+ 
  geom_bar(aes(x = Phase, fill = Temper))+ # fill gibt den Balken unterschiedliche Farben, je nach den Angaben in der Spalte Temper
  labs(y = "Häufigkeit",
       title = "Vorkommen der zwei Phasen")+
  theme_bw() 
```

## Streudiagramme

Bei Streudiagrammen kann ich zwei Variablen einer Einheit gegeneinander
plotten.

Wir tragen auf der X- und auf der Y-Achse metrische Daten ab. Das gehört
zu den aesthetics-Elementen, deshalb tun wir die Info in die Klammern
hinter aes():

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, y = ND))
```

Jetzt können wir damit wieder die Dinge tun, die wir mit dem
Balkendiagramm gemacht hatten, also die Achsen beschriften, einen Titel
vergeben und den Style ändern:

``` r
ggplot(data = BACups)+
  geom_point(aes(x = RD, y = ND)) + 
  labs(x =" Randdurchmesser",
       y ="Nackendurchmesser",
       title = "Rand- und Nackendurchmesserim Verhältnis zueinander")+
  theme_bw()
```

Was kann man noch tolles machen? Die Form der Punkte von einer Variablen
bestimmen lassen! Und die Farbe!

Welches Merkmal, das ich in der Tabelle als Spalte aufgenommen habe die
Form der Punkte bestimmt lege ich mit “shape” fest, die Farbe mit
“color”.

``` r
ggplot(data = BACups)+
  geom_point(aes(x = H, y = SD, shape = Temper, color = TempCoarse)) + 
  labs(x =" Höhe des Gefäßes",
       y ="Schulterdurchmesser",
       title = "Höhe des Gefäßes im Verhältnis zum Schulterdurchmesser")+
  theme_bw()
```

## Facettierung!

Jetzt wird es nochmal richtig cool. Das Streudiagramm eben, den nochmal
nach unterschiedlichen Phasen anzulegen, das wär gut oder?

``` r
  ggplot(data = BACups)+
  geom_point(aes(x = H, y = SD, shape = Temper, color = TempCoarse)) + 
  facet_grid(.~Phase)+
  theme_bw()
```

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