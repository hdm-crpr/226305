### Tutorium 13-6-2018
### Ego-Netzwerke, Transitivität, Cliques

library(igraph)
library(igraphdata)

## Ego-Netzwerke
# Wir arbeiten  mit dem enron Netzwerk aus dem igraphdata Paket.

data(USairports)
USairports
plot(USairports, vertex.label=V(USairports)$name)

vertex_attr(USairports)

# Wir wollen das Ego-Netzwerk von "Albert Meyers" beobachten.

EgoBGR <- make_ego_graph(USairports, order=1, nodes=V(USairports)$name=="BGR", c("all"))
plot(EgoBGR[[1]], vertex.color="grey70", edge.color = "pink3", vertex.label.color="black", vertex.frame.color="transparent", edge.arrow.size=0.1, layout=layout_with_kk)


## Transitivität (auch: Clusterkoeffizient genannt!)
# Dieser Wert gibt Aufschluss darüber, wie wahrscheinlich es ist, dass zwei Knoten, die jeweils eine Verbindug zu einem dritten Knoten haben, auch zueinander in Verbindung stehen.
# Mathematisch ausgedrückt sagt es etwas über das Verhältnis von Dreiecken zu verbundenen Tripeln aus, wobei in einem Dreieck immer drei Tripel sind. Berechnet wird die globale Transitivität also mit (3xAnzahl Dreiecke / Anzahl verbundene Triple)

# Man kann den Transitivitätswert für den gesamten Graphen bestimmen. Ein hoher Wert kann bspw. auf das „Kleine Welt Phänomen“ hindeuten (Wenn eine Person zwei Leute kennt, kennen die sich auch.) Im Netzwerk USairports geht es natürlich um Flughäfen, da ist das nicht ganz so sinnvoll :)

transitivity(USairports, type=c("global"))

# Achtung: Bei gerichteten Graphen wird die Richtung der Kanten ignoriert! Zudem ist eine globale Berechnung nur sinnvoll bei dichten Netzwerken.


# Man kann den Transitivitätswert auch für einzelne Knoten bestimmen.

transitivity(USairports, type=c("local"), vids=NULL)

# Der lokale Transitivitätswert ist der Quotient der Anzahl der Kanten, die zwischen seinen Nachbarn verlaufen geteilt durch die Anzahl der Kanten, die maximal zwischen seinen Nachbarn verlaufen können. Steht im Bruch oben und unten also die maximale Zahl, sind alle Beziehungen ausgeschöpft und der Knoten hat die höchste Transitivität, 1.


## Cliques
# Mit diesem Befehl könnt ihr festlegen, was für Cliquen ihr anschauen wollt. Bei min und max legt ihr die minimale und maximale Anzahl der beteiligten Knoten fest.

cliques(USairports, min="3", max="3")

# Bei großen Netzwerken wie diesen kommt R kaum mit den Ergebnissen klar :) 25359 unterschiedliche Cliquen mit 3 Knoten werden erkannt, davon können nur 1000 in der Konsole angezeigt werden. Ist also nur hilfreich bei kleineren Netzwerken.

# Eine „largest Clique“ ist die Clique, die die meisten Knoten beinhaltet.

largest_cliques(USairports)

# Eine „max Clique“ ist eine Clique, die nicht mehr zu einer größeren Clique erweitert werden kann. Das bedeutet, dass man keinen weiteren Knoten einfügen kann, der zu allen anderen eine Verbindung hat.

max_cliques(USairports)

# Achtung: Alle large cliques sind max cliques, die max cliques sind aber nicht zwingend large cliques!
