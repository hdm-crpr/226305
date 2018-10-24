# Skripte anlegen
# 17 Oktober 2018
#

# Einfache Operationen (Beispiel)
2+5

meins <- 1976
meins

heute <- 2018
heute - meins
ihres <- 1997

altersunterschied <- ihres - meins
altersunterschied
altersunterschied*2

# 2010-10-24 Tutorium 3

# Einfache Funktionen in R

(2 + 5 -4)*5/4 # alle Grundrechenarten
pi*2 # wichtige Platzhalter
a <- c(2, 3, 4, 5, 6, 7, 8) # Zuweisung von Vektoren auf Variablen
mean(a) # Einsatz von Funktionen wie Mittelwert des Vektors a
sum(a) # liefert die Summe des Vektors a

# Verwendung von Vectoren
# c steht als Befehl für combine
vec1 <- c(1, 4, 6, 8, 10)
vec1 # ruft den neuen Vector auf
# mit [ ] können einzelne Positionen des Vectors ausgewählt werden
vec1[4] # ruft den Wert der vierten Position des Vectors auf.
vec1[4] <- 20 # weist Position 4 den neuen Wert 20 zu
sum(vec1) # berechnet die Summe aller Werte des Vectors

# Erstellen eines data.frames
# Erstellung eines data.frame aus Daten
ga <- data.frame(geschlecht=c("m","w","m"),alter=c(18,21,27))
ga # ruft unseren data.frame “ga” auf

ga$geschlecht

# das $-Zeichen selektiert Datensätze nach Spaltenkritierium, in diesem Fall werden nur die Werte für Geschlecht ausgegegeben.

# Installieren von Paketen
install.packages("igraph") # installiert igraph Paket
install.packages("igraphdata") # installiert igraphdata Paket mit Datensätzen

# Aufrufen von Programmbibliotheken
library("igraph")
library("igraphdata")

# Hilfefunktionen
?igraphdata # Hilfefunktion zu dem Paket
data(package="igraphdata") # zeigt die Datensätze des Pakets an

# Paket Karate aktivieren
data(karate) # aktiviert den Datensatz "karate"
karate # ruft den Datensatz auf

plot(karate) # zeigt eine einfache Visualisierung an

# Welche Attribute haben die Kanten?
list.edge.attributes(karate)

# Welche Attribute haben die Knoten?
list.vertex.attributes(karate)

# Erstellen eines einfachen Netzwerks nach einer Skizze

# Aufgabe: bitte erstelen Sie ein einfaches one-mode Netzwerk nach Ihrer Skizze vom letzten Mal (z.B. Harry Potter oder ähnliches). Überlegen Sie sich, ob ihr  Das Netzwerk sollte ca. drei bis fünf nodes umfassen und mindestens vier edges. Wir verwenden für diese Übung keine Gewichte.

# für die Skizze verwendenw wir den Befehl "graph_from_literal" aus dem igraph-Paket (vorher laden). Verwenden Sie die Hilfefunktion, um sich die Funktion zu erklären.

?graph_from_literal

# ungerichtetes Netzwerk
graph_from_literal(A-B)
g <- graph_from_literal(A-B)
plot(g)

# mehrere Knoten in einem Befehl
graph_from_literal( A--B, C--D, E--F, G--H, I, J, K)
g <- graph_from_literal( A--B, C--D, E--F, G--H, I, J, K)
plot(g)

# Alternative Beschreibung zur Vereinfachung von mehrere Beziehungen
graph_from_literal( A:B:C:D -- A:B:C:D )
g <- graph_from_literal( A:B:C:D -- A:B:C:D )
plot(g)

# gerichtetes Netzwerk
graph_from_literal( A -+ B -+ C -+D, E)
g <- graph_from_literal( A -+ B -+ C -+D, E)
plot(g)

# Beispiel mit Namen
graph_from_literal( Kollegah -+ "Farid Bang" -+ "Niki Minaj" -+"Moneyboy", "Helene Fischer")
gangster <- graph_from_literal( "Kollegah" +-+ "Farid Bang" -+ "Niki Minaj" -+"Moneyboy", "Helene Fischer")
plot(gangster, edge.arrow.size=.2, edge.color="blue", edge.curved=.2)



