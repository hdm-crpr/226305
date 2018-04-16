# lädt das Paket "igraph"
library(igraph)

# liest die Daten aus dem Github-Verzeichnis ein
help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students_ss18/el_help.csv", header=T, as.is=T, sep = ",")
work <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students_ss18/el_work.csv", header=T, as.is=T, sep = ",")

# lädt die Nodelist
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students_ss18/nodes_all.csv", header=T, as.is=T, sep = ",")

# überprüfen von Edge- und Nodelist in R
head(help)
head(work)
head(nodes)

# Umwandlung der Edgelist in eine Matrix
hties <-as.matrix(help)
wties <-as.matrix(work)

# Kombination der Edge- und Nodelist in ein igraph-Objekt
help <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
work <- graph_from_data_frame(d=wties, vertices=nodes, directed=T)

#ruft das neu-erstellte igraph-Objekt auf
help
work

## ERSTER MEILENSTEIN ##
# igraph-Objekt unserer Netzwerke erstellt!

edge_attr(work)
# zeigt die Verteilung des Attributs "weight" an.

vertex_attr(work)
# zeigt die Verteilung der Vertex-Attribute an.

