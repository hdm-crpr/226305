# Visualisierung mit VisNetwork
# 2018-04-30 | sandhu@hdm-stuttgart.de

# VisNetwork ist ein Paket, das es uns ermöglicht, Visualisierungen für Websites zu erstellen. Wir haben ausserdem einfachere Möglichkeiten für dynamische Websites. Mehr Info unter http://datastorm-open.github.io/visNetwork/

# Wir erstellen das studentische Hilfsnetzwerk von Grund auf:
library(igraph)
help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")
hties <-as.matrix(help)
h <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
class(h)
h
plot(h)

# Wir legen jetzt Visualisierungsparameter fest

# Kantenattribute
E(h)$arrow.size <- .2
E(h)$color="darkgrey"
E(h)$width <- E(h)$weight/2 # legt das Kantengewicht fest
E(h)$curved=.3

# Visualisierung nach degrees in Abstufung von gelb nach rot
hd <- degree(h, mode = "all")
fine = 4
palette = colorRampPalette(c('yellow','red'))
ired = palette(fine)[as.numeric(cut(hd, breaks = fine))]

# Vertexattribute festlegen
V(h)$size = hd
V(h)$color = ired
plot(h, layout = layout_with_kk)

# Plot mit Titel und Untertitel

plot(h, layout = layout_with_kk, main="Hilfsnetzwerk", sub="38 Knoten, Größe und Farbintensität nach Degrees visualisiert")

# Mit dem Netzwerk sind wir soweit zufrieden. Nur könnte die Darstellung etwas schöner sein. Hier kommt jetzt VisNetwork ins Spiel. VisNetwork ist ein Zusatzpaket, mit dem man leichter Visualisierungen umsetzen und v.a. für das Web als dynamische HTML-Seite exportieren kann. Es basiert auf einer JavaScript Bibliothek.

library(visNetwork)
?visNetwork

# Mit dem Befehl visIgraph() lassen sich bereits vorhandenen igraph-Objekte visualisieren. Mehr Info hier: http://datastorm-open.github.io/visNetwork/

visIgraph(h, layout = "layout_with_kk")
# oder auch:
visIgraph(h, layout = "layout_in_circle")
visIgraph(h, layout = "layout_with_fr")
visIgraph(h, layout = "layout_nicely")

# Ein Nachteil ist, dass sich die Kanten nicht mehr krümmen lassen, aber dafür ist die Aufteilung der Knoten in der Regel deutlich besser.

# Beispielsweise lassen sich so für das Web einfache Navigationsbuttons anlegen:
visIgraph(h, layout = "layout_with_kk") %>%
  visInteraction(navigationButtons = TRUE)
