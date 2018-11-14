# Selbstlern R-Skript zum Erlernen der Netzwerkanalyse in R
# Autor: Swaran Sandhu, sandhu@hdm-stuttgart.de
# Datensatz n=36 gültige Datensätze
# Erhebungszeitraum WS18

# anonmyisierter Datensatz und Codebuch unter
https://github.com/hdm-crpr/226305/tree/master/ws18/data

# Bitte das Codebuch vor Verwendung des Datensatzes unbedingt lesen, weil sonst die Interpretation der Daten schwerfällt bzw. unmöglich ist.


## Grundlagen: igraph-Objekt erstellen

library("igraph")

# igraph-Objekt erstellen

# liest die Dateien direkt aus dem github-Verzeichnis ein
# dazu muss immer die "raw" Version auf github ausgewählt werden
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/ws18/data/el.csv", header=T, as.is=T, sep = ",")

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/ws18/data/nodes.csv", header=T, as.is=T, sep = ",")

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


#

#igraph-Objekt aufrufen
s

# Bitte beachten Sie das igraph-Format:
# DNW_
# directed
# named
# weighted
# 36 Knoten (vertices)
# 144 Kanten (edges)
# Auflistung der Attribute, codiert nach vertex (v/) oder edge(e/) und Art der Codierung: n=numerisch, c=characters (d.h. Text)

# einfache Visualisierung mit Kamada-Kawai Algorithmus (Knoten sind immer an der gleichen Position und werden nicht dynamisch neu berechnet). Ausserdem wird über die Befehle Argumente main ein Titel für die Grafik und sub ein Untertitel hinzugefügt)
plot(s, edge.arrow.size=.05, layout=layout_with_kk, main=" Studierende", sub="n=36 Fälle, KK-Algorithmus, ohne Gewicht")

vcount(s)
# im Kurs sind 36 Studierende.

ecount(s)
# die Anzahl der edges (144) ergibt sich aus der Erhebungslogik.
# es wurden 38 Personen zwei Mal zwei Fragen gestellt, die vollständig beantwortet wurden
36*2*2

# ATTRIBUTE VERSTEHEN

list.edge.attributes(s)
edge.attributes(s)$weight
edge.attributes(s)$relation
# "relation" ist ein wichtiges edge-attribut, da es die Netzwerke in das "work" (Wert 1) und das "help" (Wert 2) aufteilt (siehe Codebuch). Mit der späteren Aufteilung in zwei Unternetzwerke kann damit ein Vergleich der Netzwerke erstellt werden.

list.vertex.attributes(s)
vertex.attributes(s)

# Erstellen eines ungerichteten Netzwerks (Beispiel)

s_un <- graph_from_data_frame(d=edgematrix, vertices=nodes, directed=F)

s_un

plot(s_un, edge.arrow.size=.2, layout=layout_with_kk, main="Beispiel Studierende ungerichtet", sub="KK-Algorithmus, ohne Gewicht")
