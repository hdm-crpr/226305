# Skript Visualisierungsparameter in R verstehen
# Blockseminar 226305, Tag 3
# Swaran Sandhu, sandhu@hdm-stuttgart.de
# Inspiriert von: http://www.r-graph-gallery.com/248-igraph-plotting-parameters/ und http://kateto.net/network-visualization

# generelle Erklärung der Attribute hier:
# http://www.r-graph-gallery.com/248-igraph-plotting-parameters/
# siehe für Beispiele auch:
# http://michael.hahsler.net/SMU/LearnROnYourOwn/code/igraph.html
# Für Fortgeschrittene (mit neuen Paketen):
http://www.sthda.com/english/articles/33-social-network-analysis/135-network-visualization-essentials-in-r/

# In diesem Skript lernen Sie an einem praktischen Beispiel, wie man Visualisierungsparameter in R anlegt und Netzwerk ästhetisch schön visualisiert. Wir verwenden dafür einen Datensatz von 38 Studierenden, der auf github hinterlegt ist. Die Dateien können direkt aus github eingelesen werden, deshalb müssen Sie diese nicht extra als edgelist herunterladen.
# bitte unbedingt auch das Codebuch lesen
#  https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd

# libraries laden
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

s <- s1 # überschreibt das alte igraph-objekt s mit dem aufaddierten

# Achtung: unbedingt prüfen, ob Sie den simplifiy-Befehl auch einsetzen können. Dafür brauchen Sie entsprechende numerische weights in ihrem Netzwerk.

# ruft das finale igraph-Objekt auf.
s

# wir verwenden nachfolgend für das igraph-Objekt "s".

# PRO-TIPP: Sie können das Skript einfach übernehmen, indem sie Ihr igraph-Objekt ebenfalls "s" als variable zuweisen. Dann kann das Skript direkt eingelesen werden. Achten Sie aber bitte immer auf die richtigen Bezüge auf die jeweiligen Objekte und passen Sie auf, dass die Netzwerke nicht doppelt benannt werden.
# !!! die edge- und vertex.attributes unterscheiden sich natürlich und müssen angepasst werden!!!


# VISUALISIERUNGSPARAMETER festlegen

# Übersicht über die Edge- und Vertex-Attribute
summary(s)
edge_attr(s)
vertex_attr(s)

# Die Werte sind alle numerisch gesetzt. Die Erklärung der Werte findet sich in der Codierung.

# der Standard-Plot eines Netzwerks sieht in igraph meist wenig ansprechend aus.
plot(s)

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

E(s)$arrow.size <- .2 # definiert die Pfeilspitze auf 20% des Ursprungswerts
E(s)$color="black" # definiert die Kantenfarbe auf schwarz
E(s)$width <- E(s)$weight # definiert die Kantenstärke nach dem hinterlegten Gewicht, sofern dieses vorhanden ist.

# Mit den Befehlen haben Sie die Edge-Attribute um 3 neue Werte ergänzt. Diese sind nun dauerhaft im igraph-Objekt hinterlegt.
list.edge.attributes(s)

plot(s, layout = layout_with_fr)
# generiert den neuen Plot mit dem Layout nach Fruchterman-Rheingold. Bitte beachten: Fruchterman-Rheingold berechnet das Netzwerk jedes Mal neu.

# Die Variablen können auch leicht manipuliert werden, falls etwa das Gewicht noch wenig stärker visualisiert werden soll, können die Werte einfach umgeschrieben werden.
E(s)$width <- E(s)$weight*2 # multipliziert die Gewicht mit dem Faktor 2, daher werden diese auch stärker visualisiert werden.
E(s)$color="red" #setzt die Farbe rot für Kanten
E(s)$curved=.2 #leicht gebogenen Kanten für eine bessere Lesbarkeit.

plot(s)

# VERTEX/KNOTEN-Attribute festlegen

# Keine Labels der Knoten anzeigen
V(s)$label <- NA # überschreibt alle Labels mit dem Wert "NA", der nicht angezeigt wird.
plot(s)

# Labels wiederherstellen

vertex_attr(s)
V(s)$label <- V(s)$name
# weist dem Vertex-Attribut "label" wieder das Vertex-Attribut "name" zu.
plot(s)

E(s)$color="black" #setzt die Farbe wieder auf schwarz für Kanten
plot(s)

# EINFÄRBEN aufgrund von Vertex-Attributen

# Im Netzwerk sind Männer und Frauen abgelegt, die über das Vertex.Attribut $sex mit "1" (weiblich) oder "2" (männlich) kodiert sind.
vertex.attributes(s)$sex

#Alle Männer sollen nun mit der Farbe blau und alle Frauen mit der Farbe rot visualisiert werden.

#FARBEN nach Vertex-Attributen definieren
colrs <- c("blue", "yellow")

#definiert das Farbspektrum, der verwendeten Farben und legt diese in einem neuen Vector colrs fest. Da wir wissen, dass wir bei §sex nur zwei Werte haben (männlich, weiblich) brauchen wir auch zwei Werte. Die direkten Farbpaletten sind hier hinterlegt: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf.

V(s)$color <- colrs[V(s)$sex]
# weist dem Vertex-Attribut color die Funktion colrs zu, die wir vorher mit zwei Farben definiert haben.
plot(s)

# Juhu, wir können Männer und Frauen unterscheiden. Die Sortierung der Farben ist numerisch an die Reihenfolge des Attributs angelegt. Diese lassen sich dann leicht tauschen.

# Alternativ lassen sich auch Farbverläufe definieren, https://www.r-bloggers.com/color-palettes-in-r/
col=heat.colors(2)
V(s)$color <- col[V(s)$sex]
plot(s)

# Die Farbverläufe werden aber erst interessant, wenn eine Skala von mehr als drei Werten visualisiert wird.

# KNOTEN/VERTEX-FORM ändern.
# Wie jedes andere Attribut lässt sich auch die Form des Knotens ändern. In diesem Fall wollen wir, dass alle Raucher V(h)$smoke als Quadrat dargestellt werden.

V(s)$shape = "circle"
# definiert, dass alle Knoten als Kreis auftreten

smokers <- V(s)[smoke == "2"]
# wöhlt alle Knoten aus, die das Vertex-Attribut "2" bei $smoke gesetzt haben

smokers

V(s)[smokers]$shape = "square"
# weist allen Werten von Smokers den Shape "square" zu.

plot(s)

# EXTRA: TWO-MODE Netzwerke (bi-partite)
# bei einem bi-partite Netzwerk haben Sie in der Regel die Rubrik "type" angelegt und mit 0 und 1 kodiert. Damit könnten Sie das Netzwerk wie folgt visualisieren (funktioniert in unserem Beispiel nicht, da wir kein bi-partite Netzwerk angelegt haben.)

V(s)[V(s)$type == 1]$shape <- "square"
V(s)[V(s)$type == 0]$shape <- "circle"
plot(s)

# Wir könnten aber ein anderes dichotomes Attribut auswählen und danach das Netzwerk strukturieren:

vertex_attr(s)
V(s)[V(s)$tatoo == 1]$shape <- "circle"
V(s)[V(s)$tatoo == 2]$shape <- "rectangle"
plot(s)


# Übung 1
# Visualisieren Sie das oben angelegte Hilfsnetzwerk farblich nach folgender Frage: "Wer arbeitet am meisten in einer Vertiefungsrichtung?"

# Tipp: Überlegen Sie zunächst, welche Variable für die größere Anzahl im Netzwerk gilt. Selektieren Sie dann die zweite Form danach.

# ///

# Übung 1: Lösung
# setzt wieder alle Knoten zurück
V(s)$shape = "circle"

col= rev(heat.colors(4)) # definiert 4 Farben von der Heat.Colors-Palette, dreht Farbskala um
V(s)$color <- col[V(s)$job] # weist den Vektor col auf die Werte 1 bis 4 von Job zu
plot(s)

# LEKTION 2: Relative Größen im Netzwerk abbilden.

# Im Skript wurden bislang die Werte überschrieben, deshalb hat das Netzwerk bereits eine bestimmte Formatierung. Wir setzen jetzt alle Werte wieder zurück:

E(s)$arrow.size <- .2 # definiert die Pfeilspitze auf 2
E(s)$color="grey60" # definiert die Kantenfarbe auf schwarz
E(s)$width <- E(s)$weight
E(s)$curved=.2
V(s)$shape = "circle"
V(s)$color = "orange"
plot(s)

# VERTEX LABELS schöner machen

vertex.label.dist=2 # gibt an, wie weit der Label vom Knoten entfernt platziert werden soll
vertex.label.degree=0 # gibt an, in welchem Winkel der Label zum Knoten gesetzt wird
vertex.label.cex=.8 # gibt die Größe des Labels an
vertex.label.family="Helvetica" # gibt die Schriftart des Knotens an
vertex.label.font=2 # gibt an, welcher Schriftschnitt verwendet wird.
plot(s)

# Beispiel Netzwerk mit schöneren Vertex-labels visualisieren

plot(s,
     vertex.size=degree(s)*1.5,
     vertex.color="lightblue",
     vertex.frame.color="white",
     edge.arrow.size=.2,
     edge.curved=.2,
     vertex.label.dist=3,
     vertex.label.degree=0,
     vertex.label.cex=.5,
     vertex.label.family="Helvetica",
     vertex.label.font=2,
     vertex.label.color="black",
     main="Beispiel für Anpassung der Labels des Knoten")

# EDGES schöner machen

# Welche Argumente machen Kanten schöner:
edge.arrow.size=.2 # Größe der Pfeilspitzen
edge.curved=.2 # Krümmung der Kanten
edge.color="red" # Farbe der Kanten
edge.width=E(s)$weight # Gewicht der Kanten nach Edge-Attribut "weight"
edge.label=E(s)$weight # falls es Labels gibt, können diese nach den Kantenattributen abgerufen werden
edge.label.color="black" # Farbe der Kantenlabels
edge.label.cex=.8 # Größe der Kantenlabels
edge.label.family="Helvetica" # Schriftart der Kantenlabels

# Beispiel
plot(s,
     edge.arrow.size=.2,
     edge.curved=.2,
     edge.color="grey",
     edge.width=E(s)$weight,
     vertex.shape="circle",
     vertex.color="red",
     vertex.size=".5",
     vertex.label=NA,
     edge.label=E(s)$weight,
     edge.label.color="black",
     edge.label.degree=0,
     edge.label.cex=.8,
     edge.label.family="Helvetica",
     edge.label.font=1,
     main="Beispiel für die Kantenvisualisierung")

# TITEL und Untertitel hinzufügen
# Einfach im Plot Befehl main und sub ergänzen
plot(s, main="Studentennetzwerk n=38", sub="Erhebung WS 2017")

# Schriften und Größen manipulieren
title("Studentennetzwerk n=38", cex.main = 1, font.main= 4, col.main= "blue")


# Akteursmaße (positionale Maße) visualisieren
# Bislang haben wir nur Attribute direkt visualisiert, die direkt in den Node- und Edge-Attributen angelegt sind. Richtig spannend wird die Untersuchung aber erst, wenn wir mit Akteursmaßen wie etwa Zentralitätsmaßen arbeiten.

# SELEKTION und VERGLEICH von zwei Teilnetzwerken
# wir wollen das Hilfesuche (help) und Projektarbeitsnetzwerk (work) vergleichen. Deshalb müssen wir das Netzwerk erst noch in zwei separate Netzwerke aufteilen:

# Netzwerk neu einlesen

el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")
eties <-as.matrix(el)
s_all <- graph_from_data_frame(d=eties, vertices=nodes, directed=T)
# das igraph-Objekt heisst jetzt "s_all" für das Gesamtnetzwerk
s_all

# Selektion in Teilnetzwerk w (work) und h (help)
edge.attributes(s_all)
edge.attributes(s_all)$relation
# das edge attribut relation ist in 6 und 7 kodiert.
# 6 ist das Arbeitsnetzwerk (Projektarbeit), 7 das Hilfsnetzwerk (Ratsuche)

w <- subgraph.edges(s_all, E(s_all)[relation == 6])
w
edge.attributes(w)$relation
plot(w, edge.arrow.size=0.1, main="Arbeitsnetzwerk")

h <- subgraph.edges(s_all, E(s_all)[relation == 7])
h
edge.attributes(h)$relation
plot(h, edge.arrow.size=0.1, main="Hilfsnetzwerk")

# direkter Vergleich der beiden Netzwerke herstellen

par(mfrow=c(1,2), mar=c(0,0,2,0))
plot(w, layout = layout_with_kk, edge.arrow.size=0.1, main="Arbeitsnetzwerk")
plot(h, layout = layout_with_kk, edge.arrow.size=0.1, main="Hilfsnetzwerk")

# Die Netzwerke könnnen noch verfeinert werden, indem Sie entweder den simplify Befehl auf die Netzwerke anwenden, oder nur die starken Beziehungen analysieren (weight=3). Alternativ können Sie auch weitere Variablen für die Analyse heranziehen, wie etwa Geschlecht, Alter, etc.

# Relative Werte durch die Größe der Knoten abbilden

# berechnet den Degree-Wert für alle Knoten und weist ihm die Variable "dh" zu.
ds <- degree(s)
ds

# plottet da Netzwerk und ändert die Größe des Knotens nach dem Degree-Wert
par(mfrow=c(1,1))
plot(s, vertex.size=ds, vertex.label=NA, main="Visualisierung mit Degree-Werten", sub="n=38, mode=all")


# VERGLEICH von Netzwerken
# Wenn Sie Netzwerke vergleichen wollen, sollten Sie den Kamada-Kawai Algorithmus verwenden: layout = layout_with_kk. Der Algorithmus definiert die Knoten immer an der gleichen Stelle. So können Sie Veränderungen leichter sehen.

# auch hier lassen sich die angegebenen numerischen Werte des Degrees leicht verändern, in diesem Fall mit dem Faktor 1.5
plot(s, vertex.size=ds*1.5, vertex.label=NA)

# Jetzt interessieren uns aber die Indegrees, da wir ja herausfinden wollen, wer am meisten um Rat gefragt wird
ins <- degree(s, mode = "in")
ins
plot(s, layout = layout_nicely, vertex.size=ins*1.5, vertex.label=NA, edge.color="darkgrey", main="Wer wird am meisten um Rat gefragt?")

# SCHÖNE Visualisierung
# Farblicher Verlauf eines relativen Größenwerts von Knoten

el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")
eties <-as.matrix(el)
s <- graph_from_data_frame(d=eties, vertices=nodes, directed=T)



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
V(s)$color <- col[ins]
plot(s, vertex.size=ins*3, vertex.label=ins, edge.color="grey", edge.arrow.size=.1)

# Das klappt schon ganz gut, nur passen die Skala der Indegrees (von 0 bis 13) und die der Farbwerte noch nicht zusammen.

# gibt an, wie viele Schritte die Farbskala haben soll
fine = 13

# legt die Farbskala fest
palette = colorRampPalette(c('yellow','red'))

# definiert die Farbskala auf die Werte
graphCol = palette(fine)[as.numeric(cut(inh, breaks = fine))]

# Plot mit Farbe nach dem Indegree-Wert
plot(s, vertex.color=graphCol)

# Plot mit Farbe und Größe nach dem Indegree-Wert mit indegree-Wert als Beschriftung
plot(s, vertex.color=graphCol, vertex.size=ins*2, vertex.label=ins)

# Ergänzung: zur besseren Verständlichkeit sollten alle Zentralitätswerte normalisiert werden, d.h. auf Werte von 0 bis 1 umgerechnet werden. Das erleichtert dann die Visualisierung und die Vergleichbarkeit von Netzwerken. Das Skript sieht dann wie folgt aus:

ins <- degree(s, mode = "in", normalized = TRUE)
fine = 10
palette = colorRampPalette(c('lightblue','darkblue'))
graphCol = palette(fine)[as.numeric(cut(inh, breaks = fine))]

# der folgende Plot ist um einige weitere Visualisierungsparameter ergänzt
plot(s,
     vertex.color=graphCol,
     vertex.label=NA,
     vertex.frame.color = "white",
     edge.color="lightblue",
     edge.arrow.size=.3,
     main = "Wer wird um Rat gefragt? (n=38)",
     sub = "Visualisierung nach normalisierter Indegree-Verteilung")

# ÜBUNG: Berechnen Sie die betweenness des Netzwerks s und visualisieren Sie die betweeness Maße auf durch die Größe der Knoten. Geben Sie ihrem Netzwerk eine Überschrift. Was fällt Ihnen im Gegensatz zu dem Degree Netzwerk auf?
# Tipp: Befehl ??betweenness

bs <- betweenness(s, v = V(s),
                  directed = TRUE,
                  weights = NULL,
                  nobigint = TRUE,
                  normalized = TRUE)
bs

plot(s,
     vertex.size=bs*100,
     edge.arrow.size=.2,
     main="Verteilung Betweenness im Netzwerk")

# UNTERGRUPPEN im Netzwerk visualisieren

degree(s, mode="in")

# Wir wissen, dass Knoten 18 am meisten indegrees hat, nämlich 15. Wir wollen jetzt das direkte Netzwerk des Knoten 18 sehen und zwar alle direkten Verbindungen zum Knoten. Dazu verwenden wir den Befehl make_ego_graph.
in_king <- make_ego_graph(s,
                          order = 1,
                          nodes = V(s)$name == 18,
                          mode ="in")

plot(in_king[[1]],
     edge.arrow.size=.2,
     edge.curved=.2,
     main="Der oder die Ratsuche-Königin",
     sub="Ego-Netzwerk des Knotens mit den höchsten Indegrees im Netzwerk")

# jetzt interessieren uns alle Verbindungen der zweiten Ordnung, d.h. es Knoten, die über maximal 2 Schritte mit dem Knoten 18 verbunden sind.
in_king2 <- make_ego_graph(s,
                           order = 2,
                           nodes = V(s)$name == 18,
                           mode ="in")
plot(in_king2[[1]],
     edge.arrow.size=.2,
     edge.curved=.2,
     main="Der oder die Ratsuche-Königin, 2. Ordnung",
     sub="Ego-Netzwerk des Knotens mit den höchsten Indegrees im Netzwerk")

# LEKTION 4: mit dem richtigen Algorithmus visualisieren
# igraph kommt mit einem großen Paket an eingebauten Algorithmen. Doch nicht alle eignen sich gleichermaßen gut für die Visualisierung des Netzwerks. Die hier genannten Algorithmen funktionieren am besten bis ca. 60 Knoten.

# setzt Werte zurück (oder Datei neu einlesen, d.h. Code hierher kopieren)
E(s)$arrow.size <- .2
E(s)$color="grey"
E(s)$width <- E(h)$weight
E(s)$curved=.2

V(s)$shape = "circle"
V(s)$color = "orange"
plot(s)

# visualisierung nach degrees
sd <- degree(s, mode = "all")
fine = 4
palette = colorRampPalette(c('lightblue','blue'))
iblue = palette(fine)[as.numeric(cut(inh, breaks = fine))]

V(s)$size = sd
V(s)$color = iblue
V(s)$label = NA

plot(s, main="Visualisierung nach Degrees in blau")

# Beispiel für eine Visualisierung von vier unterschiedlichen Algorithmen
# Die Layout-Funktion layout = greift auf unterschiedlich vorgefertige Layouts zurück, die entsprechende Visualisierungen erzeugen.

plot(s, layout = layout_with_kk)

# legt fest, dass die Visualisierung in einer Tabelle von 2x2 Feldern definiert werden
par(mfrow=c(2,2), mar=c(0,0,2,2))

# definiert unterschiedliche Algorithmen
plot(s, layout=layout_with_fr, main="Fruchterman-Rheingold")
plot(s, layout=layout_nicely, main="Nicely")
plot(s, layout=layout_with_graphopt, main="Graphhopt")
plot(s, layout=layout_with_gem, main="GEM")

# LEKTION 5: Legende angeben

# Tite und Untertitel des Plots festlegen
# Hauptlegende wird in der Funktion plot() über das Argument title="Mein Titel" definiert.

# Beispiel 1
par(mfrow=c(1,1))
plot(s,layout=layout_nicely, main="Layout nicely", sub="Test Algorithmus")
# Anpassung Schriftgröße: cex.main= numerischer Wert
# Anpassung Schriftfarbe: col.main="Farbe aus R-Farbpalette"

# Alternative: Visualisierung über die Funktion title()
# Hier wird der Titel nachträglich einem Graphen hinzugefügt
par(mfrow=c(1,1))
plot(s,layout=layout_nicely)
title("Mein Titel",cex.main=2,col.main="blue")

# Problem: Visualisierung ist abgeschnitten:
# muss ich noch lösen!

# Definieren Sie den äußeren Rand auf 2
par(oma=c(0,0,2,2))
plot(s,layout=layout_nicely, main="Layout nicely", adj = 0.5, line = -2)

# Legende anfügen
# tbc
