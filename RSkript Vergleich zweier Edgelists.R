# Vergleich zweier Netzwerke mit Visualisierung
# Skript für Lehrzwecke in der Veranstaltung 226305 Netzwerk- und Beziehungsmanagement

# Autor: Swaran Sandhu, sandhu@hdm-stuttgart.de
# inspiriert von https://github.com/kateto/R-Network-Visualization-Workshop


# Laden Sie die Dateien "e-work.csv" und "e-help.csv" in ihre working directory.

setwd("~/Desktop/sna")
library(igraph)

# liest die edgelist des Zusammenarbeits-Netzwerks ein
edges <- read.csv("e-work.csv", header=T, as.is=T, sep = ";")
work <- graph_from_data_frame(edges, directed = TRUE, vertices = NULL)

# liest die edgelist des Unterstützungsnetzwerks ein
edges <- read.csv("e-help.csv", header=T, as.is=T, sep = ";")
ehelp <- graph_from_data_frame(edges, directed = TRUE, vertices = NULL)

# addiert die Gewichte bei gleichen Beziehungen
works <- simplify(work, edge.attr.comb = list(weight="sum"))
helps <- simplify(ehelp, edge.attr.comb = list(weight="sum"))

# Visualisierung works (orange)
deg <- degree(works) 
V(works)$size <- deg*3 
V(works)$color <- "orange"
E(works)$width <- E(works)$weight*1.5 
E(works)$color <- "orange"
E(works)$arrow.size <- .4

# Visualisierung help (blue)
deg <- degree(helps) 
V(helps)$size <- deg*3
V(helps)$color <- "lightblue"
E(helps)$width <- E(helps)$weight*1.5 
E(helps)$color <- "lightblue"
E(helps)$arrow.size <- .4

# vergleicht in der Zeile, wie der gleiche Algoithmus zu leicht unterschiedlichen Darstellungen kommt.
par(mfrow=c(2,2), mar=c(0,0,0,0))   
plot(works, layout=layout_with_fr, main="Projektarbeit")
plot(helps, layout=layout_with_fr, main="Unterstützung")
plot(works, layout=layout_with_gem, main="Projektarbeit")
plot(helps, layout=layout_with_gem, main="Unterstützung")