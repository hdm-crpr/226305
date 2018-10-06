# Challenge
# Tag 3
# Wenn Sie die Anforderungen erfüllt haben und Ihr Skript mit Lösungen auf Moodle hochgeladen haben, können Sie gehen (alternativ natürlich mir noch Fragen stellen!)

# Aufgabe: Beantworten Sie mit einer Visualisierung aus dem vorgegebenen Studentennetzwerk folgende Fragen:

# 1. Welche Personen sind im Arbeits- und Unterstützungsnetzwerk am populärsten? (Wer wird am meisten um Rat gefragt? Mit wem wird am liebsten zusammengearbeitet?) Sind es die gleichen Personen? Die Visualisierung soll beide Netzwerke vergleichen (beide Visualisierungen mit Überschriften nebeneinander.

# 2. Sind Raucher stärker in Triaden/Cliquen zu finden als Nicht-Raucher? Führen Sie einen Dyadenzensus durch. Belegen Sie dies mit einem Ego-Netzwerk der am besten vernetzten Raucher. Wer ist direkt mit dem Raucher verbunden? Sind Raucher die besseren Broker zwischen Netzwerken? (Tipp: Betweenness).
# Bonus-Frage: Sind Raucher/innen auch tätowiert? Wenn ja, wie viele?

# 3. Welche Vertiefungsrichtung arbeitet mehr/weniger? CR oder PR? Visualisieren Sie das bitte mit einem Farbverlauf (Tipp: Sie müssen vorher die Netzwerke trennen)

# 4. Vergleichen Sie die Cluster des Arbeits- und Ratsuche-Netzwerk, nachdem Sie die Gewichte der jeweiligen Netzwerke mit dem simplify Befehl aufaddiert haben. Visualisieren Sie die Cluster nebeneinander mit dem walktrap Algorithmus. Was fällt Ihnen dabei auf.

# Bitte laden Sie das R-Skript mit Antworten auf die Fragen auf Moodle hoch.


# Bitte verwenden ausschließlich folgenden Datensatz
# Codebuch ist hier hinterlegt
# https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd

library("igraph")
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")
eties <-as.matrix(el)
s <- graph_from_data_frame(d=eties, vertices=nodes, directed=T)
s
