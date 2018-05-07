# 226305 Test Dateset
# sandhu@hdm-stuttgart.de, 2018-05-7

library(igraph)
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/test/edges.csv", header=T, as.is=T, sep = ",")
head(el)

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/test/nodes.csv", header=T, as.is=T, sep = ",")
head(nodes)
elties <- as.matrix(el)
elties

# ipgraph-Objekt erstellt
power <- graph_from_data_frame(d=elties, vertices=nodes, directed=FALSE)
power
plot(power, vertex.label=NA)

# Vertex-Attribute anzeigen
vertex_attr(power)

# Vertex-Attribut size als power definieren
plot(power, vertex.label=NA, vertex.size=V(power)$power)
