# Codebuch

# edgelist	
Grundregel: Die Edgelist darf pro Spalte immer nur einen Wert enthalten. Bis auf die ID idealerweise numerisch codiert (als Zahl).

- from: definiert den Sender in gerichteten Netzwerken. Entspricht ID in der Nodelist. Keine Sonderzeichen, nur ein Wort
- to: definiert den Empfänger in ungerichteten Netzwerken. Entspricht ID in der Nodelist. Keine Sonderzeichen, etc. 
- weight: Ausprägung der Kantenstärke (Beziehungsstärke), definiert nach vorgegeben Skalen.
- relationship: definiert die Art der Beziehung bei multiplexen Netzwerken mit verschiedenen Beziehungsarten
- time: definiert einen Zeitraum, in dem die Beziehung zwischen zwei Knoten stattgefunden hat oder beobachtet wurde.

# nodelist	
Grundregel: die IDs der Nodelist müssen mit den IDs der Edgelist komplett übereinstimmen. Ausprägungen der Attribute in der Regel numerisch definieren.

- id: eindeutige Identifikation jedes einzelnen Knotens (vertex), der erfasst wird.  
- name: Name oder Bezeichnung des Knotens. 
- sex:	dichotome Ausprägung: male oder female. Einfacher auch numerisch als 1 oder 2 zu kodieren.
- power:	definiert als Macht des Akteurs (1 = sehr gering, 5 = sehr hoch)
- fans	definiert als Anzahl der follower des Akteurs (gemessen bei XY zum Zeitpunkt Z)
- type:	relevant bei two-mode Netzwerken, um die Unterscheidung zwischen z.B. Akteur und Event zu berechnen.
	
NA definiert fehlende Werte, bei der Datenerhebung das Feld einfach leer lassen, R rechnet NAs (missing values) automatisch raus..
