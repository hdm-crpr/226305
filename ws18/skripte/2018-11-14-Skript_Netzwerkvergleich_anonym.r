# Selbstlern R-Skript zum Erlernen der Netzwerkanalyse in R
# Autor: Swaran Sandhu, sandhu@hdm-stuttgart.de
# Stand: 2018-11-13
# Datensatz n=38 gültige Datensätze
# Erhebungszeitraum anonymisiert

# anonmyisierter Datensatz und Codebuch unter
https://github.com/hdm-crpr/226305/tree/master/ws18/data

# Bitte das Codebuch vor Verwendung des Datensatzes unbedingt lesen, weil sonst die Interpretation der Daten schwerfällt bzw. unmöglich ist.

## igraph-Bibliothek laden

library("igraph")

###########################
# igraph-Objekt erstellen #
###########################

# liest die Dateien direkt aus dem github-Verzeichnis ein
# dazu muss immer die "raw" Version auf github ausgewählt werden
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/ws18/data/el.csv", header=T, as.is=T, sep = ";")

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/ws18/data/nodes.csv", header=T, as.is=T, sep = ";")

# prüft, ob alle Variablen eingelesen wurden. Es werden immer nur die ersten 6 Zeilen des Datensatzes angezeigt.
head(el)
head(nodes)

# wandelt die edgelist in eine Matrix. Das ist nur eine formale Berechnung, die wir als Zwischenschritt brauchen
edgematrix <-as.matrix(el)

# ruft die aus der Edgelist erstellte Matrix oder den Data-Frame auf.
edgematrix

# Jetzt wird die Matrix der Edgelist mit dem Datensatz der Nodelist (Nodes) gekoppelt. Dazu werden alle IDs der from und to-Spalte der edgelist mit den IDs der Nodelist abgeglichen. Diese müssen also genau übereinstimmen, sonst kann die Verbindung beider Listen nicht stattfinden. Ausserdem sollten alle Variablen in der Edge- und Nodelist numerisch codiert sein, um Probleme zu vermeiden.

# Zur Verwendung von graph_from_data_frame: # Die Variable "d" gibt an, welche Matrix bzw. welcher Data-Frame verwendet werden soll. "vertices" bezieht sich auf die Nodelist. Hier kann ein normales CSV-Dokument verwendet werden.

# Gerichtet oder ungerichtet wird definiert über das Argument: directed, das die Werte T für true (also gerichtet) oder F für False (also ungerichtet) annehmen kann. Das ist abhängig von Ihrer Forschungsfrage.

s <- graph_from_data_frame(d=edgematrix, vertices=nodes, directed=T)

# das igraph-Objekt heisst jetzt "s" (für students) und ist ein gerichtetes Netzwerk.

#igraph-Objekt aufrufen
s

# Bitte beachten Sie das igraph-Format:
# DNW_
# directed
# named
# weighted
# 38 Knoten (vertices)
# 152 Kanten (edges)
# Auflistung der Attribute, codiert nach vertex (v/) oder edge(e/) und Art der Codierung: n=numerisch, c=characters (d.h. Text)

###########################
# Einfache Visualisierung #
###########################

# einfache Visualisierung mit Kamada-Kawai Algorithmus (Knoten sind immer an der gleichen Position und werden nicht dynamisch neu berechnet). Ausserdem wird über die Befehle Argumente main ein Titel für die Grafik und sub ein Untertitel hinzugefügt)

plot(s, edge.arrow.size=.05, layout=layout_with_kk, main=" Studierende CR/PR, 3. Semester / Vollerhebung", sub="n=36 Vertices, KK-Algorithmus, ohne Gewicht, beide Fragen (Ratsuche und Zusammenarbeit), 156 Edges")



################################
# Netzwerk-ATTRIBUTE verstehen #
################################

vcount(s)
# im Kurs sind 36 Studierende.

ecount(s)
# die Anzahl der edges (156) ergibt sich aus der Erhebungslogik.
# es wurden 38 Personen zwei Mal zwei Fragen gestellt, die vollständig beantwortet wurden
38*2*2

list.edge.attributes(s)
edge.attributes(s)$weight
edge.attributes(s)$relation
# "relation" ist ein wichtiges edge-attribut, da es die Netzwerke in das "work" (Wert 1) und das "help" (Wert 2) aufteilt (siehe Codebuch). Mit der späteren Aufteilung in zwei Unternetzwerke kann damit ein Vergleich der Netzwerke erstellt werden.

list.vertex.attributes(s)
vertex.attributes(s)

# Erstellen eines ungerichteten Netzwerks (Beispiel)

s_un <- graph_from_data_frame(d=edgematrix, vertices=nodes, directed=F)

s_un

plot(s_un, edge.arrow.size=.1, layout=layout_with_kk, main="Beispiel Studierende ungerichtet", sub="KK-Algorithmus, ohne Gewicht")

# Zurück zu unserem gerichteten Netzwerk s.

################################################
# Multiplexe Netzwerke: zwei Typen von Kanten #
################################################

# Kantenfarben verwenden: wir haben in dem Edge-Attribut "relation" zwei Werte angebgeben, nämlich "1" (work) und "2" (help), die unterschiedliche Beziehungen beschreiben. Sobald mehr als zwei Beziehungsarten in einem Netzwerk auftreten sprechen wir von *multiplexen* Netzwerken. Die Kanten lassen sich entsprechend einfärben:

plot(s,
     edge.arrow.size=.1,
     edge.color=c("red", "blue")[(E(s)$relation=="1")+1],
     vertex.color="gray90",
     vertex.frame.color="white",
     layout=layout_with_kk,
     edge.curved=.2,
     main="Multiplexes Netzwerk, d.h. verschiedene Formen der Beziehung",
     sub="n=38, rot = Ratsuchenetzwerk, blau = Zusammenarbeit")

# Gewicht als Kantenstärke visualisieren
# Damit wir mehr Aussagen über die Beziehungsmuster treffen können, lassen wir uns die Kantenstärke 1 und 3 anzeigen.

# Hier weissen wir dem (feststehenden) Edge-Attribute "width" (Kantenstärke) die Werte der von uns angelegten Gewichte zu. Damit sind die Werte dauerhaft als Edge-Attribut hinterlegt.
E(s)$width <- E(s)$weight
edge.attributes(s)$width

plot(s, edge.arrow.size=.1, layout=layout_with_kk, main="Beispiel Studierende", sub="KK-Algorithmus, Kantenstärke gewichtet")

####################################
# Vereinfachung der Visualisierung #
####################################

# Es lassen sich dauerhafte Parameter als Edge-Attribute festlegen, die automatisch in JEDE Visualisierung übernommen werden:

# definiert die Größe der Pfeilspitze auf 0.2
E(s)$arrow.size <- .2

# definiert die Kantenfarbe auf 60% des Grauwerts
E(s)$color="grey60"

#ALTERNATIV
E(s)$color = edge.color=c("red", "blue")[(E(s)$relation=="1")+1]
# Zurücksetzen durch überschreiben des Werts
E(s)$color="grey60"

# definiert eine leichte Krümmung der Kanten
E(s)$curved=.2

# Achtung: wenn die Werte definiert sind, werden diese dauerhaft verwendet, es sei denn, im plot-Befehl werden andere Werte gesetzt. Dann werden diese Werte überschrieben.

##############################
# VERGLEICH zweier Netzwerke #
##############################

# Netzwerke lassen sich nach bestimmten Kriterien aufteilen. Wir haben im Edge-Attribut "relation" zwei Werte, 1 und 2, die das Ratsuche- und Zusammenarbeitsnetzwerk definieren (siehe Codebuch).

#Um das Netzwerk entsprechend nach Edge-Attributen aufzutrennen, verwenden wir den Befehl "subgraph.edges". Hier werden aus einen Netzwerk entsprechende Unternetzwerke erstellt. In diesem Fall soll das neue Netzwerk "help" generiert werden, in dem alle Knoten und Kanten, die größer als 1 sind in das neue Netzwerk übertragen werden:

help <- subgraph.edges(s, E(s)[relation > 1])
help
plot(help)

plot(help,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     edge.color="red",
     main="Ratsuche-Netzwerk",
     sub="n=38, KK-Algorithmus, Kantenstärke gewichtet")

# Das gleiche machen wir jetzt mit dem Zusammenarbeitsnetzwerk. Hiermit wird das neue Unternetzwerk "work" erstellt.

work <- subgraph.edges(s, E(s)[relation < 2])
work
plot(work)
plot(work,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     edge.color="blue",
     main="Zusammenarbeits-Netzwerk",
     sub="n=38, Kanten von gleicher Stärke, KK-Algorithmus")

####################################################
# Vergleich eines Netzwerks in der gleichen Grafik #
####################################################

# der Befehl "par" (parameters) legt fest, dass die Visualisierung in einer Tabelle von 2x1 Feldern definiert werden. "mar" definiert die Ränder (margins)
par(mfrow=c(1,2), mar=c(0,0,1,2))

# Visualisierung nach unterschiedlichen Algorithmen
plot(help, layout=layout_with_kk,
     main="Ratsuche-Netzwerk",
     edge.color="red",
     edge.arrow.size=.2,
     sub="n=38, KK-Algorithmus")


plot(work,
     layout=layout_with_kk,
     edge.color="blue",
     edge.arrow.size=.2,
     main="Zusammenarbeits-Netzwerk",
     sub="n=36, 72 Kanten von gleicher Stärke, KK-Algorithmus")

# setzt die Visualisierung wieder auf eine Abbildung zurück
par(mfrow=c(1,1))

# Wir wollen jetzt das Ratsuche und das Zusammenarbeitsnetzwerk zusätzlich nach Art der Gewichtung (weight) untersuchen, um die erste und zweite Nennung zu vergleichen:

w3 <- subgraph.edges(s, E(s)[weight > 1])
w3
help_w3 <- subgraph.edges(w3, E(w3)[relation > 1])
help_w3
work_w3 <- subgraph.edges(w3, E(w3)[relation < 2])
work_w3

w1 <- subgraph.edges(s, E(s)[weight < 2])
w1
help_w1 <- subgraph.edges(w1, E(w1)[relation > 1])
help_w1
work_w1 <- subgraph.edges(w1, E(w1)[relation < 2])
work_w1

################################
# Vergleich der vier Netzwerke #
################################

# legt fest, dass die Visualisierung in einer Tabelle von 2x2 Feldern definiert werden
par(mfrow=c(2,2), mar=c(0,0,2,2))

plot(help_w3,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     vertex.color="red",
     main="Ratsuche-Netzwerk: Erste Nennung",
     sub="n=38, KK-Algorithmus")

plot(work_w3,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     main="Zusammenarbeits-Netzwerk: Erste Nennung",
     sub="n=38, KK-Algorithmus")

plot(help_w1,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     vertex.color="red",
     main="Ratsuche-Netzwerk: Zweite Nennung",
     sub="n=38, KK-Algorithmus")

plot(work_w1,
     edge.arrow.size=.1,
     layout=layout_with_kk,
     main="Zusammenarbeits-Netzwerk: Zweite Nennung",
     sub="n=38, KK-Algorithmus")

# setzt die Visualisierung wieder auf eine Abbildung zurück
par(mfrow=c(1,1), mar=c(0,0,0,0))

##########################################
# NETZWERKMASSE für das gesamte Netzwerk #
##########################################

# Maße über das gesamte Netzwerk:

# Wie viele Komponenten hat das Netzwerk?

components(s)
# Netzwerk (s) hat zwei Komponenten
is.connected(s)
# die nicht miteinander verbunden sind

# Vergleichen Sie dies mit unserem Netzwerk work_w3
components(work_w3)
is.connected(work_w3)

# Dichte (Density)

edge_density(s)
# Die Dichte in unserem Netzwerk beträgt 10,81 % (gerundet), d.h. von allen möglichen Beziehungen zwischen den Knoten ist jede zehnte realisiert.

# Vergleichen Sie nun die Netzwerke zwischen den oben generierten Netzwerken work und help: wie lässt sich dieser Wert erklären?

edge_density(work)
edge_density(help)

mean_distance(s)
# Durchschnittliche Pfaddistanz (Schritte), die man braucht, um das Netzwerk zu "durchwandern"

mean_distance(help)
mean_distance(work_w3)

reciprocity(s)
# berechnet, wie hoch der Anteil an reziproken Nennungen im Netzwerk ist.

# Wie lassen sich die Unterschiede zwischen dem Hilfs- und dem Zusammenarbeitsnetzwerk erklären?
reciprocity(work)
reciprocity(help)

# Durchmesser des Netzwerks (maximale Schritte) mit Beispielen. Ausgegeben wird die Reihenfolge der Schritte im Netzwerk.

# liefert den Durchmesser des Netzwerks und die entsprechenden Knoten
dia <- get.diameter(s)
dia

dia_work <- get.diameter(work)
dia_work

dia_help <- get.diameter(help)
dia_help

# fragt nach dem Typ der Daten
class(dia)
#definiert dia als Vector-Daten
as.vector(dia)

# Visualisierung des Diameter

# Wir legen zunächst fest, welche Farben verwendet werden sollen:

dia <- get.diameter(s, directed=T) # ruft die Werte auf
vcol <- rep("gray80", vcount(s)) # setzt alle Werte der Knoten auf grau
vcol[dia] <- "gold" # setzt alle Vertices des Diameters auf gold
ecol <- rep("gray80", ecount(s)) # setzt alle Kanten auf grau
ecol[E(s, path=dia)] <- "orange" # definiert die Farbe des Pfads

# E(net, path=dia) sucht die Kanten entlang des Pfades und färbt diese ein
plot(s,
     vertex.color=vcol,
     edge.color=ecol,
     main="Diameter im Netzwerk",
     sub="kürzester Weg in einem gerichteten Netzwerk")

# Es wird der Weg für dia gesucht und die Knoten entsprechend eingefärbt
dia

############################################
# POSITIONALE bzw. Akteursmaße im Netzwerk #
############################################
# Degree
# Gibt den Vernetzungsgrad aller Knoten an.

degree(s)
# liefert die Anzahl der Kanten, die durch die Knoten gehen.

# Verteilung der Knoten als Histogram dargestellt
ds <- degree(s)
hist(ds, breaks=1:vcount(s)-1, main="Anzahl der Degrees im Netzwerk s")


# Indegree
degree(s, mode="in")
centr_degree(s, mode="in", normalized=T)

# Outdegree
degree(s, mode="out")
centr_degree(s, mode="out", normalized=T)

eigen_centrality(s, directed=T, weights=NA)
centr_eigen(s, directed=T, normalized=T)

edge_betweenness(s, directed=T, weights=NA)
centr_betw(s, directed=T, normalized=T)

# Zentralitätsmaße im Vergleich

# Wir vergleichen nun die unterschiedlichen Zentralitätsmaße. Die Knotengröße entspricht dabei dem Wert des entsprechenden Zentralitätsmaß.

inds <- degree(s, mode="in")
inds
outds <- degree(s, mode="out")
outds

# Visualisierung der beiden In- und Outdegrees Zentralitätsmaße im Vergleich

par(mfrow=c(1,2), mar=c(0,0,2,2))

plot(s,
     layout=layout_with_kk,
     edge.arrow.size=.1,
     vertex.color="grey80",
     vertex.frame.color="white",
     vertex.size=inds*2,
     main="Indegree")

plot(s,
     layout=layout_with_kk,
     edge.arrow.size=.1,
     vertex.color="grey80",
     vertex.frame.color="white",
     vertex.size=outds,
     main="Outdegree")

# Klar ist, dass in diesem Beispiel das Maß von "Outdegree" irrelevant ist, weil jeder Knoten ein Outdegree von 4 hat.

###########################
# Cliquen und Communities #
###########################

# Triadenzensus
count_triangles(s)
# hier wird ausgegeben, welcher Knoten an wie vielen "Dreiecken" beteiligt ist (Gewichtung ist egal)

triad_census(s)
# Die Ausgabe von triad_census erfolgt entlang der vorgegebenen Reihenfolge des Triadenzensus. Beispielsweise sehen Sie, dass es nur drei echte Cliquen (Typ 003) in dem Netzwerk gibt. Der Typ 003 kommt immer an letzter Stelle, Typ 300 (isolates, keine Verbindung) wird immer zu Beginn gestellt.

triad_census(work_w3)

# Cliquen
cliques(s)
largest_cliques(s)
largest_cliques(work)

# Communities bzw. Cluster
# Cluster/Communities sind eng verbundene Knoten, die eine kurze Pfaddistanz zueinander haben.

?cluster_walktrap
s
gc <- cluster_walktrap(s)
modularity(gc)
membership(gc)
par(mfrow=c(1,1), mar=c(0,0,0,0))
plot(gc, s, edge.arrow.size=.2, main="Clusteranalyse des Gesamtnetzwerks")

# Vergleich Ratsuche vs. Zusammenarbeit
# Achtung: die Farben werden zufällig erzeugt.

par(mfrow=c(1,2), mar=c(0,0,1,2))

gh <- cluster_walktrap(help)
modularity(gh)
membership(gh)
plot(gh, help, edge.arrow.size=.2,
     main="Communities Ratsuche",
     sub="Walktrap-Algorithmus und Visualisierung")

gw <- cluster_walktrap(work)
modularity(gw)
membership(gw)
plot(gw, work, edge.arrow.size=.2,
     main="Communities Zusammenarbeit",
     sub="Walktrap-Algorithmus und Visualisierung")

## Vorläufiges ENDE ###
