# Datensatz Semesterverbund CR/PR #
# Codebuch
### Swaran Sandhu, sandhu@hdm-stuttgart.de ###

## Inhalt
- Edges.csv (Edgelist)
- Nodes.csv (Nodelist)
- Codierung.rm (Codierung der Datensätze)

## Ursprung und Datenerhebung
Ich habe den Datensatz unter den Studierenden des dritten Semesters im Kurs Netzwerkanalyse erhoben. Die Daten sind nach der Erhebung nach einem Zufallsprinzip anonymisiert worden.

Das Netzwerk ist ein *gerichtetes one-mode Akteursnetzwerk*. Es wurden zwei getrennte Fragen erhoben:

**Projektarbeitsnetzwerk work**
1a) Bei Hochschulprojekten arbeite ich am liebsten mit folgender Person aus meinem Semester: Bitte tragen Sie das Kürzel der Person ein.  
1b) Bei Hochschulprojekten arbeite ich am auch gerne mit folgender Person aus meinem Semester: Bitte tragen Sie das Kürzel der zweiten Person ein.  

Für das Zusammenarbeitsnetzwerk "work" wurde der Person, die zuerst genannt wurde, ein Gewicht von 3 vergeben, die zweite Person erhielt ein Gewicht von 1. Insgesamt waren 76 Beziehungsmuster möglich.  

**Unterstützungsnetzwerk help**  
2a) Wenn Sie ein Problem oder eine studiengangsbezogene Frage haben, an welchen ihrer Mitstudenten aus ihrem Semester wenden Sie sich zuerst?  Bitte tragen Sie auch hier wieder das Kürzel ein.  
2b) Wenn Sie ein Problem oder eine studiengangsbezogene Frage haben, an welchen ihrer Mitstudenten aus ihrem Semester wenden Sie sich als nächstes? Bitte tragen Sie auch hier wieder das Kürzel ein.

Für das Unterstützungsnetzwerk "help" wurde der Person, die zuerst genannt wurde, ein Gewicht von 3 vergeben, die zweite Person erhielt ein Gewicht von 1. Insgesamt waren 76 Beziehungsmuster möglich.


# EDGE-Attribute

**id** (eindeutige Codierung des Knoten) 
codiert von 1 bis 38, jede ID entspricht einem Studenten

**weight** (Beziehungsstärke aufgrund der Nennung in den Fragen)
3 = sehr starke Beziehung,
1 = starke Beziehung vorhanden (zweite Nennung)

**relation**  
1 = *work* = Projektbasierte Beziehung: Bei einem gerichteten Netzwerk präferiert der Sender (erste Spalte) die Zusammenarbeit mit der genannten Zielperson (zweite Spalte).  
2 = *help* = Unterstützungsbeziehung: Bei einem gerichteten Netzwerk fragt der Sender (erste Spalte) die genannte Person (zweite Spalte) um Rat.

# NODE-Attribute  
  
**id**  
Identische ID wie aus der edgelist zur Identifikation der Knoten. In diesem Fall sind alle personenbezogenen Daten anonymisiert von 1 bis 38.

**sex**    
Bitte geben Sie ihr Geschlecht an:
1 = weiblich  
2 = männlich
  
**crpr***    
Welche Studienrichtung haben Sie vertieft?  
1 = CR  
2 = PR

**age**   
Bitte geben Sie Ihr Alter an:  
1 = bis 20 Jahre    
2 = 21 bis 22 Jahre    
3 = 23 bis 24 Jahre  
4 = 25 und älter  

**smoke**    
Rauchen Sie mindestens ein Mal pro Woche?  
1 = nein   
2 = ja  
  
**tatoo**    
Haben Sie ein Tatoo?    
1 = nein  
2 = ja  
  
**living**    
Bitte geben Sie an, wie Sie wohnen:    
1 = Wohnheim   
2 = bei den Eltern   
3 = WG   
4 = private Wohnung   

**work**  
Bitte geben Sie an, wie viel Zeit Sie pro Woche neben dem Studium arbeiten (kein Ehrenamt):  
1 = keinen    
2 = bis 5h/Woche  
3 = bis 10h/Woche  
4 = mehr als 10h/Woche  

##
