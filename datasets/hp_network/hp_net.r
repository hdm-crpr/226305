# Beispielnetzwerk Harry Potter
# Swaran Sandhu / sandhu@hdm-stuttgart.de

library(igraph)

# csv-Dateien müssen in der working directory abgelegt sein

el <- read.csv("hp_el.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("hp_nl.csv", header=T, as.is=T, sep = ",")

# alternativ können wir die Daten aus dem github-Verzeichnis verwenden. Hier müssen die Daten aber als immer aus dem reinen Dateiformat raw ausgelesen werden.


# prüft, ob alle Variablen eingelesen wurden
head(el)
head(nodes)

# wandelt die edgelist in eine Matrix um und baut das igraph-Objekt
elties <- as.matrix(el)
hp <- graph_from_data_frame(d=elties, vertices=nodes, directed=TRUE)

# ruft das finale igraph-Objekt auf.
hp

#Übersicht über die Edge- und Vertex-Attribute
summary(hp)
edge_attr(hp)
vertex_attr(hp)

# definiert einige grafische Elemente, damit wir diese nicht immer wieder eingeben müssen

E(hp)$arrow.size <- .2
E(hp)$color="darkblue"
E(hp)$width <- E(hp)$weight
E(hp)$curved=.2

V(hp)$color = "lightblue"
V(hp)$frame.color = "white"
V(hp)$label.dist = 4
V(hp)$label.degree=6
V(hp)$label.cex=.8
V(hp)$label.family="Helvetica"
V(hp)$label.font=1
V(hp)$label.color="darkblue"

# einfacher plot
plot(hp, layout = layout_with_kk)

## Netzwerkmaße

# Dichte
edge_density(hp, loops = FALSE)

# Durchmesser
diameter(hp, directed = TRUE)
get_diameter(hp)
farthest_vertices(hp)

# Pfaddistanz
distance_table(hp, directed = TRUE)
mean_distance(hp, directed = TRUE, unconnected = FALSE)

# Reziprozität
reciprocity(hp)

# Teilnetzwerke
components(hp)


## Zentralitätsmaße

# Degree-Maße
degree <- degree(hp)
degree
plot(hp, vertex.size=degree*5, main="Degree-Verteilung")

# Indegree
ind <- degree(hp, mode = "in")
ind
plot(hp, layout = layout_with_kk, vertex.size=ind*5, main="Indegree-Verteilung")

# outdegree
outd <- degree(hp, mode = "out")
outd
plot(hp, layout = layout_with_kk, vertex.size=outd*5, main="Indegree-Verteilung")

# betweenness
bet <- betweenness(hp, v = V(hp), directed = TRUE)
bet
plot(hp, layout = layout_with_kk, vertex.size=bet*5, main="Betweeness-Verteilung")

# Closeness
clo <- closeness(hp, v = V(hp), mode = "all")
clo
plot(hp, layout = layout_with_kk, vertex.size=clo*100, main="Closeness-Verteilung")

### ENDE ###

