# Einlesen von den beiden Datensätzen Work & Help
# Achtung: ersetzen Sie bei Netzwerkbezeichnungen und Zuweisungen entsprechend dem Netzwerk, das Sie analysieren.
# Dieses Skript untersucht den Datensatz Ratsuche (help) und Zusammenarbeit (work) in einem Semster.
# Codebuch hier: https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd

library(igraph)
# lädt das Paket "igraph"

help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")
work <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ework.csv", header=T, as.is=T, sep = ",")
# lädt die edgelist aus der Datei in der working directory. Auf Trennzeichen achten!

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/nodes.csv", header=T, as.is=T, sep = ",")
# lädt die Nodelist aus der working direcotry

head(help)
head(nodes)
# überprüfen von Edge- und Nodelist in R

hties <-as.matrix(help)
wties <-as.matrix(work)
# Umwandlung der Edgelist in eine Matrix

help <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
work <- graph_from_data_frame(d=wties, vertices=nodes, directed=T)
# Kombination der Edge- und Nodelist in ein igraph-Objekt

works <- simplify(work, edge.attr.comb = list(weight="sum"))
helps <- simplify(help, edge.attr.comb = list(weight="sum"))
# addiert die Gewichte bei gleichen Beziehungen

edge_attr(work)
# zeigt die Verteilung des Attributs "weight" an.

vertex_attr(work)
# zeigt die Verteilung der Vertex-Attribute an

plot(work, edge.arrow.size=.1, edge.width=E(work)$weight, layout = layout_with_kk, main="Zusammenarbeit")

plot(help, edge.arrow.size=.1, edge.width=E(help)$weight, layout = layout_with_kk, main="Ratsuche")

#############

# Analyse Gesamtnetzwerk
# Netzwerkmaße eignen sich für den Vergleich von mehreren Netzwerken, um etwas über deren Struktur auszusagen.

# Wie viele Componenten hat das Netzwerk?

components(help)
is_connected(help)

# Welchen Durchmesser hat das Netzwerk?
diameter(help)

# Wie ist die Dichte des Netzwerks?
edge_density(help)

# Wie ist die durchschnittliche Pfad-Distanz?
mean_distance(help)


## Clustervergleich

# Ratsuche
chelp <- cluster_walktrap(help)
modularity(chelp)
membership(chelp)
plot(chelp, help, edge.arrow.size=.2, main="Walktrap-Cluster Ratsuche")

# Zusammenarbeit
cwork <- cluster_walktrap(work)
modularity(cwork)
membership(cwork)
plot(cwork, help, edge.arrow.size=.2, main="Walktrap-Cluster Zusammenarbeit")

# Aufteilen des Netzwerks nach bestimmten EDGE-Attributen
# Hier geht es nur um Beziehungsattribute, alle weiteren Attribute werden durch die Knoten definiert.

list.edge.attributes(h)
# liefert alle Edge-Attribute, die wir bearbeiten können. Hier nur das Gewicht.

h1 <- subgraph.edges(help, E(help)[weight == 1])
plot(h1, edge.arrow.size=.1, layout = layout_with_kk, main="Ratsuche mit Gewicht 1")
# unterteilt das Netzwerk in das Hilfsnetzwerk h1 mit einem Gewicht von 1

h3 <- subgraph.edges(help, E(help)[weight == 3])
plot(h3, edge.arrow.size=.1, layout = layout_with_kk, main="Ratsuche mit Gewicht 3")
# analog dazu das Hilfsnetzwerk mit einem Gewicht von 3

hk <- h1 + h3
# kombiniert wieder beide Netzwerke zu einem Gesamtnetzwerk
plot(hk, edge.arrow.size=.1, layout = layout_with_kk, main="addiertes Ratsuche-Netzwerk gesamt")

# Aufgabe: führen Sie die Analyse für das Work-Netzwerk durch.

# Selektion des Netzwerks nach Vertex-Attribut

#Selektion nach Geschlecht
# nur Frauen bedeutet, dass das Netzwerk nur noch Vertices mit dem Wert 1 beinhalten darf. Dazu gibt es mehrere Wege:

h_fem <- delete_vertices(help, V(help)[sex == "2"])
h_fem
plot(h_fem, edge.arrow.size=.1, layout = layout_with_kk, main="Weibliche Ratsuche")
# löscht alle Vertex-Attribute mit dem Wert 2, d.h. es bleiben nur alle Knoten mit dem Wert 1 = weiblich übrig.

h_male <- delete_vertices(help, V(help)[sex != "2"])
plot(h_male, edge.arrow.size=.1, layout = layout_with_kk, main="Männliche Ratsuche")
# führt zum gleichen Ergebnis, indem alle Vertex-Attribute in der Kategorie "sex", die nicht dem Wert "1" entsprechen gelöscht werden.

# Beispiel Selektion nach Alter

over_23 <- delete_vertices(help, V(help)[age < "3"])
plot(over_23, edge.arrow.size=.1, layout = layout_with_kk, main="Ratsuche über 23 Jahre alt")
# löscht alle Knoten mit den Werten 2 und 3, d.h. es bleiben alle Studierenden älter als 23 Jahre übrig.
under_20 <- delete_vertices(help, V(help)[age > "2"])
plot(under_20, edge.arrow.size=.1, layout = layout_with_kk, main="Ratsuche unter 20 Jahre alt")

# Dyaden und Triaden

dyad_census(help)
triad_census(help)

# Cliquen

# Wo sind die größten Cliquen im Netzwerk?
cliques(help, min=4)

# liefert einen Vector mit den größten Cliquen im Netzwerk
lg <- largest.cliques(help)
lg
# Umbenennung des Vectors
clique1 <- lg[[1]]
clique2 <- lg[[2]]
clique1

# Teilnetzwerke aus dem Vector generieren
c1 <- induced.subgraph(graph=help,vids=clique1)

# Visualisierung
plot(c1, edge.arrow.size=.1)

maximal.cliques.count(help, 3, 3)
