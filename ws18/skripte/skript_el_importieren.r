# 226305 Einlesen eines Datensatzes am Beispiel einer Edgelist
## von sandhu@hdm-stuttgart.de
## Die Erklärung des Datensatzes und der Codierung finden Sie unter https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd

# lädt die igraph-Bibliothek
library("igraph")

# VARIANTE 1: Einlesen einer lokalen Datei in der working-directory

el <- read.csv("meine_daten.csv", header=TRUE)
# liest die Datei "meine_daten.csv" ein, die zuvor in der working directory gespeichert wurde.

# VARIANTE 2: Einlesen einer lokalen Datei via file.choose

el <- read.csv(file.choose())
# erzwingt die Auswahl eines Fensters, in dem Sie die Datei wie gewohnt auswählen. Die Datei wird dann als "el" importiert und wird normal weiter verarbeitet.

# VARIANTE 3: Einlesen einer Online-Datei auf github

el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=TRUE)
# liest die Dateien direkt aus dem github-Verzeichnis ein. Der Pfad muss natürlich angepasst werden. Darauf achten, dass immer der Pfad zum RAW Verzeichnis ausgewählt wird.

# nachfolgend FÜR ALLE 3 Varianten

# prüft, ob alle Variablen der Edgelist eingelesen wurden
head(el)

# prüft, ob das Objekt ein Dataframe ist
is.data.frame(el)

# ruft den data.frame el auf
el

# wandelt den dataframe el in das igraph-objekt eli um
eli <- graph.data.frame(el, directed = TRUE)

# ruft das igraph-Objekt eli auf
eli

# erstellt einen einfachen plot des igraph-Objekts eli
plot(eli)
plot(eli, edge.arrow.size=0.2) # reduziert die Stärke der Pfeilspitzen

## Ergänzung ##

# Für eine weitere Analyse lässt sich alternativ auch das Kantengewicht anzeigen

#addiert edges auf, wenn sie auf der gleichen Beziehung sind
g <- simplify(eli, edge.attr.comb = list(weight="sum"))

# erstellt einfachen plot mit gewichteten Kanten
E(g)$weight # zeigt den Vektor mit Kanten an

# Netzwerk mit einfacher Kantenstärke
plot(g, edge.arrow.size=0.2, edge.width=E(g)$weight, main="Netzwerk Studierende")
plot(g, edge.arrow.size=0.2, edge.width=E(g)$weight*1.5, main="Netzwerk Studierende")

###
