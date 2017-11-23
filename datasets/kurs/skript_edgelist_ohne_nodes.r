# Problem: Node und Edgelist stimmen nicht überein, es gibt eine Fehlermeldung

# Häufig gibt es Fehlermeldungen, wenn die Edge- und Nodelist bei der Erstellung eines igraph-Objekts nicht zusammenpassen.

# Überprüfen Sie die Separatoren der CSV.Dateien - diese müssen richtig eingegeben sein.

# Überprüfen Sie dann, dass alle Edge-IDs (egal ob from oder to) auch in der Nodelist als erste Spalte "name" auftauchen. Häufig kann es an einem Leerzeichen oder ähnlichem liegen.

# Teilweise werden die Gewichte nicht angezeigt, wenn es keine numerischen Operatoren sind.

# Alternative: Edgelist one Nodelist erstellen:
# Arbeitsverzeichnis festlegen

library(igraph)

# Beispiel mit einer Edgelist "el" in der Working-Directory.


el <- read.csv("el.csv", header=T, as.is=T, sep = ";")
# liest eine edgelist ein, hier auf den Separator achten, ob dieser ein Komma oder Semicolon ist.

# ALTERNATIVE; falls keine Edgelist zur Hand

el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")

net <- graph_from_data_frame(el, directed = F, vertices = NULL)
# erstellt ein (ungerichtetes) Netzwerk aus der Edgelist, allerdings ohne Knoteninformationen.

plot(net, vertex.label=NA, vertex.size=degree(net), vertex.color="blue", layout = layout_with_fr, edge.color="grey60", edge.curved=.2, vertex.frame.color="white", main = "Edgelist ohne Nodes")

# erstellt ein einfaches Netzwerk nach degrees
