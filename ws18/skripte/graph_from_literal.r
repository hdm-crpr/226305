# Aufgabe: Bitte erstellen Sie ein einfaches one-mode Netzwerk nach Ihrer Skizze vom letzten Mal (z.B. Harry Potter oder ähnliches). Das Netzwerk sollte ca. fünf bis acht nodes umfassen und mindestens vier edges. Wir verwenden für diese Übung keine Gewichte.

# für die Skizze verwenden wir den Befehl "graph_from_literal" aus dem igraph-Paket (vorher laden). Verwenden Sie die Hilfefunktion, um sich die Funktion zu erklären.

library(igraph)

#ruft die Hilfefunktion für den Befehl auf
??graph_from_literal

# ungerichtetes Netzwerk
g <- graph_from_literal( A--B, C--D, E--F, G--H, I, J, K)
plot(g)

# Alternative Beschreibung zur Vereinfachung von mehrere Beziehungen
g <- graph_from_literal( A:B:C:D -- A:F)
plot(g)

# gerichtetes Netzwerk
g <- graph_from_literal( A -+ B -+ C -+D, E)
plot(g)

# Beispiel mit Namen (gerichtet)
gangster <- graph_from_literal( "Kollegah" +-+ "Farid Bang" -+ "Niki Minaj" -+"Moneyboy", "Helene Fischer")
plot(gangster, edge.arrow.size=.2, edge.color="blue", edge.curved=.2, main="Wer disst wen im deutschen Gangster-Rap (Beispiel)")

# Sichern Sie die Abbildung im Plot-Fenster Export als "Image" oder PDF.
