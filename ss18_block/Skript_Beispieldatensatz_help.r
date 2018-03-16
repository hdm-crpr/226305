# Daten aus CSV Dateien einlesen und in igraph-Objekte umwandeln

# neues Projekt in RStudio anlegen, um alle Daten dort zu speichern

setwd("~/Desktop/sna")
# Legt die working directory / Arbeitsverzeichnis fest.
# Edge- und Nodelist sind online in meinen github abgelegt und können daraus direkt eingelesen werden.

library(igraph)
# lädt das Paket "igraph"

help <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ehelp.csv", header=T, as.is=T, sep = ",")
work <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/ework.csv", header=T, as.is=T, sep = ",")
# lädt die edgelist aus der Datei in der working directory. Auf Trennzeichen achten!

nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/datasets/kurs/nodes.csv", header=T, as.is=T, sep = ",")
# lädt die Nodelist aus der working direcotry

head(help)
head(nodes)
# überprüfen von Edge- und Nodelist in R

hties <-as.matrix(help)
wties <-as.matrix(work)
# Umwandlung der Edgelist in eine Matrix

help <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
work <- graph_from_data_frame(d=wties, vertices=nodes, directed=T)
# Kombination der Edge- und Nodelist in ein igraph-Objekt

works <- simplify(work, edge.attr.comb = list(weight="sum"))
helps <- simplify(help, edge.attr.comb = list(weight="sum"))
# addiert die Gewichte bei gleichen Beziehungen

edge_attr(work)
# zeigt die Verteilung des Attributs "weight" an.

vertex_attr(work)
# zeigt die Verteilung der Vertex-Attribute an.

