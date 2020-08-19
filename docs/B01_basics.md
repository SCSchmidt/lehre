R basics
========

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

Mit dem Befehl *class* kann ich testen, welcher Datentyp eine Variable
hat (also z. B. ob es eine Zahl oder ein Buchstabe ist):

``` r
class(x)
class(y)
```

Da x und y den gleichen Typ haben (*numeric*), kann ich sie in einem
Vektor zusammenfassen:

``` r
z <- c(x, y)
```

Was ist passiert?

Das c() markiert, dass ich mehrere Werte in einer Reihe eingebe, die
zusammengehören sollen (das ist dann ein Vektor). Mit \<- habe ich diese
Reihe der Variablen z zugeordnet.

Wenn ich das alles noch einmal mit anderen Werten mache, kann ich aus
den zwei Vektoren einen Dataframe erstellen. Ein Dataframe wird relativ
häufig benutzt, weil er eine “gute alte rechteckige Tabelle” abbildet,
mit Spalten und Zeilen, wobei in den Spalten unterschiedliche Arten von
Daten aufgenommen werden können.

Weiter zum Beispiel, erstellen wir uns einen zweiten Vektor und “kürzen
ab”, d.h. weisen die Werte gleich dem Vektor zu, nicht erst eigenen
Variablen:

``` r
ab <- c("Hund", "Katze")
```

Die Hochkommas erklären R, dass es sich um Text handelt und nicht um
Objekte (also andere Variablen). Vergisst man sie, kommt die
Fehlermeldung “object ‘Hund’ not found”, weil R nach etwas, das ‘Hund’
heißt, sucht und nicht findet.

Unter “Environment” oben rechts in Rstudio befinden sich jetzt alle
neuen Variablen, die wir definiert haben. Wir können auch sehen, dass
“ab” “chr” – also ein “character”-Vektor – ist, während “z” als “num” –
numerical – markiert wird.

Jetzt bauen wir aus diesen beiden Vektoren einen Dataframe, also eine
Tabelle:

``` r
df <- data.frame(z, ab)
```

Unter Environment erscheint unter der Überschrift “Data” jetzt “df”. Auf
den blauen Pfeil kann man klicken und sich anschauen, woraus der
Dataframe zusammengesetzt ist. Wir können ihn uns auch anschauen,
entweder durch “draufklicken” oder per Code:

``` r
View(df) # Achtung! View() wird groß geschrieben im Gegensatz zu den meisten anderen Funktionen.
```

Was den Daten noch fehlt, ist eine sinnvolle Bezeichnung der Spalten,
“z” und “ab” sagen mir nichts. Geben wir den Spalten also neue Namen:

``` r
colnames(df) <- c("Gewicht", "Tier") 
```

Colnames bezeichnet “column names”. Wir sagen R also, die Spaltennamen
von dem Datensatz `df` sollen jetzt “Gewicht” und “Tier” heißen. Die
Reihenfolge ist hier wichtig! Ich muss wissen, wie meine Spalten
aneinander gereiht sind, damit dann am Ende auch die Spalten richtig
heißen. Schaut ihn euch noch einmal an.

Cool! Wir haben jetzt schöne tabellarische Daten!

Wir können jetzt mit unseren Daten viele tolle Sachen machen, aber erst
einmal müssen wir lernen, wie wir mit ihnen umgehe.

### Auswählen von Daten

Also wählen wir doch einmal in dem Datensatz ganz bestimmte Werte aus.
Zum Beispiel würde ich gern nur die erste Zeile sehen:

``` r
df[1,]
```

Mit ECKIGEN KLAMMERN kann ich angeben, welche Zeilen und Spalten ich aus
dem Datensatz sehen möchte. Das Prinzip ist immer
`Daten[Zeile, Spalte]`. Dadurch, dass hier die “Spalten”-Information
gefehlt hat, wurde einfach die gesamte Zeile ausgegeben. Will ich aber
nur die Information aus dem Feld der 1. Zeile und 2. Spalte, sieht das
so aus:

``` r
df[1,2]
```

Ok? Welche Information erwartet ihr, wenn ihr `df[2,2]` angebt? Testet
das!

Die Spaltennamen sind auch sehr praktisch, weil ich diese auch zur
Auswahl nutzen kann. Ich kann den Vektor der Tiere, den ich in meinen
Dataframe eingebaut habe, auch wieder ganz einfach auslesen:

``` r
df$Tier
```

Das Dollarzeichen ($) sagt “in dem Dataframe df die Spalte Tier”. Und
ausgegeben werden die “Hund” und “Katze”, die in diesem Vektor (die
Spalte ist ein Vektor) liegen. Das gleiche kann ich auch mit dem Gewicht
machen:

``` r
df$Gewicht
```

### Erste Funktion

Und jetzt wäre es doch spannend, das durchschnittliche Gewicht meiner
beiden Tiere herauszufinden. Dafür benutze ich die Funktion `mean`.
Einer Funktion wird ein ein Objekt “gegeben”, und mit diesem Objekt
(hier: die Zahlen in der Spalte Gewicht) macht sie dann etwas. Es heißt,
“in R ist alles entweder ein Objekt oder eine Funktion”, insofern ist
das das, was wir eigentlich die ganze Zeit machen. Wir definieren
Objekte (weisen Variablen Werte zu) und füttern sie einer Funktion, die
dann etwas damit macht, das weisen wir wieder einer Variablen zu…

So berechnen wir den Mittelwert:

``` r
mean(df$Gewicht)
```

Auf diese Art und Weise, wird mir das Ergebnis nur angezeigt. Ich kann
es jedoch auch wieder speichern (einer Variablen zuweisen):

``` r
mean_gewicht <- mean(df$Gewicht)
```

Wie oben wird durch die Zuweisung der Variablen “mean\_gewicht” jetzt
das Ergebnis der Berechnung “Mittelwert von der Reihe Zahlen, die in der
Spalte”Gewicht" des Dataframes “df” stehen, gespeichert. Damit ließe
sich wieder weiterrechnen.

### Pakete

Aber eigentlich wollen wir echte biologische Daten für den Workshop
benutzen. Wir nehmen dafür einen Datensatz über Pinguine. Diesen müssen
wir uns aber erst herunterladen und installieren. Er liegt in einem
Paket namens “palmerpenguins” auf dem Github von Allison Horst
(<a href="https://github.com/allisonhorst/palmerpenguins" class="uri">https://github.com/allisonhorst/palmerpenguins</a>),
die Daten wurden von Dr. Kristen Gorman und der Palmer Station,
Antarctica LTER zur Verfügung gestellt.

Pakete sind “Erweiterungen” für `base R`. `base R` ist das zugrunde
liegende “einfache” R, das mit der Standardinstallation geladen wird. Es
kann schon sehr sehr viel. Die vielfältige Community um R herum und auch
einige professionelle Entwickler denken sich aber ständig neue
Funktionalitäten (Funktionen, Möglichkeiten) aus und implementieren sie
in Paketen (*packages*). Wenn ich also eine bestimmte Funktion nutzen
möchte, muss ich das Paket installieren, in dem sie eingebaut wurde und
in meine R-session laden. Pakete liegen meistens auf dem “Comprehensive
R Archive Network” (*CRAN*), können aber auch woanders zur Verfügung
gestellt werden. So ist es mit dem Daten-Paket, was wir brauchen, es
liegt auf github.com, einem unter Software-Entwicklern beliebten
versionskontrollierten Repositorium für Code.

In Rstudio Cloud habe ich alle Pakete vorinstalliert, die in diesem Kurs
von Bedeutung sind. Deswegen gilt der folgende Teil der Anleitung nur
für diejenigen, die nicht in Rstudio Cloud, sondern mit der Installation
von Rstudio auf ihren Heimrechnern arbeiten!

#### nur für Rstudio NICHT in der Cloud relevant!

Allerdings: Um Pakete von github herunterladen zu können, brauche ich
eine weitere bestimmte Funktion. Sie liegt in dem Paket `devtools`, kurz
für “developer tools” und dieses Paket liegt auf CRAN. Um Pakete von
CRAN zu installieren, nutzt man `install.packages("Paketname")`.

Folglich machen wir erst einmal das:

``` r
install.packages("devtools")
```

Mit dem folgenden Code kann man jetzt etwas von Github herunterladen und
installieren: `devtools::install_github("NameDesAutors/NamedesPakets")`.
Den Code kann man wie folgt lesen:

`devtools::` = damit sage ich, dass ich aus dem Paket `devtools` eine
bestimmte Funktion benutzen möchte. Ich muss hierfür nicht das ganze
Paket ein-laden, sondern greife sozusagen nur einmal in das Paket
hinein.

`install_github` = Diese Funktion weiß, dass das was folgt, auf ein
Repositorium auf github verweist. Deshalb stellt es automatisch ein
“<a href="https://github.com" class="uri">https://github.com</a>” dem
voran, was ich jetzt eingebe. Dadurch muss ich weniger tippen. Die
Funktion lädt dann das Paket herunter und installiert es.

``` r
# herunterladen des Datensatzes Palmer Penguins
devtools::install_github("allisonhorst/palmerpenguins")
```

Achtung! “allisonhorst/palmerpenguins” muss in Hochkommas, damit R nicht
denkt, dass es ein Objekt ist, dass es in der Environment finden muss.

#### hier weiter für alle

Nach erfolgreicher Installation (roter Text heißt in R nicht, dass
Fehler passiert sind!), müssen wir das Paket noch in unsere Sitzung
(“R-session”) laden, damit wir damit umgehen können:

``` r
library(palmerpenguins)
# Paketen einladen
```

Pakete müssen nur EINMAL installiert, aber in jeder Sitzung / nach jedem
Neustart des Programms neu “geladen” werden. Die Befehle fürs Laden
heißen entweder “library” oder “require”, beides funktioniert gleich
gut. In der Regel schreibt man die Ladebefehle für die Pakete, die man
in einem Skript braucht, ganz nach oben, damit andere gleich am Anfang
sehen, was sie vielleicht nach-installieren müssen. Wenn ich ein Skript
nur für mich schreibe, setze ich es gern direkt vor die Funktion, für
die ich das Paket brauche, damit ich weiß, aus welchem Paket die
Funktion stammte. Meist erläutere ich das auch mit einem Kommentar.

In dem Paket Palmerpenguins gibt es zwei Datensätze. Die rufen wir jetzt
mit dem Befehl “data” auf und schauen uns den an.

``` r
data(penguins)
# Daten laden
```

Jetzt solltet ihr unter Environment zwei neue Einträge sehen: “penguins”
und “penguins\_raw”. Dahinter steht “Promise”, was bedeutet, sie sind
vorgeladen, aber noch nicht komplett da. Das spart Ressourcen. Wenn wir
uns den ersten Datensatz jetzt anschauen, werden sie vollends
eingeladen.

Tun wir das:

``` r
View(penguins)
```

Jetzt ist penguins in unserer Environment, also als Datensatz mit einer
bestimmten Variable eingeladen.

Wir sehen jetzt folgende Spalten: `colnames(penguins)`. In einigen
dieser Spalten steht manchmal ein schräggedrucktes *NA*. Diese Felder
sind leer, die Information FEHLT. R kann gut mit leeren Feldern umgehen,
gibt ihnen aber diese interne Bezeichnung.

Wiederholen wir das von eben noch einmal. Welches Feld wird durch diesen
Code angesprochen?:

``` r
penguins_2_5 <- penguins[2,5]
```

Schau nach, ob es stimmt!

Noch ein paar weitere Hinweise zur Auswahl von Daten.

Negativauswahl gibt es natürlich auch. Also: Gib mir alles außer diese
Spalte:

``` r
penguins_alles_ausser_2 <- penguins[, -2]
```

Alles außer Spalte 2 ist jetzt dem neuen Datensatz
penguins\_alles\_ausser\_2 zugewiesen worden. Hinweis: Die Nutzung von
Umlauten und ß geht zwar in R, ist aber manchmal etwas “buggy”. Es führt
zu Problemen. Deshalb ist davon in Spalten- und Variablennamen
abzuraten. In Textfeldern ist es weniger problematisch. Variablen dürfen
auch nicht mit Zahlen beginnen.

Ganz toll ist auch die Auswahlmöglichkeit “von a bis x”. Das geht mit
Doppelpunkt:

``` r
penguins_x <- penguins[c(1:10),]
```

Versteht ihr, was ausgewählt wurde?

Nutzen wir das doch einmal sinnvoll und berechnen den Mittelwert des
Gewichts der Pinguine! D. h. Wir wählen die Spalte “body\_mass\_g” in
dem Datensatz “penguins” und wenden die Funktion `mean` darauf an:

``` r
mean(penguins$body_mass_g)
```

Was was was, was ist da passiert? Warum gibt er ein NA aus?

`NA` steht in R für “not available”. Warum sollte das Ergebnis einer so
einfachen Berechnung nicht verfügbar sein?

Schauen wir uns den Vektor “penguins$body\_mass\_g” noch einmal genauer
an. In dem wir ihn einfach in die Konsole tippen und mit Enter
abschicken, listet uns R alle Werte in diesem Vektor auf.

``` r
penguins$body_mass_g
```

Fällt euch etwas auf?

Nicht alles sind Zahlen. Wie oben schon gesagt, manchmal steht statt
einer Zahl ein `NA` im Feld. Mit `NA` markiert sich R leere Felder. Und
jetzt hat R ein Problem: Wie soll es damit umgehen? Das weiß es nicht
von allein. Deshalb helfen wir ihm und sagen, es soll die Felder, wo ein
Wert fehlt, einfach ganz aus der Berechnung weglassen. In manchen
Funktionen ist das von alleine implementiert, in `mean` offensichtlich
nicht. Wir fügen der Funktion `mean` jetzt den “Flag” (deutsch:
Aufrufparamter) `na.rm` hinzu und spezifizieren `na.rm = TRUE`. Das
heißt auf un-abgekürzt: “Shall I remove all NA? - YES”. Der Parameter
wird mit Komma hinter das Objekt geschrieben, auf das die Funktion
angewandt wird, bleibt aber in den Klammern!

``` r
mean(penguins$body_mass_g, na.rm = TRUE)
```

So, jetzt sollten wir wissen, wie schwer der durschschnittliche Pinguin
in unserem Datensatz ist.

Daten nach Kriterien auswählen
------------------------------

Häufig möchte man jedoch z.B. nur den Mittelwert der Pinguine einer
bestimmten Art, wir müssen unseren Datensatz also nach einem Kriterium
filtern.

Dafür (wie so für so vieles) gibt es unterschiedliche Wege in R. Schauen
wir uns zwei kurz an:

1.  *subset*:

Diese Funktion gehört zu base R. Ich erstelle einen neuen Datensatz, der
besteht aus dem alten Datensatz, da wo in der Spalte species genau
(Operator “==”) “Chinstrap” steht. Ich hab den Code mal kommentiert:

``` r
# erstellen eines neuen Datensatzes nur der Penguinspezies Chinstrap
chinstraps <- subset(penguins, penguins$species == "Chinstrap")

# Mittelwert berechnen:
mean(chinstraps$body_mass_g)
```

1.  *filter*

Die Filter-Funktion gehört zum sogenannten “tidyverse”. Das Tidyverse
ist wie ein bestimmter Dialekt von R. Eine Reihe von Paketen folgt
diesem Dialekt und diese Pakete arbeiten besonders gut miteinander. Da
diese neuen Pakete auch einiges vereinfachen, erfreuen sie sich
zunehmender Beliebtheit und wenn man nach Lösungen googelt, findet man
Anleitungen, die “tidy” Lösungen erklären. Im Tidyverse gibt es eine
Besonderheit, die man kennen sollte: Die sogenannte “*pipe*”. Mit dem
Befehl `%>%` wird das Ergebnis einer Zeile in die nächste überführt. Wir
benötigen zwei Pakete als nächstes: “dplyr” und “magrittr”, die mit
*install.packages* installiert werden müssen.

#### nur für nicht-Cloud-user!

``` r
install.packages("dplyr")
install.packages("magrittr")
```

(Das kann etwas dauern, die Pakete sind etwas größer.)

#### weiter für alle

Im Beispiel schicke ich damit den gesamten Datensatz penguins in den
Filter, der in der nächsten Zeile beschrieben wird, “filtere” ihn und
schick ihn gefiltert weiter in die nächste Zeile, in der ich die Spalte
definiere und in die letzte, wo es dann um die Berechnung des
Mittelwertes geht:

``` r
# filter funktion
library(dplyr)
# zur Vereinfachung der Pipe gibt es 
library(magrittr)

penguins %>%
  filter(species == "Chinstrap") %>% # filter aus dem Datensatz nur die raus, wo in der Spalte species "Chinstrap" steht
  use_series(body_mass_g) %>%    #  nimm die Spalte body_mass_g, braucht Paket magrittr
  mean() # und berechne daraus den Mittelwert
```

Wie man sieht, ist der “Kernbefehl” (" species == “Chinstrap” ") fast
genau gleich wie bei der subset-Funktion. Es sind auch nicht weniger
Zeilen Code. Es ist aber eventuell lesbarer. Und wenn ich mir vorstelle,
dass ich meine Daten vllt noch nach 20 anderen Variablen filtern möchte,
will ich nicht jedesmal einen extra Datensatz erstellen müssen. Manchmal
wird es dann schwierig, sich sinnvolle Namen für die Datensätze
auszudenken. So sehe ich immer, welche Filter ich genau angewandt habe.
Allerdings: Brauche ich diese Datensätze noch für andere Berechnungen,
ist subset die bessere Lösung. Oder ich weise das Gefilterte einer
Variablen zu, das geht auch mit der filter-Version:

``` r
chinstraps <- penguins %>%
  filter(species == "Chinstrap")
```

### Zusammenfassend grundlegende Konzepte:

-   Es gibt Funktionen und Objekte. Eine Funktion “macht etwas” mit
    einem Objekt, berechnet zB den Mittelwert einer Zahlenreihe
    (Zahlenreihe = Vektor = Objekt).

-   mithilfe von Zuweisungen werden Variablen definiert, mit denen
    weiter gearbeitet werden kann.

-   Die Installation von Paketen erweitert die Funktionalitäten in R.
    CRAN-Pakete werden mit “install.packages(”Paketname“)” installiert.

-   Ein Paket muss jede Sitzung neu geladen werden (einfach im Skript
    den library-Befehl reinschreiben)

### Zusammenfassend noch einmal grundlegende Zeichen:

-   \<- mit einem kleinen Pfeil weisen wir einen Wert / eine Berechnunge
    / einen Vektor oder sogar einen Dataframe einer Variablen zu. Wie im
    Mathe-Unterricht, wo Formeln mit f(x) und y = a\*x + b beschrieben
    wurden. R merkt sich NICHTS, es sei denn, ich weise es einer
    Variablen zu. Das heißt auch, wenn ich einen Befehl / eine Formel
    auf einen Datensatz anwende, bleibt das nur langfristig bestehen,
    wenn ich mit dem Befehl gleichzeitig entweder meinen alten Datensatz
    überschreibe ODER einen neuen entstehen lasse.

-   $ das Dollarzeichen steht zwischen Dataframe (Tabelle) und dem
    Vector (Spalte) im Dataframe: df$vector, damit wählen wir also den
    Vector an.

-   Klammern ( ) sind grundlegend, weil ich bei jeder Funktion, die ich
    aufrufe erst den Funktionsnamen / den Befehl schreibe und dahinter
    in Klammern, worauf er sich bezieht, also auf welche Daten der
    Befehl angewandt werden soll.

-   in anderen Kontexten umgeben Klammern ( ) immer eine Sinneinheit,
    zB, wenn ich mehrere Werte zusammenfassen will, nutze ich c()

-   Eckige Klammern \[\]: Mit ihnen kann man Zeilen, Spalten und Felder
    eines Datensatzes anwählen.

-   die Pipe %\>%: Ist ein besonderes Zeichen im R-Dialekt “tidyverse”
    und gibt den Inhalt davor an die nächste Zeile weiter.

### trouble shoot Tips

1.  Tippfehler. Meistens klappt etwas nicht, weil man sich vertippt hat.
    Ein Komma zu wenig, eine Klammer zu viel, ein Buchstabe verdreht.
    Der Computer ist dumm und versteht nicht, was man gemeint hat.

2.  Fehlermeldung lesen! Häufig sagt R, was das Problem ist.

3.  Andere drüber lesen lassen, die dann den Tippfehler finden.

4.  Schauen, ob man nicht irgendwo die Reihenfolge verdreht hat und
    einen alten Datensatz überschrieben hat, auf den man dann zugreift.
    In der Environment schauen, ob die Variablen noch stimmen und/oder
    wenn man ein Skript komplett laufen lässt noch einmal von oben nach
    unten gehen und gucken, ob sich da ein Fehler eingeschlichen hat.

5.  Überprüfen, ob alle Pakete, die man braucht, geladen sind.

6.  Die R-Hilfe. Mit ?Befehl oder rechts unten unter dem Reiter Help
    kann man nach einzelnen Funktionen suchen und noch einmal gucken, ob
    man die Funktion richtig benutzt.

7.  Diese Tippfehler, ne… lest noch einmal gnaz gneau drüberr.

8.  Es gibt eine große Onlinecommunity zu R, man findet eigentlich zu
    jeder Frage eine Antwort. Vieles ist aber tatsächlich auf englisch,
    deswegen ist es eine gute Idee, auch mal auf englisch zu googeln.
    Beim googeln sollte man immer neben R auch den Paketnamen zu der
    eigentlichen Frage / dem Stichworten eingeben.

9.  Wenn man eine Antwort nicht versteht, nicht verwirren lassen: Häufig
    gibt es mehrere Lösungswege. Wie in einer normalen Sprache, gibt es
    auch in Programmiersprachen unterschiedliche Wege um das gleiche
    auszudrücken. Sollte immer der gleiche Lösungsweg vorgeschlagen
    werden und man versteht ihn nicht, dann versucht euch über die
    R-Hilfe die einzelnen Schritte des Lösungsweges anzuschauen. Oder
    fragt jemanden, manchmal reicht schon ein zweites Paar Augen, um ein
    Problem zu lösen.

10. Keine Panik! Mancht ’ne Pause, geht für 5min weg vom Rechner,
    manchmal braucht man nur einen frischen Blick auf das Problem, und
    dann löst man es.
