sw_nachgruppe <- function(df, gruppe, variable){

  # 2. die verschiedenen Werte des gruppiernden Merkmals abgreifen

  level <- levels(as.factor(df[[gruppe]])) # levels zeigt, welche Werte in einem Faktor-Vektor vorkommen (mit as.factor sicherstellen, dass es nicht aus Versehen ein Character-Vektor ist)

  # (5.) Vorbereiten der Tabelle muss vor der Schleife passieren
  df_p <- data.frame(gruppe = character(length(level)),
                     pWert = double(length(level)))
  # erstelle die Spalte gruppe als character-Spalte mit so vielen Zeilen, wie der Vektor "level" Einträge hat (length)

  # Vobrereiten eines "Zählers" für 5.
  z <- 0

  # Schleife für Gruppenbildung und Berechnung:
  for (i in level) { # für jeden der Werte in level

    #3. Gruppenbildung
    s <- subset(df, df[[gruppe]] == i) # filtere den Datensatz
    w <- s[[variable]] # weise die relevante Wertereihe einem Vektor zu

    #4. Berechnung
    y <- shapiro.test(w) # berechne den Shapiro-Test auf die Variable

    #5. + 6. Teststatistik auslesen und in Tabelle ablegen
    z <- z+1 # "hochzählen", um die richtigen Zeilen des Ausgabe-Datensatzes anzuwählen

    df_p$gruppe[z] <- i
    df_p$pWert[z] <- y$p.value
  }
  # Schleife zuende

  #7. Gesamtdatensatz ausgeben
  print(df_p)
}
# Funktion zuende
