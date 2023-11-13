# Einlesen und erstellen eines igraph-Objekts
# Stand 2023-11-01
# Swaran Sandhu
# Springer-Datensatz als Test
# siehe: https://github.com/hdm-crpr/226305/tree/master/data/springer


library("igraph")
# Einlesen der Edgelist aus github link: beachte den Separator ","
edges <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/springer/edges.csv", header=T, as.is=T, sep = ",")

# Einlesen der Nodelist
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/springer/nodes.csv", header=T, as.is=T, sep = ",")

# Überprüfen der Daten
head(edges)
head(nodes)

# wandelt die Edgelist als Matrix um.
edgematrix <-as.matrix(edges)

# ?graph_from_data_frame (erläutert den Befehl genauer)
# erstellt ein igraph-objekt aus der Fusion von Edge- und Nodelist
springer <- graph_from_data_frame(d=edgematrix, vertices=nodes, directed=T)

# das igraph-Objekt heisst jetzt springer und ist ein gerichtetes Netzwerk.
springer

# Visualisierung

plot(springer,
     edge.arrow.size=.3,
     layout=layout_with_kk,
     main="Pretest Axel Springer Netzwerk",
     sub="Interlocking Relationships, n=2 Fälle")
