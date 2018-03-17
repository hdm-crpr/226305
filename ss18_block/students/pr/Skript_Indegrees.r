# Netzwerk PR
# Selektion Teilnetzwerk nach Degrees

# Paket laden
library(igraph)

# edgelist einlesen
# edgelist muss in der working directory liegen bzw. müssen Sie entsprechend ihrer edgelist umbenennen
pr <- read.csv("elpr.csv", header=T, as.is=T, sep = ",")

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

# Kleine Visualierung
plot(pr_plus1, vertex.size=degree(pr_plus1, mode="in"), vertex.label=NA)

# Das Problem dabei ist aber, dass wir auch die untersuchte Quell-Literatur gelöscht haben, weil diese Knoten ja auch einen indegree = 1 hatten. Wir müssen also verhindern, dass die Quell-Knoten gelöscht werden.

