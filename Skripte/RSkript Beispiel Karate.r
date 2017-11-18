# R-Skript zum Erlernen der Netzwerkanalyse in R
# Swaran Sandhu, sandhu@hdm-stuttgart.de

# Inhaltsverzeichnis
# LEKTION 1: Pakete installieren und Datensätze aufrufen
# LEKTION 2: Einfache Netzwerkdaten analysieren
# LEKTION 3: Teilnetzwerke auswählen
# LEKTION 4: Graphische Darstellung von Netzwerken

# LEKTION 1: Pakete installieren und Datensätze aufrufen

setwd("~/Desktop/226503") 
# Arbeitsverzeichnis definieren (Menü > Session > Set Working Directory)

install.packages("igraph") # installiert igraph Paket
install.packages("igraphdata") # installiert igraphdata Paket mit Datensätzen
install.packages("intergraph") # installiert intergraph Paket für den Datenaustausch

library(igraph) # grundlegendes Basispakete
library(igraphdata) # zusätzliche Datenpakete
library(intergraph) # Datenübergabe zwischen Bibliotheken

?igraphdata # Hilfefunktion zu dem Paket
data(package="igraphdata") # zeigt die Datensätze des Pakets an

data(karate) # aktiviert den Datensatz "karate"
karate # ruft den Datensatz auf

# Das igraph-Objekt liefert bereits den wichtigsten Überblick über den Datensatz. Eine einfache Visualisierung hilft, einen schnellen Überblick zu erhalten:

plot(karate) # zeigt eine einfache Visualisierung an

# Welche Attribute haben die Kanten?
list.edge.attributes(karate)

# Welche Attribute haben die Knoten?
list.vertex.attributes(karate)

# Wie sind die entsprechenden Attribute verteilt?
E(karate)$weight #Verteilung des Gewichts in der edgelist
weight <- E(karate)$weight # kreiert einen Vektor mit den Werten aus "weight

# Genau das gleiche lässt sich mit den Vertex-Attributen machen:
name <- V(karate)$name
label <- V(karate)$label
color <- V(karate)$color

# Wenn wir jetzt wissen wollen, wie die Bezeichnungen der Knoten verteilt ist, reicht die Eingabe von "label", um eine Aufstellung zu erhalten. Daraus wird ersichtlich: Knoten 1 ist "Mr Hi", Knoten 34 ist "John A", alle anderen Knoten sind anonyomisiert. Im Netzwerk werden diese über den Vertex "name" visualisiert.

# LEKTION 2: Einfache Netzwerkdaten analysieren

# Uns interessieren einfache Netzwerkdaten, bezogen auf a) Netzwerkmaße und b) Akteursmaße.

# 1. Netzwerk-Maße (bezogen auf das gesamte Neztzwerk)

# Wie viele Knoten und Kanten sind im Netzwerk?
ecount(karate) # Anzahl der edges
vcount(karate) # Anzahl der vertices

# Dichte des Netzwerks (Anzahl der realisierten Beziehunge zwischen Knoten im Verhältnis zu allen möglichen Verbindungen)
edge_density(karate)

# Zentralisierte zwischen den Knoten 
centr_degree(karate, mode = c("all"), loops = TRUE, normalized = TRUE)


# Akteurs-Maße (bezogen auf die Position einzelner Knoten im Netzwerk)

# Wer ist am stärksten im Netzwerk vernetzt? (allgemeiner Degree-Wert)
degree(karate)

# Bei einem gerichteten Netzwerk könnten wir die In- und Outdegrees analysieren. Bei einem ungerichteten Netzwerk spielt das allerdings keine Rolle.
degree(karate, mode ="out")

# Die einfache Nennung der Häufigkeit eines Degree-Werts sagt uns noch nicht viel aus. Deshalb lässt sich der Degree-Wert normalisieren, d.h. alle Werte werden auf prozentuale Werte zwischen 0 und 1 umgerechnet.

degree(karate, mode="all", normalized = TRUE)

#alternativ

centr_degree(karate, mode = c("all"), loops = TRUE, normalized = TRUE)

# Mit der Normalisierung bzw. Zentralisierung lässt sich schneller erkennen und interpretieren, wie die Beziehungen zu anderen Knoten im Netzwerk verteilt sind. Dies eignet sich gut, um Netzwerke zu vergleichen.

# Zentralisierter Degree-Wert
centr_degree(karate)$centralization

#Zentralisierter Closeness-Wert
entr_clo(karate, mode = "all")$centralization

#Zentralisierter Betweenness-Wert
centr_betw(karate, directed = FALSE)$centralization

#Zentralisierter Eigenvector-Wert
centr_eigen(karate, directed = FALSE)$centralization

# Für den Vergleich der Werte ist es notwendig, sich die einzelnen Unterschiede der Zentralitätsmaße und deren Auswertung anzuschauen.

# Wir können zur Visualisierung der Knoten gleich einen Vector "kdegnorm" anlegen, damit wir den Wert nicht nochmals berechnen müssen:

kdegnorm <- degree(karate, mode="all", normalized = TRUE)

# Betweenness (Maß für die Brokerage von Knoten im Netzwerk)
betweenness(karate)
edge_betweenness(karate)

# LEKTION 3: Teilnetzwerke auswählen

# Triadenzenus (eigentlich nur bei gerichteten Netzwerken)
triad_census (karate)
# ausgegeben werden die 16 Triadentypen und deren Anzahl, siehe igraph triad_census Erklärung

#Verbindungen der einzelnen Knoten

#Auflistung der Verbindungen der Knoten (entspricht degree)
ego_size(karate) 

#Detaillierte Aufstellung aller Knoten und deren direkte Verbindung
ego(karate)

ego(karate, order = 1, nodes = V(karate)$name == "Mr Hi", mode = "all")
#selektiert das Ego-Netzwerk von Mr. Hi. In einem gerichteten Netzwerken kann "mode" durch in und out unterschieden werden. Mit dem Befehl "order" werden die angrenzenden Knoten ausgewählt, bei 1 sind dies alle Knoten, die direkt mit ego verbunden sind. Bei order = 2 werden auch Knoten erfasst, die zwei Schritte von Ego entfernt sind.

# Selektion spezifischer Knoten und Edges innerhalb des Netzwerks

# mit make_ego_graph lassen sichn spezifische Knoten des Netzwerks auflisten.

mrhi <- make_ego_graph(karate, order = 1, nodes = V(karate)$name == "Mr Hi", mode = "all")

# Eine Alternative zu make_ego_graph ist der Befehl incident. Damit werden alle edges ausgewählt, die eine Verbindung zu einem bestimmten Knoten haben.

hi <- incident(karate, V(karate)[name=="Mr Hi"], mode="all")

# Achtung: beide Selektionen liefern keinen separaten Subgraph, sondern nur eine Selektion von spezifischen Werten, die z.B. für die Visualisierung relevant sind.

plot(mrhi[[1]])
# liefert einen nicht besonders aufregenden Plot des Ego-Netzwerks von mrhi


# Erstellen von eigenen Untergruppen aus dem Netzwerk

# Es gibt verschiedene Wege, separate Untergruppen aus einem bestehenden Netzwerk zu erstellen. Am einfachsten ist dies, indem bestimmte Knoten oder Edges gelöscht werden. Um sicher zu sein, dass keine Daten verloren gehen, ist es immer sinnvoll, neue Netzwerke anzulegen.

# erstellt as Netzwerk k2, indem alle Knoten des Netzwerks karate gelöscht werden, die nicht den Wert "1" im Vertex-Attribut "Faction" haben. Es bleiben also nur nochn Mitglieder der Fraktion 2 übrig.
k1 <- delete_vertices(karate, V(karate)[Faction == "2"])

#Alternativer Befehl: hier wird statt dem logischen == (entspricht gleich) mit "!=" (ist nicht gleich) gearbeitet. Das ist immer dann besonders hilfreich, wenn ein Wert viele Ausprägungen annehmen kann. Das Ergebnis ist das gleiche, wie die Direktauswahl oben. 

k1a <- delete_vertices(karate, V(karate)[Faction != "1"])

# Erstellen eines Teilnetzwerks basierend auf bestimmten Beziehungswerten

# Was für Knoten gilt lässt sich auch für die Kanten darstellen. Nachfolgend lassen sich Teilnetzwerke mit dem Befehl subgraph.edges erzeugen, wobei die Edges nach einem bestimmten Kriterium ausgewählt werden, in diesem Fall muss der Wert des edgeweights größer gleich 4 sein, d.h. es werden alle edges mit einem Gewicht kleiner als 4 gelöscht. Alternative Operatoren sind auch hier < kleiner, <= kleiner gleich, > größer und >= größer gleich sowie == entspricht genau und != entspricht nicht. 

k4 <- subgraph.edges(karate, E(karate)[weight >= 4])

# Die Werte für die Edges lassen sich beliebig austauschen und einfach durch die Wiederholung des Befehls neu gestalten.

# Alternativ lassen sich auch die Kanten selektieren. Dabei bleiben allerdings die gesamten Knoten übrig, deshalb ist es notwendig, einen sinnvollen Wert zur Auswahl zu definieren. 

kw3 <- delete.edges(karate, which(E(karate)$weight <=3))

# In dieser Lektion haben Sie gelernt, wie man Teilbereiche des Netzwerks auswählt bzw. isoliert sowie einzelnen Knoten und deren Umgebung auswählt. Ausserdem können Sie nun Knoten und Kanten aus einem Netzwerk basierend auf bestimmten Attributen oder Netzwerkmaßen entfernen und neue Teilnetzwerke erstellen.

# LEKTION 4: Graphische Darstellung von Netzwerken

# Eine Übersicht über alle Befehle für die graphische Darstellung von Netzwerken erhölt man durch
?igraph.plotting 

# Alle Knotenattribute werden durch "vertex." dargestellt.
# Alle Kantenattribute werden durch "edge." dargestellt.

# Es ist möglich, alle Attribute des der Darstellung zu manipulieren: Hierbei werden neue Knoten und Kantenattribute angelegt, die dauerhaft bestehen bleiben und dann nicht mehr über den Befehl "plot" extra bearbeitet werden müssen.

# definiert einige Attribute für das Netzwerk
deg <- degree(karate) 
V(karate)$size <- deg*3 
E(karate)$width <- E(karate)$weight*1.5 
E(karate)$arrow.size <- .4

# definiert, dass die Kanten in der Farbe der verbundenen Knoten erstellt werden
edge.start <-ends(karate, es=E(karate), names = F) [,1]
edge.col <- V(karate)$color[edge.start]

# einfacher Plot mit den modifizierten Kantenfarben
plot(karate, edge.color=edge.col, edge.curved=.1)

# Einsatz von verschiedenen Layouts
# Mit dem Befehl "layout" lassen sich bereits vorgefertige Algorithmen aufrufen, die dann schnell dargestellt werden können.

# Beispiel für Fruchterman-Rheingold Algorithmus zur Visualisierung

plot(karate, layout = layout_with_fr, edge.color=edge.col, edge.curved=.2,)


# Vergleich verschiedener Layouts

par(mfrow=c(2,2), mar=c(0,0,0,0))   
plot(karate, layout=layout_with_fr, main="Fruchterman Rheingold")
plot(karate, layout=layout_with_kk, main="Kamada Kawai")
plot(karate, layout=layout_with_mds, main="Multidimensional Scaling")
plot(karate, layout=layout_with_graphopt, main="Graphopt")

# Die Algorithmen Kamada-Kawai und MDS definieren eine stabile Position der Knoten in einem Koordinatensystem. Deshalb sind diese besonders gut geeignet, um die Entwicklung von Teilnetzwerken über die Zeit zu visualisieren.

## DIAMETER (Durchmesser) berechnen und visualisieren

library(igraph)
library(igraphdata)
data(karate)

g <- karate
d <- get.diameter(g)

E(g)$color <- "grey"
E(g)$width <- 1
E(g, path=d)$color <- "red"
E(g, path=d)$width <- 2
V(g)$label.color <- "blue"
V(g)$color  <- "SkyBlue2"
V(g)[ d ]$label.color <- "black"
V(g)[ d ]$color <- "red"

plot(g, layout=layout.fruchterman.reingold, vertex.label.dist=0, vertex.size=15)
title(main="Diameter of the Zachary Karate Club network")


# BONUS zum Ausprobieren: interaktiver Plot
# Einfache interaktive Darstellung des Netzwerks via tkplot
# Diese Anwendung ruft ein simples interaktives Fenster auf, in dem das Netzwerk repräsentiert wird. Die Funktion tkplot (http://igraph.org/r/doc/tkplot.html) setzt voraus, dass auf dem Mac X11 installiert ist.

# Das Beispiel zeigt, wie einfach ein beliebiges Netzwerk visualisiert werden kann. Alle Visualisierungsparameter vor dem Plot-Befehl werden von tkplot übernommen, bzw. für tkplot selbst können bestimmte Parameter gesetzt werden.

library(igraph)
library(igraphdata)
data(karate)

# weist karate die Variable "g" zu.
g <- karate

# einfache Visualisierung
V(g)$color <- "lightblue"
E(g)$color <- "grey"

# erzeugt einen interaktiven plot nach bestimmten Vorgaben
tkplot(g, layout=layout.kamada.kawai, vertex.label.font=2, vertex.frame.color = "white")


