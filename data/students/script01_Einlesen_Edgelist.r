#226305 Skript 1: Einlesen einer Edgelist
#erstellt von sandhu@hdm-stuttgart.de
#Die Erklärung des Datensatzes und der Codierung finden Sie unter https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd

VARIANTE 1: Einlesen aus github-Verzeichnis (komfortabel)

# lädt die igraph-Bibliothek
library("igraph")

# liest die Dateien direkt aus dem github-Verzeichnis ein
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=TRUE)

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

VARIANTE 2: Einlesen einer lokalen .csv-Datei





## Ergänzung ## 

# Für eine weitere Analyse lässt sich alternativ auch das Kantengewicht anzeigen

#addiert edges auf, wenn sie auf der gleichen Beziehung sind
g <- simplify(eli, edge.attr.comb = list(weight="sum"))

# erstellt einfachen plot mit gewichteten Kanten
E(g)$weight # zeigt den Vektor mit Kanten an
plot(g, edge.arrow.size=0.2, edge.width=E(g)$weight)
plot(g, edge.arrow.size=0.2, edge.width=E(g)$weight*1.5)


###
