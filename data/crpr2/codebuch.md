# Datensatz Semesterverbund CRPR2 #
Codebuch Stand 2020-03-10
erstellt von Swaran Sandhu | sandhu@hdm-stuttgart.de ###

## Inhalt
- Edges.csv (Edgelist)
- Nodes.csv (Nodelist)
- Codebuch.rm (Codierung der Datensätze)

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

**Beziehungsnetzwerk love**
Mit dem Edge-Attribut *love* wurden fiktive Beziehungsmuster zwischen den Studierenden angelegt, die über das Edge-Attribut *complicated* weiter präzisiert sind.


# EDGE-Attribute

**id**  
(eindeutige Codierung des Knoten)   
codiert von 1 bis 38, jede ID entspricht einem Studenten

**weight**  
Beziehungsstärke aufgrund der Nennung in den Fragen)  
3 = sehr starke Beziehung (erste Nennung),   
1 = starke Beziehung vorhanden (zweite Nennung)

**relation**
Beziehungsart zwischen den Personen  
1 = *work* Projektbasierte Beziehung: Bei einem gerichteten Netzwerk präferiert der Sender (erste Spalte) die Zusammenarbeit mit der genannten Zielperson (zweite Spalte).  
2 = *help* Unterstützungsbeziehung: Bei einem gerichteten Netzwerk fragt der Sender (erste Spalte) die genannte Person (zweite Spalte) um Rat.
3 = *love* Liebesbeziehung zwischen Akteuren, codiert nach dem Attribut *complicated*

**complicated**
1 = single,    
2 = Tinder-Match,   
3 = One-Night-Stand,  
4 = Beziehung unter 3 Monate,   
5 = Beziehung über 3 Monate,   
6 = Verlobung,   
7 = Heirat,   
8 = Scheidung,  
9 = complicated.

**time**
1 = 2016,      
2 = 2017,  
3 = 2018,   
4 = 2019,    
5 = 2020.    


# NODE-Attribute  
  
**id**  
Identische ID wie aus der edgelist zur Identifikation der Knoten. In diesem Fall sind alle personenbezogenen Daten anonymisiert von 1 bis 38.

**sex**    
Bitte geben Sie ihr Geschlecht an:  
1 = weiblich  
2 = männlich  
3 = divers
  
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
Tatoo vorhanden?   
1 = nein  
2 = ja  
  
**eyes**    
Welche Augenfarbe?    
1 = grün,   
2 = blau,   
3 = braun,   
4 = blau.     

**hair**  
Welche Haarfarbe?  
1 = braun,      
2 = schwarz,   
3 = blond,    
4 = brunette.    

##
