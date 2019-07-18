# Befehle 2. R-session: data
# Autor: Sophie Schmidt


# Peket installieren, das die Daten beinhaltet

install.packages("archdata")

library(archdata)

# unter -> Packages schauen, dass es da ist und der Haken sitzt

data(Acheulean)

View(Acheulean)

?Acheulean # Help

class(Acheulean)
class(Acheulean$Long) # $ = Anwahl einer Spalte
class(Acheulean$HA)

data("Bornholm")
class(Bornholm$Period)

View(Bornholm)
Bornholm$Period <- ordered(Bornholm$Period)
class(Bornholm$Period)
levels(Bornholm$Period)

# Daten einladen

data("BACups")

write.csv(BACups, file = "BAcups.csv")

read.csv2("../BACups.csv")

install.packages("xlsx")
library(xlsx)
write.xlsx(BACups, file = "BACups.xlsx",
           sheetName = "BA", append = FALSE)


library(xlsx)
mydata <- read.xlsx("c:/myexcel.xlsx", 1)

# read in the worksheet named mysheet
mydata <- read.xlsx("c:/myexcel.xlsx", sheetName = "mysheet")



## Backup, falls Zahlen nicht erkannt werden:
yyz$b <- as.numeric(as.character(yyz$b))
