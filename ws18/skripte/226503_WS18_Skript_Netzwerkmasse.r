# Selbstlern R-Skript zum Erlernen der Netzwerkanalyse in R
# Autor: Swaran Sandhu, sandhu@hdm-stuttgart.de
# Datensatz n=38

# igraph-Objekt erstellen

library("igraph")

# igraph-Objekt erstellen

# liest die Dateien direkt aus dem github-Verzeichnis ein
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")

# prüft, ob alle Variablen eingelesen wurden
head(el)
head(nodes)

# wandelt die edgelist in eine Matrix um und baut das igraph-Objekt
eties <-as.matrix(el)
s <- graph_from_data_frame(d=eties, vertices=nodes, directed=T)
# das igraph-Objekt heisst jetzt "s" (für students)

#igraph-Objekt aufrufen
s
plot(s, edge.arrow.size=.05, layout=layout_with_kk, main="Beispiel Studierende", sub="KK-Algorithmus, ohne Gewicht")

vcount(s)
# im Kurs sind 38 Studierende.

ecount(s)
# die Anzahl der edges (152) ergibt sich aus der Erhebungslogik.
# es wurden 38 Personen zwei Mal zwei Fragen gestellt, die vollständig beantwortet wurden
38*2*2

list.edge.attributes(s)
edge.attributes(s)$weight
edge.attributes(s)$relation
# "relation" ist ein wichtiges edge-attribut, da es die Netzwerke in das "work" (Wert 6) und das "help" (Wert 7) aufteilt (siehe Codebuch). Mit der späteren Aufteilung in zwei Unternetzwerke kann damit ein Vergleich der Netzwerke erstellt werden.

list.vertex.attributes(s)
vertex.attributes(s)

# simplify-Befehl
# addiert edges auf, wenn sie auf der gleichen Beziehung liegen
# So sieht die Verteilung der Gewichtungen bislang aus:
edge.attributes(s)$weight

# Achtung: nur verwenden, wenn Sie tatsächlich auch in der edgelist in numerisches weight angelegt haben

s1 <- simplify(s, edge.attr.comb = list(weight="sum"))
edge.attributes(s1)$weight
# die weights im Netzwerk s1 wurden aufaddiert, sofern sie die gleiche Kante betroffen haben. Damit werden die auswertungen vereinfacht.


plot(s1, edge.arrow.size=.4, edge.width=E(s1)$weight, layout=layout_with_kk, main="Beispiel Studierende", sub="KK-Algorithmus, Gewicht der Beziehung")

###

# Zentralitätsmaße berechnen

# berechnet den Degree-Wert für alle Knoten und weist ihm die Variable "dh" zu.
dh <- degree(s)
dh

# plottet da Netzwerk und ändert die Größe des Knotens nach dem Degree-Wert
plot(s, vertex.size=dh, vertex.label=NA, edge.arrow.size=.2, main="Degree-Verteilung")

# auch hier lassen sich die angegebenen numerischen Werte des Degrees leicht verändern, in diesem Fall mit dem Faktor 1.5
plot(s, vertex.size=dh*1.5, vertex.label=NA, edge.arrow.size=.2, main="Degree-Verteilung vergrössert")

# Jetzt interessieren uns aber die Indegrees, da wir ja herausfinden wollen, wer am meisten um Rat gefragt wird
inh <- degree(s, mode = "in")
inh
plot(s, vertex.size=inh*1.5, vertex.label=NA, edge.color="darkgrey", edge.arrow.size=.2, main="Indegree")

###
