# Netzwerk PR
# Selektion Teilnetzwerk nach Degrees

# Datensatz und Skript auf
https://github.com/hdm-crpr/226305/tree/master/ss18_block/students/pr

# Paket laden
library(igraph)

# edgelist einlesen
# edgelist muss in der working directory liegen bzw. müssen Sie entsprechend ihrer edgelist umbenennen
# ich habe den Datensatz auf mein Github geschoben
pr <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/ss18_block/students/pr/el_pr_oj.csv", header=T, as.is=T, sep = ",")

# edgelist prüfen
pr

# edgelist umwandeln in igraph-objekt
pr <- graph_from_data_frame(pr, directed=T)

# igraph-Objekt prüfen
pr

# 879 Knoten mit 1227 Edges
# nur vertex Attribut "name"

# Neues Vertex-Attribut "ind" erstellen, basierend auf der Berechnung vom indegree nach degree(pr, mode = "in")
V(pr)$ind = degree(pr, mode = "in")
pr

# prüfen, ob das Vertex-Attribut erstellt wurde
list.vertex.attributes(pr)

# zeigt uns alle zugewiesenen indegrees in pr an: man sieht, dass es nur wenige über 2 gibt.
V(pr)$ind

# Teilnetzwerk erstellen, indem alle Knoten gelöscht werden, die einen Indegree-Wert von kleiner als 2 haben
pr_plus1 <- delete_vertices(pr, V(pr)[ind == "1"])

# Teilnetzwerk prüfen
pr_plus1

# zeigt, dass alle indegree-Werte mit 1 gelöscht wurden, auch die hohen Werte von gestern sind mit dabei.
V(pr_plus1)$ind

# Kleine Visualisierung
plot(pr_plus1, vertex.size=degree(pr_plus1, mode="in"), edge.arrow.size=0.05, vertex.label.cex=.5, vertex.label.color="black", layout = layout_with_fr, main="Zitationsnetzwerk PR-Einführungsliteratut", sub = "Visualisierung nach Indegree-Verteilung, indegree > 1")

# Ohne Labels
plot(pr_plus1, vertex.size=degree(pr_plus1, mode="in"), edge.arrow.size=0.05, layout = layout_with_fr, main="Zitationsnetzwerk PR-Einführungsliteratut", sub = "Visualisierung nach Indegree-Verteilung, indegree > 1")

# Das Problem dabei ist aber, dass wir auch die untersuchte Quell-Literatur gelöscht haben, weil diese Knoten ja auch einen indegree = 1 hatten. Wir müssen also verhindern, dass die Quell-Knoten gelöscht werden.

# Sie können folgendes tun:
# a) im Skript die Anzahl der indegrees variieren und schauen, was passiert
# b) Teilnetzwerke für die einzelnen Autoren erstellen und miteinander vergleichen
