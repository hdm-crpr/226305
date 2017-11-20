# Erstellen eines Teilnetzwerks nach bestimmten Kriterien
# Swaran Sandhu, sandhu@hdm-stuttgart.de

# Problem: Sie wollen ein Netzwerk visualisieren, das nur bestimmte Knoten nach bestimmten Kriterien abbildet. Dazu sind zwei Schritte notwendig. Zunächst brauchen Sie das Gesamtnetzwerk und müssen sich dann überlegen, nach welchen Kriterien sie das Netzwerk selektieren wollen. Dann müssen Sie diese Attribute definieren und das entsprechende Netzwerk selektieren

Beispiel:

library(igraph)

# liest die Dateien direkt aus dem github-Verzeichnis ein und wandelt sie in ein igraph Objekt um
help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/nodes.csv", header=T, as.is=T, sep = ",")
hties <-as.matrix(help)
help <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
h <- simplify(help, edge.attr.comb = list(weight="sum"))

# Wir haben nur das igraph Objekt "h" erstellt mit 38 Knoten und 76 Verbindungen.
# Uns interessiert nun ein Teilnetzwerk, in dem nur die Knoten mit mehr als einer Verbindung sichtbar sind. Beispielsweise können dies alle Knoten sein, deren indegree mindestens 2 beträgt.

# Dazu müssen wir zunächst den indegree für alle Knoten berechnen. 
hin <- degree(h, mode = "in")
hin # zeigt die Verteilung des 

# Wir erzeugen jetzt ein neues Vertex-Attribut mit den Namen "indegree"
V(h)$indegree <- hin

# zeigt auch das neue Vertex-Attribut an
vertex_attr(h)

# Im zweiten Schritt müssen Sie nun ein neues Netzwerk erzeugen, in dem Sie die Knoten mit einem bestimmten indegree Wert löschen. Die Auswahl funktioniert hier über logische Operatoren ( == gleich, != ungleich, > größer, < kleiner, >= größer gleich, <= kleiner gleich).

# Wir wollen jetzt allen Knoten, die einen indegree von kleiner gleich 2 haben.
h_in2 <- delete_vertices(h, V(h)[indegree < "2"])

# Das neue Netzwerk anschauen und plotten
h_in2
plot(h_in2)

# Plot grafisch verschönern und mit Titel versehen
plot(h_in2, vertex.size=degree(h_in2)*5, vertex.color="lightblue", vertex.frame.color="white", edge.arrow.size=.2, edge.curved=.2, vertex.label.dist=2, vertex.label.degree=0, vertex.label.cex=.8, vertex.label.family="Helvetica", vertex.label.font=2, main="Teilnetzwerk mit indegree > 2")


 



