### Tutorium 13-6-2018
### Ego-Netzwerke, Transitivität, Cliques

library(igraph)
library(igraphdata)

## Ego-Netzwerke
# Wir arbeiten  mit dem karate Netzwerk aus dem igraphdata Paket.

data(karate)
karate
plot(karate)

vertex_attr(karate)

# Wir wollen das Ego-Netzwerk von "H", also Mr Hi, beobachten.

EgoMRHi <- make_ego_graph(karate, order=1, nodes=V(karate)$label=="H", c("all"))
plot(EgoMRHi[[1]], vertex.color="grey70", edge.color = "pink3", vertex.label.color="black", vertex.frame.color="transparent", edge.arrow.size=0.1, layout=layout_with_kk)


## Transitivität (auch: Clusterkoeffizient genannt!)
# Dieser Wert gibt Aufschluss darüber, wie wahrscheinlich es ist, dass zwei Knoten, die jeweils eine Verbindug zu einem dritten Knoten haben, auch zueinander in Verbindung stehen.
# Mathematisch ausgedrückt sagt es etwas über das Verhältnis von Dreiecken zu verbundenen Tripeln aus, wobei in einem Dreieck immer drei Tripel sind. Berechnet wird die globale Transitivität also mit (3xAnzahl Dreiecke / Anzahl verbundene Triple)

# Man kann den Transitivitätswert für den gesamten Graphen bestimmen. Ein hoher Wert kann bspw. auf das „Kleine Welt Phänomen“ hindeuten (Wenn eine Person zwei Leute kennt, kennen die sich auch.)

transitivity(karate, type=c("global"))

# Achtung: Bei gerichteten Graphen wird die Richtung der Kanten ignoriert! Zudem ist eine globale Berechnung nur sinnvoll bei dichten Netzwerken.


# Man kann den Transitivitätswert auch für einzelne Knoten bestimmen.

transitivity(karate, type=c("local"), vids=NULL)

# Der lokale Transitivitätswert ist der Quotient der Anzahl der Kanten, die zwischen seinen Nachbarn verlaufen geteilt durch die Anzahl der Kanten, die maximal zwischen seinen Nachbarn verlaufen können. Steht im Bruch oben und unten also die maximale Zahl, sind alle Beziehungen ausgeschöpft und der Knoten hat die höchste Transitivität, 1.


## Cliques
# Mit diesem Befehl könnt ihr festlegen, was für Cliquen ihr anschauen wollt. Bei min und max legt ihr die minimale und maximale Anzahl der beteiligten Knoten fest.

cliques(karate, min="3", max="3")

# Maximal 1000 Ergebnisse können in der Konsole angezeigt werden. Ist also nur hilfreich bei kleineren Netzwerken.

# Eine „largest Clique“ ist die Clique, die die meisten Knoten beinhaltet.

largest_cliques(karate)

# Eine „max Clique“ ist eine Clique, die nicht mehr zu einer größeren Clique erweitert werden kann. Das bedeutet, dass man keinen weiteren Knoten einfügen kann, der zu allen anderen eine Verbindung hat.

max_cliques(karate)

# Achtung: Alle large cliques sind max cliques, die max cliques sind aber nicht zwingend large cliques!
