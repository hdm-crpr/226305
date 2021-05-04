# Datensatz Semesterverbund CRPR2 #
Codebuch Stand 2021-05
erstellt von Swaran Sandhu (sandhu@hdm-stuttgart.de)

## Inhalt
- Edges.csv (Edgelist)
- Nodes.csv (Nodelist)
- Codebuch.md (Codierung der Datensätze)

## Ursprung und Datenerhebung
Ich habe den Datensatz unter den Studierenden des dritten Semesters im Kurs Netzwerkanalyse erhoben. Die Daten sind nach der Erhebung nach einem Zufallsprinzip anonymisiert worden.

Das Netzwerk ist ein *gerichtetes one-mode Akteursnetzwerk*. Es wurden zwei getrennte Fragen erhoben:

**Projektarbeitsnetzwerk work**  
1a) Bei Hochschulprojekten arbeite ich am liebsten mit folgender Person aus meinem Semester: Bitte tragen Sie das Kürzel der Person ein.  
1b) Bei Hochschulprojekten arbeite ich am auch gerne mit folgender Person aus meinem Semester: Bitte tragen Sie das Kürzel der zweiten Person ein.  
  
Für das Zusammenarbeitsnetzwerk *work* wurde der Person, die zuerst genannt wurde, ein Gewicht von 3 vergeben, die zweite Person erhielt ein Gewicht von 1. Insgesamt waren 76 Beziehungsmuster möglich.  

**Unterstützungsnetzwerk help**  
2a) Wenn Sie ein Problem oder eine studiengangsbezogene Frage haben, an welchen ihrer Mitstudenten aus ihrem Semester wenden Sie sich zuerst?  Bitte tragen Sie auch hier wieder das Kürzel ein.  
2b) Wenn Sie ein Problem oder eine studiengangsbezogene Frage haben, an welchen ihrer Mitstudenten aus ihrem Semester wenden Sie sich als nächstes? Bitte tragen Sie auch hier wieder das Kürzel ein.
  
Für das Unterstützungsnetzwerk *help* wurde der Person, die zuerst genannt wurde, ein Gewicht von 3 vergeben, die zweite Person erhielt ein Gewicht von 1. Insgesamt waren 76 Beziehungsmuster möglich.
  
**Beziehungsnetzwerk love**
Das Edge-Attribut *complicated* beschreibt drei unterschiedliche Beziehungsmuster innerhalb der Gruppe. Diese Kriterien haben kein eigenes Gewicht, sondern sind über die Art der Beziehung definiert (reziproke Paarbeziehung, tinder-Aktivität, einseitige Beziehung).


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
1 = Beziehung (typische Paarbeziehung, d.h. reziprok zwischen beiden PartnerInnen),      
2 = Tinder-Like (hat die person rechts geswiped, muss aber nicht gegenseitig sein)     
3 = Crush (einseitig verliebt, ohne dass die Person etwas davon weiss).  


# NODE-Attribute  
  
**id**  
Identische ID wie aus der edgelist zur Identifikation der Knoten. In diesem Fall sind alle personenbezogenen Daten anonymisiert von 1 bis 38.

**name**
Vorname (fiktiv)

**name2** 
Vorname abgekürzt, z.B. für Visualiserung, falls der Name zu lange ist

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
4 = rot.    

##
