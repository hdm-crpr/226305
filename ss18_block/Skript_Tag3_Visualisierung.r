# Skript Visualisierungsparameter in R verstehen
# Swaran Sandhu, sandhu@hdm-stuttgart.de
# Inspiriert von: http://www.r-graph-gallery.com/248-igraph-plotting-parameters/ und http://kateto.net/network-visualization

# generelle Erklärung der Attribute hier: http://www.r-graph-gallery.com/248-igraph-plotting-parameters/
# siehe für Beispiele auch: http://michael.hahsler.net/SMU/LearnROnYourOwn/code/igraph.html
# Für Fortgeschrittene (mit neuen Paketen): http://www.sthda.com/english/articles/33-social-network-analysis/135-network-visualization-essentials-in-r/

# In diesem Skript lernen Sie an einem praktischen Beispiel, wie man Visualisierungsparameter in R anlegt und Netzwerk ästhetisch schön visualisiert. Wir verwenden dafür einen Datensatz von 38 Studierenden, der auf github hinterlegt ist. Die Dateien können direkt aus github eingelesen werden, deshalb müssen Sie diese nicht extra als edgelist herunterladen.

# libraries laden
setwd("~/Desktop/kurs")
library(igraph)

# igraph-Objekt erstellen
# Die Erklärung des Datensatzes und der Codierung finden Sie unter https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/codierung.rmd

library(igraph)

# liest die Dateien direkt aus dem github-Verzeichnis ein
help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/nodes.csv", header=T, as.is=T, sep = ",")

# prüft, ob alle Variablen eingelesen wurden
head(help)
head(nodes)

# wandelt die edgelist in eine Matrix um und baut das igraph-Objekt
hties <-as.matrix(help)
help <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)

help

# addiert edges auf, wenn sie auf der gleichen Beziehung sind
h <- simplify(help, edge.attr.comb = list(weight="sum"))

# ruft das finale igraph-Objekt auf.
h

# wir verwenden nachfolgend für das igraph-Objekt "h".

# PRO-TIPP: Sie können das Skript einfach übernehmen, indem sie Ihr igraph-Objekt ebenfalls "h" als variable zuweisen. Dann kann das Skript direkt eingelesen werden. Achten Sie aber bitte immer auf die richtigen Bezüge auf die jeweiligen Objekte und passen Sie auf, dass die Netzwerke nicht doppelt benannt werden.


# VISUALISIERUNGSPARAMETER festlegen

#Übersicht über die Edge- und Vertex-Attribute
summary(h)
edge_attr(h)
vertex_attr(h)

# Die Werte sind alle numerisch gesetzt. Die Erklärung der Werte findet sich in der Codierung.

# der Standard-Plot eines Netzwerks sieht in igraph meist wenig ansprechend aus.
plot(h)

# Übersicht über alle Visualisierungsparameter
?igraph.plotting

# Logik der Visualisierung

# LEKTION 1. Vergabe von festen Visualisierungsparametern für edge- und vertex-Attribute. diese werden einmal angelegt und dann von jedem plot übernommen. Beispielsweise Farbe oder Form von Knoten und Kanten, z.B. alle weiblichen Knoten sollen ein Kreis sein, alle männlichen Knoten ein Dreieck (vertex.shape).

# LEKTION 2. Relative Bezüge zwischen Knoten und Kanten visualisieren. Sollen z.B. bestimmte Netzwerk- oder Akteurseigenschaften nach bestimmten Parametern wie etwa dem Degree-Wert visualisiert werden, müssen diese Werte zunächst berechnet und dann einer Visualisierung zugewiesen werden. Meistens fügen wir dazu ein neues edge- oder vertex-Attribut an.

# LEKTION 3. Kombination von festen Zuweisungen und relativen Bezügen, z.B. sollen alle Knoten nach dem Indegree visualisiert werden (je größer der Knoten, desto höher der indegree) und zugleich farblich abgestuft visualisiert werden. Das ist schon anspruchsvoller, weil wir hier a) zunächst die Werte in eine Ordnung bringen müssen (z.B. von klein nach groß) und zugleich b) die Skala der Farbabstufung entsprechend der Abstufung anpassen müssen.

# LEKTION 4. Den richtigen Algorithmus auswählen. Viele Algorithmen visualisieren ihr Netzwerk unterschiedlich. Deshalb ist es notwendig, den richtigen Algorithmus festzulegen.

# LEKTION 5. Titel und Legende festlegen, damit das Netwerk gut verständlich ist.

## LEKTION 1: FESTE VISUALISIERUNGSPARAMETER
# Da hier feste Parameter für die Visualisierung des Netzwerks angelegt werden, bleiben diese erhalten bzw. es gilt der letzte gesetzte Befehl. Dieser kann nur rückgängig gemacht werden, wenn er wieder durch einen neuen ersetzt wird. Es gilt immer der letzte Befehl.

# PRO-TIPP: definieren Sie die Parameter, die ihnen gefallen in einem Skript, dann müssen Sie diese nur einmal zu Beginn einer Visualisierung festlegen.

# EDGE/KANTEN-Attribute festlegen
# kleinere und schönere Kanten mit Pfeilspitzen mit Gewichten

E(h)$arrow.size <- .2 # definiert die Pfeilspitze auf 2
E(h)$color="black" # definiert die Kantenfarbe auf schwarz
E(h)$width <- E(h)$weight # definiert die Kantenstärke nach dem hinterlegten Gewicht, sofern dieses vorhanden ist.

plot(h, layout = layout_with_fr) # generiert den neuen Plot mit dem Layout nach Fruchterman-Rheingold. Bitte beachten: Fruchterman-Rheingold berechnet das Netzwerk jedes Mal neu.

# Die Variablen können auch leicht manipuliert werden, falls etwa das Gewicht noch wenig stärker visualisiert werden soll, können die Werte einfach umgeschrieben werden.
E(h)$width <- E(h)$weight*2 # multipliziert die Gewicht mit dem Faktor 2, daher werden diese auch stärker visualisiert werden.
E(h)$color="red" #setzt die Farbe rot für Kanten
E(h)$curved=.2 #leicht gebogenen Kanten für eine bessere Lesbarkeit.

plot(h)

# VERTEX/KNOTEN-Attribute festlegen

# Keine Labels der Knoten anzeigen
V(h)$label <- NA # überschreibt alle Labels mit dem Wert "NA", der nicht angezeigt wird.
plot(h)
# Labels wiederherstellen
V(h)$label <- V(h)$name # weist dem Vertex-Attribut "label" wieder das Vertex-Attribut "name" zu.
plot(h)

# Im Netzwerk sind Männer und Frauen abgelegt, die über das Vertex.Attribut $sex mit "1" (weiblich) oder "2" (männlich) kodiert sind. Alle Männer sollen nun mit der Farbe blau und alle Frauen mit der Farbe rot visualisiert werden.

#FARBEN nach Vertex-Attributen definieren
colrs <- c("pink", "lightblue")
#definiert das Farbspektrum, der verwendeten Farben und legt diese in einem neuen Vector colrs fest. Da wir wissen, dass wir bei §sex nur zwei Werte haben (männlich, weiblich) brauchen wir auch zwei Werte. Die direkten Farbpaletten sind hier hinterlegt: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf.
V(h)$color <- colrs[V(h)$sex]
# weist dem Vertex-Attribut color die Funktion colrs zu, die wir vorher mit zwei Farben definiert haben.
plot(h)
# Juhu, wir können Männer und Frauen unterscheiden. Die Sortierung der Farben ist numerisch an die Reihenfolge des Attributs angelegt. Diese lassen sich dann leicht tauschen.

# Alternativ lassen sich auch Farbverläufe definieren, https://www.r-bloggers.com/color-palettes-in-r/
col=heat.colors(2)
V(h)$color <- col[V(h)$sex]
plot(h)
# Die Farbverläufe werden aber erst interessant, wenn eine Skala von mehr als drei Werten visualisiert wird.

# KNOTEN-FORM ändern.
# Wie jedes andere Attribut lässt sich auch die Form des Knotens ändern. In diesem Fall wollen wir, dass alle Raucher V(h)$smoke als Quadrat dargestellt werden.

V(h)$shape = "circle"
#definiert, dass alle Knoten als Kreis auftreten

smokers <- V(h)[smoke == "2"]
# wöhlt alle Knoten aus, die das Vertex-Attribut "2" bei $smoke gesetzt haben

V(h)[smokers]$shape = "square"
# weist allen Werten von Smokers den Shape "square" zu.

plot(h)

# EXTRA: TWO-MODE Netzwerke (bi-partite)
# bei einem bi-partite Netzwerk haben Sie in der Regel die Rubrik "type" angelegt und mit 0 und 1 kodiert. Damit könnten Sie das Netzwerk wie folgt visualisieren (funktioniert in unserem Beispiel nicht, da wir kein bi-partite Netzwerk angelegt haben.)

V(h)[V(h)$type == 1]$shape <- "square"
V(h)[V(h)$type == 0]$shape <- "circle"
plot(h)

#Wir könnten aber ein anderes dichotomes Attribut auswählen und danach das Netzwerk strukturieren:

vertex_attr(h)
V(h)[V(h)$tatoo == 1]$shape <- "circle"
V(h)[V(h)$tatoo == 2]$shape <- "rectangle"
plot(h)



# ÜBUNG
# Visualisieren Sie das oben angelegte Hilfsnetzwerk farblich nach folgender Frage: "Wer arbeitet am meisten in einer Vertiefungsrichtung?"
# Tipp: Überlegen Sie zunächst, welche Variable für die größere Anzahl im Netzwerk gilt. Selektieren Sie dann die zweite Form danach.

# LEKTION 2: Relative Größen im Netzwerk abbilden.

# Im Skript wurden bislang die Werte überschrieben, deshalb hat das Netzwerk bereits eine bestimmte Formatierung. Wir setzen jetzt alle Werte wieder zurück:

E(h)$arrow.size <- .2 # definiert die Pfeilspitze auf 2
E(h)$color="grey60" # definiert die Kantenfarbe auf schwarz
E(h)$width <- E(h)$weight
E(h)$curved=.2
V(h)$shape = "circle"
V(h)$color = "orange"
plot(h)

# VERTEX LABELS schöner machen
vertex.label.dist=2 # gibt an, wie weit der Label vom Knoten entfernt platziert werden soll
vertex.label.degree=0 # gibt an, in welchem Winkel der Label zum Knoten gesetzt wird
vertex.label.cex=.8 # gibt die Größe des Labels an
vertex.label.family="Helvetica" # gibt die Schriftart des Knotens an
vertex.label.font=2 # gibt an, welcher Schriftschnitt verwendet wird.

# Beispiel Netzwerk mit schöneren Vertex-labels visualisieren

plot(h, vertex.size=degree(h)*1.5, vertex.color="lightblue", vertex.frame.color="white", edge.arrow.size=.2, edge.curved=.2, vertex.label.dist=2, vertex.label.degree=0, vertex.label.cex=.8, vertex.label.family="Helvetica", vertex.label.font=2, vertex.label.color="blue", main="Beispiel für Anpassung der Labels des Knoten")

# EDGES schöner machen
edge.arrow.size=.2, # Größe der Pfeilspitzen
edge.curved=.2, # Krümmung der Kanten
edge.color="red" # Farbe der Kanten
edge.width=E(h)$weight # Gewicht der Kanten nach Edge-Attribut "weight"
edge.label=E(h)$weight # falls es Labels gibt, können diese nach den Kantenattributen abgerufen werden
edge.label.color="black" # Farbe der Kantenlabels
edge.label.cex=.8 # Größe der Kantenlabels
edge.label.family="Helvetica" # Schriftart der Kantenlabels

# Beispiel
plot(h, edge.arrow.size=.2, edge.curved=.2, edge.color="red", edge.width=E(h)$weight, vertex.shape="none", vertex.label=NA, edge.label=E(h)$weight, edge.label.color="black", edge.label.degree=0, edge.label.cex=.8, edge.label.family="Helvetica", edge.label.font=1, main="Beispiel für die Kantenvisualisierung")

# TITEL und Untertitel hinzufügen
# Einfach im Plot Befehl main und sub ergänzen
plot(h, main="Unterstützungsnetzwerk n=38", sub="Erhebung WS 2017")

# Schriften und Größen manipulieren
title("Unterstützungsnetzwerk n=38", cex.main = 1, font.main= 4, col.main= "blue")


# Bislang haben wir nur Attribute direkt visualisiert, die direkt in den Node- und Edge-Attributen angelegt sind. Richtig spannend wird die Untersuchung aber erst, wenn wir mit Akteursmaßen wie etwa Zentralitätsmaßen arbeiten.

# Relative Werte durch die Größe der Knoten abbilden

# berechnet den Degree-Wert für alle Knoten und weist ihm die Variable "dh" zu.
dh <- degree(h)
dh

# plottet da Netzwerk und ändert die Größe des Knotens nach dem Degree-Wert
plot(h, vertex.size=dh, vertex.label=NA)

# auch hier lassen sich die angegebenen numerischen Werte des Degrees leicht verändern, in diesem Fall mit dem Faktor 1.5
plot(h, vertex.size=dh*1.5, vertex.label=NA)

# Jetzt interessieren uns aber die Indegrees, da wir ja herausfinden wollen, wer am meisten um Rat gefragt wird
inh <- degree(h, mode = "in")
inh
plot(h, vertex.size=inh*1.5, vertex.label=NA, edge.color="darkgrey")

# Farblicher Verlauf eines relativen Größenwerts von Knoten
# hierzu können wir eine Bibliothek mit den vorgegebenen Farbpaletten installieren und laden
install.packages('RColorBrewer')
library('RColorBrewer')
display.brewer.all()

# Mit der Color-Brewer Bibliothek lassen sich schon vorgefertigte Farbverläufe anzeigen. Beispielseweise ist dies ein Farbverlauf für die Farbwelt "blues" mit 12 Abstufungen.
display.brewer.pal(12, "Blues")

# Diese Abstufung kann leicht manipuliert werden, da er durch den Zahlenwert angegeben ist.
display.brewer.pal(4, "Blues") # Vier Abstufungen "blau"
display.brewer.pal(8, "Oranges") # Acht Abstufungen "blau"

# Damit wir die Abstufung der Farbpalette richtig auf die Verteilung der Werte zuordnen können, müssen diese entsprechend sortiert werden

col=heat.colors(13)
V(h)$color <- col[inh]
plot(h, vertex.size=inh*3, vertex.label=inh)

# Das klappt schon ganz gut, nur passen die Skala der Indegrees (von 0 bis 13) und die der Farbwerte noch nicht zusammen.

# gibt an, wie viele Schritte die Farbskala haben soll
fine = 13

# legt die Farbskala fest
palette = colorRampPalette(c('yellow','red'))

# definiert die Farbskala auf die Werte
graphCol = palette(fine)[as.numeric(cut(inh, breaks = fine))]

# Plot mit Farbe nach dem Indegree-Wert
plot(h, vertex.color=graphCol)

# Plot mit Farbe und Größe nach dem Indegree-Wert mit indegree-Wert als Beschriftung
plot(h, vertex.color=graphCol, vertex.size=inh*2, vertex.label=inh)

# Ergänzung: zur besseren Verständlichkeit sollten alle Zentralitätswerte normalisiert werden, d.h. auf Werte von 0 bis 1 umgerechnet werden. Das erleichtert dann die Visualisierung und die Vergleichbarkeit von Netzwerken. Das Skript sieht dann wie folgt aus:

inh <- degree(h, mode = "in", normalized = TRUE)
fine = 10
palette = colorRampPalette(c('lightblue','darkblue'))
graphCol = palette(fine)[as.numeric(cut(inh, breaks = fine))]

# der folgende Plot ist um einige weitere Visualisierungsparameter ergänzt
plot(h, vertex.color=graphCol, vertex.label=NA, vertex.frame.color = "white", edge.color="lightblue", main = "Wer wird um Rat gefragt? (n=38)", sub = "Visualisierung nach normalisierter Indegree-Verteilung")

# ÜBUNG: Berechnen und visualisieren sie weitere Zentralitätsmaße wie betweeness, eigenvector oder closeness.


# UNTERGRUPPEN im Netzwerk visualisieren

# Wir wissen, dass Knoten 18 am meisten indegrees hat. Wir wollen jetzt das direkte Netzwerk des Knoten 18 sehen und zwar alle direkten Verbindungen
in_king <- make_ego_graph(h, order = 1, nodes = V(h)$name == 18, mode ="all")
plot(in_king[[1]], main="Der oder die Ratsuche-Königin", sub="Ego-Netzwerk des Knotens mit den höchsten Indegrees im Netzwerk")

# jetzt interessieren uns alle Verbindungen der zweiten Ordnung, d.h. es Knoten, die über maximal 2 Schritte mit dem Knoten 18 verbunden sind.
in_king2 <- make_ego_graph(h, order = 2, nodes = V(h)$name == 18, mode ="all")
plot(in_king2[[1]],  main="Der oder die Ratsuche-Königin, 2. Ordnung", sub="Ego-Netzwerk des Knotens mit den höchsten Indegrees im Netzwerk")

# LEKTION 4: mit dem richtigen Algorithmus visualisieren
# igraph kommt mit einem großen Paket an eingebauten Algorithmen. Doch nicht alle eignen sich gleichermaßen gut für die Visualisierung des Netzwerks. Die hier genannten Algorithmen funktionieren am besten bis ca. 60 Knoten.

# setzt Werte zurück
E(h)$arrow.size <- .2
E(h)$color="lightblue"
E(h)$width <- E(h)$weight
E(h)$curved=.2

V(h)$shape = "circle"
V(h)$color = "orange"
plot(h)

# visualisierung nach degrees
hd <- degree(h, mode = "all")
fine = 4
palette = colorRampPalette(c('lightblue','blue'))
iblue = palette(fine)[as.numeric(cut(inh, breaks = fine))]

V(h)$size = hd
V(h)$color = iblue
V(h)$label = NA

plot(h)

# Beispiel für eine Visualisierung von vier unterschiedlichen Algorithmen
# Die Layout-Funktion layout = greift auf unterschiedlich vorgefertige Layouts zurück, die entsprechende Visualisierungen erzeugen.

# VERGLEICH von Netzwerken
# Wenn Sie Netzwerke vergleichen wollen, sollten Sie den Kamada-Kawai Algorithmus verwenden: layout = layout_with_kk. Der Algorithmus definiert die Knoten immer an der gleichen Stelle. So können Sie Veränderungen leichter sehen.


# legt fest, dass die Visualisierung in einer Tabelle von 2x2 Feldern definiert werden
par(mfrow=c(2,2), mar=c(0,0,0,0))

# definiert unterschiedliche Algorithmen
plot(h, layout=layout_with_fr, main="Fruchterman-Rheingold")
plot(h, layout=layout_nicely, main="Nicely")
plot(h, layout=layout_with_graphopt, main="Graphhopt")
plot(h, layout=layout_with_gem, main="GEM")

# LEKTION 5: Legende angeben

# Tite und Untertitel des Plots festlegen
# Hauptlegende wird in der Funktion plot() über das Argument title="Mein Titel" definiert.

Beispiel 1
par(mfrow=c(1,1))
plot(h,layout=layout_nicely, main="Layout nicely", sub="Test Algorithmus")
# Anpassung Schriftgröße: cex.main= numerischer Wert
# Anpassung Schriftfarbe: col.main="Farbe aus R-Farbpalette"

# Alternative: Visualisierung über die Funktion title()
# Hier wird der Titel nachträglich einem Graphen hinzugefügt
par(mfrow=c(1,1))
plot(h,layout=layout_nicely)
title("Mein Titel",cex.main=2,col.main="blue")

# Problem: Visualisierung ist abgeschnitten:
# muss ich noch lösen!
Definieren Sie den äußeren Rand auf 2
par(oma=c(0,0,1,0))
plot(h,layout=layout_nicely, main="Layout nicely", adj = 0.5, line = -2)

# Legende anfügen
# tbc




