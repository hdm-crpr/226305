# Akteursmaße berechnen und visualisieren
# Im Gegensatz zu den Netzwerkmaßen beziehen sich die Akteursmaße auf die Verteilung der Akteure im Netzwerk. Ein wichtiges Maß hierfür sind die unterschiedlichen Zentralitätsmaße. Dies ist auch eine wichtige Kategorie für die Visualisierung des Netzwerks.
# wir verwenden wieder das Netzwerk help zur Berechnung


#5a) Degree (in/out)
# Das Degree-Maß ist das einfachste Zentralitätsmaß. Hier geht es nur darum, wie stark Knoten miteinander vernetzt sind. Das indegree-Maß beschreibt die Anzahl der eingehenden edges, das outdegree-Maß die Anzahl der abgehenden edges eines Knoten.

degree(help, mode = "in")
# berechnet die indgrees des help netzwerks

degree(help, mode = "out")
# berechnet die outdegree des Netzwerks help. Logischerweise sind hier alle Werte auf 2 gesetzt, da jeder Akteur zwei abgehende Beziehungen genannt hat.

plot(help, vertex.size=degree(help, mode="in")*2, edge.arrow.size=.2)
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

plot(works, edge.arrow.size=.2)
plot(helps)
