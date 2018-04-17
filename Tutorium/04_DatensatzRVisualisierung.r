### Tutorium Netzwerke 18. April 2018

# Wir lernen heute, wie man ein Netzwerk visualisiert. Dafür habe ich ein kleines Netzwerk vorbereitet, das ihr erst einmal einlesen müsst.

# Bitte ladet die CSV-Dateien aus dem Moodle Kurs unter „Tutorium“ runter und speichert sie in eurem Working Directory.
# Bitte ladet igraph!!!
# Dann lesen wir die Edgelist und die Nodelist ein und weisen ihnen gleich kurze Variablen zu.

el <- read.csv("18-4-18_Beispiel_Edgelist.csv", header=T, as.is=T, sep=",")
nl <- read.csv("18-4-18_Beispiel_Nodelist.csv", header=T, as.is=T, sep=",")

# Schauen wir doch einmal, was wir hier für Daten haben.

head(el)
head(nl)

# Erstellen wir daraus ein igraph Objekt. Dafür muss die Edgelist erst einmal als Matrix vorliegen.

mel <- as.matrix(el)

# Dann erstellen wir das igraph Objekt und verknüpfen dabei die Daten der Nodelist.

tutgraph <- graph_from_data_frame(d=mel, vertices=nl, directed=T)

# Ja, mein Graph ist gerichtet. Wenn ihr ein ungerichtetes Netzwerk habt, müsst ihr nach directed F für false angeben.

# Schauen wir unser igraph Objekt einmal an.

tutgraph

# Wir haben ein gerichtetes Netzwerk (N) mit Vertex Namen (N) und Beziehungsgewichten (W). Es ist nicht bi-partit (-). Wir haben die Vertex-Attribute Name, Label, Sex und das Edge-Attribut weight.

# Dann mal sehen:

plot(tutgraph)

# Wir wollen die Pfeile kleiner haben! (Achtung: Bei Zahlen kein Komma, sondern einen Punkt setzen!)

plot(tutgraph, edge.arrow.size=0.4)

# Wir wollen nicht die Labels als Namen, sondern die richtigen Namen!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name)

# Wir wollen gar keine Labels.

plot(tutgraph, edge.arrow.size=0.4, vertex.label=NA)

# Wir wollen pinke Knoten!
# Was für Farben gibt es überhaupt in R?

colours()

# Na dann, pink2 bitte!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=NA, vertex.color="pink2")

# Aber bitte mit red3 Knotenrahmen!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=NA, vertex.color="pink2", vertex.frame.color="red3")

# Oder doch lieber gar kein Knotenrahmen?

plot(tutgraph, edge.arrow.size=0.4, vertex.label=NA, vertex.color="pink2", vertex.frame.color="transparent")

# Nehmen wir wieder die Namen als Label!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent")

# Die Labels bitte ohne Serifen...

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica")

# Und die Labels in magenta3!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3")

# Die Labels neben den Knoten!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2)

# Das Netzwerk nach einem Algorithmus (z.B. dem von Fruchterman/Reingold) anordnen!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2, layout=layout_with_kk)

# Eine Überschrift bitte!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2, layout=layout_with_kk, main="Tutorium Nummer 4")

# Man soll das Gewicht der Kanten sehen!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2, layout=layout_with_kk, main="Tutorium Nummer 4", edge.width=E(tutgraph)$weight)

# Die Kanten sollen gelb sein!

plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2, layout=layout_with_kk, main="Tutorium Nummer 4", edge.width=E(tutgraph)$weight, edge.color="yellow")

# Wenn noch Zeit bleibt: Wir wollen die Männer in blau, die Mädchen in rosa!

farbe <- c("pink", "lightblue") # In der Reihenfolge, da in der Nodelist 1 für Frauen und 2 für Männer stand!
V(tutgraph)$color <- farbe[V(tutgraph)$sex]
plot(tutgraph, edge.arrow.size=0.4, vertex.label=V(tutgraph)$name, vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", vertex.label.dist=2, layout=layout_with_kk, main="Tutorium Nummer 4", edge.width=E(tutgraph)$weight, edge.color="yellow")

# Ihr seht: Mit dem plot-Befehl kann man eine Menge machen.
