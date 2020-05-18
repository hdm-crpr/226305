# Codebuch Ego-Netzwerkanalyse

Wir erstellen ein gerichtetes Ego-Netzwerk aus dem Namensgenerator und -interpretator. Fehlende Daten werden mit NA codiert. Die Daten sind aus Partnerinterviews entstanden. Sie erstellen ihr eigenes Ego-Netzwerk mit den Daten, die Ihr Interviewpartner erhoben hat.

Grundsätzlich: bitte keine Sonderzeichen verwenden, keine Leerzeichen in den Datenfelder. Fehlende Werte freilassen oder mit NA codieren. Nicht vergessen, auch das Ego (also sich selbst) zu erheben. 

WICHTIG: die IDs von der Edgelist müssen mit den IDs der Nodelist genau übereinstimmen!

### Edgelist
Für die Edgelist müssen Sie die Beziehungen aus Abschnitt 2 und Abschnitt 3 als Edgelist erfassen.
  
from = ID des Knoten  
to = ID des Knoten (Richtung)
  
*weight* 
Beziehungsgewicht für Frage 2.1, codiert als   
1 = weniger als ein mal im Monat,  
2 = mindestens ein Mal im Monat,  
3 = mindestens ein Mal pro Woche,  
4 = täglich.  

*duration*  
1 = weniger als drei Jahre,   
2 = drei bis sechs Jahre,  
3 = mehr als sechs Jahre.  
  
*relationship*
1 = Eltern oder Kinder (Verwandtschaft ersten Grades),  
2 = Geschwister (Verwandtschaft ersten Grades),  
3 = Verwandtschaft zweiten Grades (Onkel, Tante),   
4 = Nachbarn,   
5 = Arbeitskollege,   
6 = Kommilitone,   
7 = Mitglied in gleicher Gruppe (Sport, Verein, Kirche, etc.),   
8 = Ratgeber (z.B. Anwalter, Berater, Therapeut, spiritueller Beistand, etc.),   
9 = Freund (nichts von oben).
  
## Nodelist
Die Nodelist erfasst alle soziodemographischen Daten. Dazu gehören auch ihre eigenen ;-).

*ID*  
ID muss identisch zur Edgelist sein (z.B. Name, Abkürzung, etc.)

*sex* (Geschlecht)
1 = weiblich,  
2 = männlich,  
3 = divers,  

*ethnicity* (Herkunft)  
1 = deutsch,   
2 = Mittel/Osteuropa (auch UK),  
3 = Südeuropa,  
4 = Asien, 
5 = Skandinavien,  
6 = Südamerika,  
7 = Nordamerika,  
8 = Russland,  
9 = Afrika  

*age*  
1 = unter 18,  
2 = 18 bis 25,  
3 = 26 bis 34,   
4 = 35 bis 64,  
5 = über 64.  
  
*religion*  
1 = evangelisch/protestantisch,  
2 = katholisch,  
3 = jüdisch,  
4 = muslimisch,  
5 = buddhistisch,  
6 = orthodox,  
7 = andere,  
8 = keine.  
  
*education*
1 = Hauptschule,  
2 = Mittlere Reife,  
3 = Fachhochschulreife,  
4 = Abitur,  
5 = Studium,  
6 = Promotion,  
7 = weiss nicht.

