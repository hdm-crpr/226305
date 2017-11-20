## Analyse und Visualisierung eines Datensatzes mit R ##
# erstellt von Swaran Sandhu, sandhu@hdm-stuttgart.de
# LEKTION 1: Daten aus CSV Dateien einlesen und in igraph-Objekte umwandeln
# LEKTION 2: igraph-objekte in Datenframe umwandeln und sichern bzw laden
# LEKTION 3: Netzwerke manipulieren nach Vertex- und Edgeattributen
# LEKTION 4: Netzwerkmaße berechnen und visualisieren
# LEKTION 5: Akteursmaße berechnen und visualisieren
# LEKTION 6: Netzwerke visuell verbessern mit Zusatzpaketen

# LEKTION 1: Daten aus CSV Dateien einlesen und in igraph-Objekte umwandeln

# neues Projekt in RStudio anlegen, um alle Daten dort zu speichern

setwd("~/Desktop/sna")
# Legt die working directory / Arbeitsverzeichnis fest.
# Edge- und Nodelist sind online in meinen github abgelegt und können daraus direkt eingelesen werden.

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
# zeigt die Verteilung der Vertex-Attribute an.

# Abschluss Lektion 1: Sie haben gelernt, wie man CSV-Datensätze einliest und in ein igraph-Objekt umwandelt.


# LEKTION 2: Sicherung der Dateien

# igraph Objekte können nicht direkt gesichert werden. Deshalb exportieren wir das igraph-Objekt in einen sogannten data.frame. Im Datenframe sind alle Edge- und Node-Attribute hinterlegt. Damit eignet sich das Format besonders gut für den Export in andere Datenformate und zum Zwischenspeichern der Arbeit.

workdf <- as_data_frame(work, what="both")
1

workdf 
# ruft den Datenframe auf. Man sieht gut in der Dateistruktur, wie zunächst zunächst alle Knotenattribute und dann die Kantenattribute übernommen wurden. Sie sehen auch, dass der Datenframe automatisch alle Knoten numerisch codiert, um die Zuordnung zwischen Edge- und Vertex-Attribut herzustellen. Das ist in diesem Beispiel zufällig identisch.

save(workdf,file="workdf.rda")
# sichert den data.frame als R Data Objekt in der working directory. Damit ist ihre Arbeit gesichert.

load(file = "workdf.rda")
# lädt die Datei des Datenframe zurück in R.

iwork <- graph.data.frame(workdf, directed=TRUE, vertices=NULL)
# wandelt den Datenframe in ein igraph Objekt um.

iwork
# ruft das "neue" igraph-Objekt auf, das zuvor als Datenframe gespeichert wurde.

# Zusammenfassung Lektion 2: Sie haben gelernt, wie man ein igraph-Objekt als Datenframe lokal sichert und dann weiter verwendet. Das hat mehrere Vorteile: Datenframes lassen sich schnell in andere Formate exportieren. Ausserdem können Sie so Zwischenschritte sichern und neue Netzwerke anlegen, die sie weiter bearbeiten wollen, etwa Teil- und Subnetzwerke ihres Original-Netzwerks.

# LEKTION 3: Netzwerke manipulieren nach Vertex- und Edgeattributen

# Übersicht über das igraph-Objekt help

help
# ruft das igraph-Objekt auf, das die wichtigsten Punkte des Netzwerks zusammenfasst.

edge_attr(help)
vertex_attr(help)
# fasst die Edge- und Vertex-Attribute des Netzwerks mit den hinterlegten Werten zusammen. Hier ist es notwendig, die Codierung zu berücksichtigen.

# Aufteilen des Netzwerks nach bestimmten EDGE-Attributen
# Hier geht es nur um Beziehungsattribute, alle weiteren Attribute werden durch die Knoten definiert.

h1 <- subgraph.edges(help, E(help)[weight == 1])
# unterteilt das Netzwerk in das Hilfsnetzwerk h1 mit einem Gewicht von 1

h3 <- subgraph.edges(help, E(help)[weight == 3])
# analog dazu das Hilfsnetzwerk mit einem Gewicht von 3

hk <- h1 + h3 
# kombiniert wieder beide Netzwerke zu einem Gesamtnetzwerk

# Aufteilen des Netzwerks nach VERTEX-Attributen
vertex_attr(help)

# Die Selektion des Subgraphs läuft immer gleich: es muss zunächst aus den Vertex-Attributen ein logischer Schluss gezogen werden, der dann in die entsprechende Formel übersetzt wird.

#Selektion nach Geschlecht
# nur Frauen bedeutet, dass das Netzwerk nur noch Vertices mit dem Wert 1 beinhalten darf. Dazu gibt es mehrere Wege:

h_fem <- delete_vertices(help, V(help)[sex == "2"])
# löscht alle Vertex-Attribute mit dem Wert 2, d.h. es bleiben nur alle Knoten mit dem Wert 1 = weiblich übrig.

h_fem
# ruft das neue Unternetzwerk auf, das nur Frauen beinhaltet.

#Mit den logischen Operatoren lassen sich auch weitere Wege finden, die zum gleichen Ziel führen. Der Operator != schliesst etwa alle Attribute aus, die nicht dem angebgenen Wert entsprechen.

h_fem2 <- delete_vertices(help, V(help)[sex != "1"])
# führt zum gleichen Ergebnis, indem alle Vertex-Attribute in der Kategorie "sex", die nicht dem Wert "1" entsprechen gelöscht werden.

#Selektion nach Altersgruppe
# Das Vertex-Attribut Alter ist von 1 bis 4 codiert. Wir wollen jetzt eine Aufteilung des Alters nach jung und alt machen. 

h_j <- delete_vertices(help, V(help)[age > "2"])
# löscht alle Knoten mit den Werten 3 und 4, d.h. es bleiben alle Studierenden bis zum Alter 22 übrig. 

h_a <- delete_vertices(help, V(help)[age < "3"])
# löscht alle Knoten mit den Werten 2 und 3, d.h. es bleiben alle Studierenden älter als 23 Jahre übrig. 

# BONUS: Vergleich der beiden Altersnetzwerke

# Visualisierung Junges Netzwerk h_j in grün
deg <- degree(h_j) 
V(h_j)$size <- deg*3 
V(h_j)$color <- "darkgreen"
E(h_j)$width <- E(h_j)$weight*1.5 
E(h_j)$color <- "darkgreen"
E(h_j)$arrow.size <- .4

# Visualisierung Junges Netzwerk h_j in blau
deg <- degree(h_a) 
V(h_a)$size <- deg*3 
V(h_a)$color <- "lightblue"
E(h_a)$width <- E(h_a)$weight*1.5 
E(h_a)$color <- "lightblue"
E(h_a)$arrow.size <- .4

# vergleicht in der Zeile, wie der gleiche Algorithmus zu leicht unterschiedlichen Darstellungen kommt.
par(mfrow=c(2,2), mar=c(0,0,0,0))   
plot(h_j, layout=layout_with_fr, main="bis 22 Jahre")
plot(help, layout=layout_with_fr, main="Gesamtnetzwerk")
plot(h_a, layout=layout_with_fr, main="23 Jahre und älter")
plot(help, layout=layout_with_fr, main="Gesamtnetzwerk")


# Alle anderen Vertex-Attribute lassen sich genau so analyisieren. Wenn ein Visualisierungsskript vorhanden ist, können die Netzwerke leicht ausgetauscht werden.

# Aufteilen des Netzwerks nach EINZELNEN Knoten (EGO-NETZWERKE im Gesamtnetzwerk)

ego_size(h3)
# zeigt die Knoten mit den meisten Verbindungen, ähnlich wie der degree Wert.

degree(h3)
# Wir stellen fest, dass Knoten 18 die meisten degrees hat. Deshalb wollen wir ein Ego-Netzwerk aus diesem Graph generieren.

ego(h3)
# liefert für jeden Knoten eine detaillierte Aufstellung der Verbindungen.

king <- make_ego_graph(h3, order = 1, nodes = V(h3)$name == 18, mode ="all")
# selektiert aus dem Netzwerk h3 alle Knoten, die mit Knoten 18 über einen Schritt verbunden sind.

king
# liefert eine Liste der Verbindungen (in diesem Falle alle out/indgree Beziehungen von 18)

plot(king[[1]])
# liefert einen (nicht besonders aufregenden) Plot des selektierten Ego-Netzwerks "king"

# Zusammenfassung LEKTION 3: Sie haben gelernt, wie man ein Gesamtnetzwerk nach Edge- oder Vertex-Attributen in Unternetzwerke bzw. aus einem Gesamtnetzwerk ein Ego-Netzwerk erstellen kann.


# LEKTION 4: Netzwerkmaße berechnen und visualisieren

# Zu Beginn der Analyse müssen Sie sich die Frage stellen, was sie besonders interessiert. Es gibt sehr viele Auswertungsmöglichkeiten. Ein Vergleich von Netzwerken oder Teilnetzwerken nach bestimmten Attributen ist meist gewinnbringender, als eine allgemeine Analyse.

triad_census(help)
# ausgegeben werden die 16 Triadentypen und deren Anzahl, siehe igraph triad_census Erklärung


#4a) Teilnetzwerke und Cluster

is_connected(help)
# legt fest, ob es sich um ein Gesamtnetzwerk handelt. Bei FALSE bedeutet dies, dass der Netzwerk in verschiedene Komponenten zerfällt.

count_components(help)
# liefert die Anzahl der Komponentent des Netzwerks (vergleichen Sie das mit dem h_a Netzwerk)

components(work, mode = c("weak", "strong"))
# zeigt an, welche Knoten in welcher Komponente des Netzwerks liegen

#4b) Cluster
cluster_infomap(help)
# liefert eine Berechnung von Clustern im Netzwerk basierend auf deren gegenseitigen Gewichten

#4c) Durchmesser des Netzwerks
diameter(help)
# liefert den weitesten Pfad im Netzwerk

get_diameter(help)
# liefert den kürzesten Weg durch die entsprechenden Knoten

farthest_vertices(help)
# zeigt die am weitesten voneinander entfernten Knoten an.

#4d) Dichte
edge_density(help, loops = FALSE)
# berechnet die Dichte des Netzwerks

# Zusammenfassung Lektion 4: sie haben grundlegende Befehle gelernt, um Netzwerkmaße zu erheben. Dies ist nützlich um Netzwerke miteinander zu vergleichen.

# LEKTION 5: Akteursmaße berechnen und visualisieren
# Im Gegensatz zu den Netzwerkmaßen beziehen sich die Akteursmaße auf die Verteilung der Akteure im Netzwerk. Ein wichtiges Maß hierfür sind die unterschiedlichen Zentralitätsmaße. Dies ist auch eine wichtige Kategorie für die Visualisierung des Netzwerks.

#5a) Degree (in/out)
# Das Degree-Maß ist das einfachste Zentralitätsmaß. Hier geht es nur darum, wie stark Knoten miteinander vernetzt sind. Das indegree-Maß beschreibt die Anzahl der eingehenden edges, das outdegree-Maß die Anzahl der abgehenden edges eines Knoten.

degree(help, mode = "in")
# berechnet die indgrees des help netzwerks

degree(help, mode = "out")
# berechnet die outdegree des Netzwerks help. Logischerweise sind hier alle Werte auf 2 gesetzt, da jeder Akteur zwei abgehende Beziehungen genannt hat.

plot(help, vertex.size=degree(help, mode="in")*2)
# visualisiert das Netzwerk anhand der indegrees

degree(help, mode="in", normalized = TRUE)
# zeigt die prozentuale (d.h. normalisierte) Verteilung aller indegrees im Netzwerk an.

#Zentralisierter Degree-Wert
centr_degree(help)$centralization

#Zentralisierter Closeness-Wert
entr_clo(help, mode = "all")$centralization

#Zentralisierter Betweenness-Wert
centr_betw(help, directed = FALSE)$centralization

#Zentralisierter Eigenvector-Wert
centr_eigen(help, directed = FALSE)$centralization

# Betweenness (Maß für die Brokerage von Knoten im Netzwerk)
betweenness(help)
edge_betweenness(help)








# Erste Visualisierung

plot(works)
plot(helps)


## LEKTTION 2 Zusammenfassen und Trennen von Netzwerken

# beide Teilnetzwerke lassen sich auch zusammenfassen. Allerdings werden dabei gleiche Beziehungen gelöscht.

kurs <- work + help

# Datensicherung der igraph-Objekte

workdf <- as_data_frame(work, what="both")
# erstellt einen Datenframe mit sowohl edge- als auch nodelist

workdf 
# ruft den Datenframe auf. Man sieht gut in der Dateistruktur, wie zunächst zunächst alle Knotenattribute und dann die Kantenattribute übernommen wurden. Sie sehen auch, dass der Datenframe automatisch alle Knoten numerisch codiert, um die Zuordnung zwischen Edge- und Vertex-Attribut herzustellen. Das ist in diesem Beispiel zufällig identisch.

save(workdf,file="workdf.rda")
# sichert den data.frame als R Data Objekt in der working directory. Damit ist ihre Arbeit gesichert.

load(file = "workdf.rda")
# lädt die Datei des Datenframe zurück in R.

iwork <- graph.data.frame(workdf, directed=TRUE, vertices=NULL)
# wandelt den Datenframe in ein igraph Objekt um.

iwork
# ruft das "neue" igraph-Objekt auf, das zuvor als Datenframe gespeichert wurde.


# Vergleich zweier Netzwerke

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

# vergleicht in der Zeile, wie der gleiche Algorithmus zu leicht unterschiedlichen Darstellungen kommt.
par(mfrow=c(2,2), mar=c(0,0,0,0))   
plot(works, layout=layout_with_fr, main="Projektarbeit")
plot(helps, layout=layout_with_fr, main="Unterstützung")
plot(works, layout=layout_with_gem, main="Projektarbeit")
plot(helps, layout=layout_with_gem, main="Unterstützung")

