### Tutorium 11. April 2018

# Wir lernen heute, wie man einen Beispieldatensatz lädt. Mit diesem Datensatz werden wir in den nächsten Wochen weiterarbeiten.

# Zunächst müsst ihr igraph installieren und laden
# Erinnerung: Befehle aus einem Skript ladet ihr, indem ihr in die Zeile klickt und auf run drückt.

install.packages("igraph") #installiert das Paket, ist optional, wenn ihr es schon installiert habt
library("igraph") #lädt das Paket igraph, damit ihr es nutzen könnt

# Dasselbe machen wir mit dem Paket igraphdata

install.packages("igraphdata")
library("igraphdata")

# Mit dem folgenden Befehl könnt ihr euch anzeigen lassen, welche Datensätze das igraphdata Paket beinhaltet.

data(package="igraphdata") 

# Wir werden mit dem karate Datensatz arbeiten. Dieser bildet ein Netzwerk eines Karateclubs ab, der aufgrund zweier „Leiter“ zwiegespalten ist. Es gibt also zwei Fraktionen.

# Um den Datensatz zu laden, führen wir den folgenden Befehl aus.

data(karate)

# In eurem environment oben rechts sollte nun das igraph Objekt karate vorliegen. Wenn wir den Namen eingeben und Enter betätigen, erhalten wir die Ausgabe des Objekts, die erst einmal verwirrend aussieht.

karate

# Die Bezeichnungen bedeuten: UNW- (undirected, named, weighted, none) Das genaue Gegenteil davon wäre D--B (directed, none, none, bi-partite). Es werden damit die allgemeinen Charakteristika des Netzwerkes angegeben. Es gibt zudem 34 Knoten und 78 Kanten. Dann kommen die Attribute mit der Buchstabenkombi x/y. x kann g (gesamter Graph), v (vertices/Knoten) und e (edges/Kanten) annehmen. y kann c (characters/Buchstaben) oder n (numerisch/Zahlen) annehmen.

# Igraph Objekte kann man schnell visualisieren:

plot(karate)

# Im unteren rechten Reiter plots öffnet sich nun die Visualisierung. Diese ist natürlich noch nicht so schön. Wie das besser aussehen kann, lernt ihr zu einem späteren Zeitpunkt.

# Wenn wir den Befehl:

karate

# eingeben, dann wird uns in der Konsole das igraph Objekt angezeigt. 

# Man kann das igraph-Objekt auch durch einen anderen Befehl erstellen:

make_graph("Zachary")

# Euch wird wieder dasselbe igraph Objekt angezeigt. Plotten würden wir es also so:

plot(make_graph("Zachary"))

# Nervig, oder? Deswegen teilen wir jetzt dem Ergebnis des make_graph("Zachary") Befehls eine Variable zu. Das ist wie ein Shortcut. Das geschieht durch den Pfeilbefehl.

z <- make_graph("Zachary")

# Auch z taucht nun im environment auf. Wenn wir

z

# eingeben, wird uns das igraph Objekt in der Konsole aufgezeigt. Das Objekt hat weniger Informationen und weniger Attribute.

plot(z)

# eingeben, erhalten wir die gewohnte Visualisierung.

# Objekte im environment kann man mit folgendem Befehl wieder löschen:

rm(karate)
rm(z)

# Schon sind unsere igraph Objekte verschwunden.
