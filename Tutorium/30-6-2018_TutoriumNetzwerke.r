### Tutorium 30-5-2018
### Kleiner Einblick in Visualisierung Teil 2 und kurze Wiederholung der Netzwerkmaße

# Vorab bitte alle wichtigen Pakete laden!

library(igraph)
library(igraphdata)

# Wir arbeiten heute mit dem UKfaculty Freundschafts-Netzwerk aus dem igraphdata Paket.

data(UKfaculty)
UKfaculty
plot(UKfaculty)

## Visualisierung Teil 2

# Wir haben bereits gelernt, dass man mithilfe einiger Argumente im plot-Befehl die Visualisierung anpassen kann.

plot(UKfaculty, edge.arrow.size=0.4, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", layout=layout_with_kk, edge.color="grey80")

# Das sieht noch immer schrecklich aus. Je mehr Knoten (und Kanten), desto schlechter kann man das Netzwerk erkennen.
# Ein weiterer Tipp für den plot-Befehl wäre es, das Netzwerk erst einmal zu entzerren.

coords <- layout_with_kk(UKfaculty)*0.4

plot(UKfaculty, edge.arrow.size=0.4, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", layout=coords, rescale=FALSE, edge.color="grey80")

# Bereich für das Fenster angeben (richtige Maße findet man nur durch Probieren)

plot(UKfaculty, edge.arrow.size=0.4, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", layout=coords, rescale=FALSE, ylim=c(-1.5,1.7),xlim=c(-1.1,1.8), asp = 0, edge.color="grey80")

# Es gibt aber auch ein Paket, das euch bei der Visualisierung besser helfen kann.
# Installen wir visNetwork

install.packages("visNetwork")

# Ladet visNetwork

library(visNetwork)

# Bei visNetwork definiert man das Aussehen der Knoten und Kanten vorab und plottet dann das Netzwerk.

E(UKfaculty)$arrow.size <- 0.1
E(UKfaculty)$color <- "lightgrey"
V(UKfaculty)$color <- "pink"
V(UKfaculty)$size <- 10
V(UKfaculty)$frame.color <- "transparent"
V(UKfaculty)$label.color <- "black"
visIgraph(UKfaculty, physics=F, type = "full")

# Achtung: R-Farben wie "grey80" kennt visNetwork nicht, es gibt sie aber! Ihr gebt am besten die Farben als Hexadezimalzahl an (lässt sich alles googlen)
# Leider kann man Netzwerke aus visNetwork nicht ohne Weiteres als PDF speichern. Die Qualität des Bildes geht als PNG enorm verloren. Am besten ihr nutzt das Zoom Fenster, macht das Netzwerk so groß wie möglich und macht einen Screenshot --> immer noch viel besser als PNG und Co
# Cool: Man kann in das Netzwerk innerhalb von R ohne Qualitätsverlust rein und rauszoomen und die Knoten manuell verschieben.

## Kleine Wiederholung Netzwerkmaße

# Wenn wir Triadentypen im Netzwerk bestimmen möchten, geben wir den folgenden Befehl ein:

triad_census(UKfaculty)

# Ausgegeben werden uns 16 Zahlen. Doch was haben die zu bedeuten? Schaut unter Packages --> igraph --> triad_census nach! Es sind die 16 Triadentypen, die dort angegeben werden.

# Wenn man ein Cluster visualisieren möchte, so nutzt man den cluster_walktrap Befehl.

clusterUK <- cluster_walktrap(UKfaculty)

plot(clusterUK, UKfaculty, edge.arrow.size=0.4, vertex.color="pink2", vertex.frame.color="transparent", vertex.label.family = "Helvetica", vertex.label.color = "magenta3", layout=coords, rescale=FALSE, ylim=c(-1.5,1.7),xlim=c(-1.1,1.8), asp = 0, edge.color="grey80")

# Leider kann man Cluster nicht ohne Weiteres innerhalb des visIgraph Befehls visualisieren. Der normale plot-Befehl muss ausreichen.
