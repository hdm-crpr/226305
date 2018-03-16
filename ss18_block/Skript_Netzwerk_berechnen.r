# LEKTION 4: Netzwerkmaße berechnen und visualisieren
# Zu Beginn der Analyse müssen Sie sich die Frage stellen, was sie besonders interessiert. Es gibt sehr viele Auswertungsmöglichkeiten. Ein Vergleich von Netzwerken oder Teilnetzwerken nach bestimmten Attributen ist meist gewinnbringender, als eine allgemeine Analyse.

# wir verwenden wieder das help Netzwerk.

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

