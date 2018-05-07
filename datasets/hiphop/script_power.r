# 226305 Test Dateset
# sandhu@hdm-stuttgart.de, 2018-05-7
# Test HipHop-Power
# https://github.com/hdm-crpr/226305/tree/master/datasets/hiphop

library(igraph)
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/hiphop/edges.csv", header=T, as.is=T, sep = ",", stringsAsFactors = FALSE)
head(el)

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/hiphop/nodes_power.csv", header=T, as.is=T, sep = ";", stringsAsFactors = FALSE)

head(nodes)
elties <- as.matrix(el)
elties

# ipgraph-Objekt erstellt
power <- graph_from_data_frame(d=elties, vertices=nodes, directed=FALSE)
power
class(power)

plot(power, vertex.label=NA)

# Vertex-Attribute anzeigen
vertex_attr(power)

# Edge-Attribute
E(power)$arrow.size = .5
E(power)$color="black"
E(power)$curved=.1

# Vertex-Attribute

V(power)$label.dist=2
V(power)$label.degree=0
V(power)$label.cex=.5
V(power)$label.family="Helvetica"
V(power)$label.font=2
V(power)$label.color="black"
V(power)$frame.color="white"

plot(power)

# Vertex-Attribut size als power definieren
plot(power, layout = layout_nicely, vertex.size=V(power)$power/40, main="HipHop nach Power")

# Sie müssten hier noch etwas mit dem Divisor von Power spielen, da die Werte von 2 bis 2000 reichen. Wenn Sie hier eine bessere Aussage treffen wollen, empfehle ich eine Indizierung der Werte, d.h. sie legen eine Range an, in der Sie die Werte zuordnen, also z.B. 1 = unter 50, 2 = unter 100, 3 = unter 250, 4 = unter 500, 6 = unter 1.000 etc. dann werden so starke Ausreisser vermieden.




