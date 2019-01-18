# 226503 Tutorium Netzwerke
# Swaran Sandhu | sandhu@hdm-stuttgart.de
# Stand 2019 | v02


# Beispiel für die Datenerhebung (Filmbeziehungen)

# 1: Oscar Netzwerk erstellen
# erstellt das Oscar Netzwerk

library(igraph)
oscared <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/oscars/oscared.csv", header=T, as.is=T)
oscarnod <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/oscars/oscarnod.csv", header=T, as.is=T)
oscared <- as.matrix(oscared)
oscar <- graph_from_data_frame(d=oscared, vertices=oscarnod, directed=F)
oscar

# Berechnung der Netzwerkmaße

edge_density(oscar)
components(oscar)
cliques(oscar, min="3", max="3")
farthest_vertices(oscar)
mean_distance(oscar)

# Visualisierung

# two-mode Netzwerk berücksichtigen
vcoloscar <- vcount(oscar)
vcoloscar[V(oscar)$type == "1"] <- "green"
vcoloscar[V(oscar)$type == "2"] <- "gold"

# Visualisierung mit Farben
plot(oscar, vertex.color=vcoloscar)

# Visualisierung ohne Labels
plot(oscar,
     vertex.color=vcoloscar,
     vertex.label = ifelse(V(oscar)$type == "2", V(oscar)$name, NA))

# Visualisierung anhand der Degrees
plot(oscar,
     vertex.color=vcoloscar,
     vertex.label = ifelse(V(oscar)$type == "2", V(oscar)$name, NA),
     vertex.size = ifelse(V(oscar)$type == "2", degree(oscar)/3, 3),
     main="Degree-Verteilung im Netzwerk")

# Darstellung verbessern

coords <- layout_with_kk(oscar)*0.2

plot(oscar,
     vertex.color=vcoloscar,
     vertex.label = ifelse(V(oscar)$type == "2", V(oscar)$name, NA),
     vertex.size = ifelse(V(oscar)$type == "2", degree(oscar)/3, 3),
     layout = coords, rescale = FALSE,
     ylim=c(-1.5,2.2),xlim=c(-0.5,0.5),
     main ="Entzerrung der Visualisierung")

# Kantengewichte hinzufügen

plot(oscar,
     vertex.color=vcoloscar,
     vertex.label = ifelse(V(oscar)$type == "2", V(oscar)$name, NA),
     vertex.size = ifelse(V(oscar)$type == "2", degree(oscar)/3, 3),
     layout = coords, rescale = FALSE,
     ylim=c(-1.5,2.2),xlim=c(-0.5,0.5),
     edge.width=E(oscar)$weight,
     main="Kantengewichte ergänzt"
)

# Finale Darstellung

par(mar=c(1,1,4,1))


plot(oscar,
     vertex.color=vcoloscar,
     vertex.label = ifelse(V(oscar)$type == "2", V(oscar)$name, NA),
     vertex.size = ifelse(V(oscar)$type == "2", degree(oscar)/3, 3),
     layout = coords, rescale = FALSE,
     ylim=c(-1.5,2.2),xlim=c(-0.5,0.5),
     edge.width=E(oscar)$weight,
     vertex.frame.color = "transparent",
     vertex.label.family = "Helvetica",
     vertex.label.color = "black",
     vertex.label.cex=c(0.7),
     vertex.label.dist=-2,
     main="Spielen Oscar-GewinnerInnen \nin gemeinsamen Filmen?",
     sub="Darstellung nach Degrees und Kantengewichten")
