#226305 Skript 1: Einlesen eines Datensatzes
#226305 Datensatz als igraph-Objekt einlesen:
#erstellt von sandhu@hdm-stuttgart.de
#Die Erklärung des Datensatzes und der Codierung finden Sie unter https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/codierung.rmd

#liest die Dateien direkt aus dem github-Verzeichnis ein
help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")

#prüft, ob alle Variablen eingelesen wurden
head(help)
head(nodes)

#wandelt die edgelist in eine Matrix um und baut das igraph-Objekt
ties <-as.matrix(help)
h <- graph_from_data_frame(d=ties, vertices=nodes, directed=T)

#prüft, ob ein igraph-Objekt erstellt wurde
class(h)

#addiert edges auf, wenn sie auf der gleichen Beziehung sind
h <- simplify(h, edge.attr.comb = list(weight="sum"))

#ruft das finale igraph-Objekt auf.
h

###
