# Befragung WS18
n=36 Befragte  
n=36 gültige Datensätze


# Codebuch	

## Edge-Attribute
from "Sender"  
to "Empfänger"   
(als gerichtetes Netzwerk)  

weight  
3 = erste Nennung  
1 = zweite Nennung  

relation     
1 = Ratsuche (help) 
2 = Zusammenarbeit (work)     

Zusammenarbeit   
Bei Hochschulprojekten arbeite ich am liebsten mit folgender Person aus meinem Semester: Bitte tragen Sie das Kürzel der Person ein (maximal eine Nennung, keine Leerzeichen, keine Sonderzeichen, keine Anführungszeichen).

Ratsuche   
Wenn Sie ein Problem oder eine studiengangsbezogene Frage haben, an welchen ihrer Mitstudenten aus ihrem Semester wenden Sie sich zuerst?  Bitte tragen Sie auch hier wieder das Kürzel ein (maximal eine Nennung).

## Node-Attribute
ID = ID der Edgelist

sex  	  
1	weiblich  
2	männlich

crpr  	 
1	PR  
2	CR

age
(Bitte geben Sie Ihr Alter in Jahren an)   	  
1	bis 20  
2	21-22  
3	23-24  
4	über 25  

smoke   
(Als Raucher gilt, wer mindestens ein Mal pro Woche raucht (egal was und wie).
1	Nichtraucher  
2	Raucher

tattoo   	 
1	Keines  
2	Tatoo vorhanden

living     
(Bitte geben Sie an, wie Sie wohnen. (Mit "wohnen" ist der Ort gemeint, an dem Sie ausserhalb der Präsenz an der Hochschule in der Vorlesungszeit am meisten Zeit verbringen)
1	Familie  
2	Wohnheim  
3	WG  
4	Zimmer  
5	sonstiges  

expenses      
(Bitte geben Sie an, wie hoch die (Warm-)Miete Ihrer Unterkunft im Monat ist (egal, ob Sie die Miete selbst bezahlen oder nicht).
1	bis 300  
2	301-400  
3	401-500  
4	501-600  
5	über 600  
6 kostenlos

work   
(Ich arbeitete neben meinem  Studium in der Regel... (unter Arbeit sind alle Formen des Geldverdienens gemeint, egal welcher Art. Es geht hier um einen Mittelwert, der auch die Zeit in der vorlesungsfreien Zeit umfasst.). Ehrenamtliche unbezahlte Tätigkeiten wie Sport/Engagement, etc. zählen nicht dazu.)
1	keine Arbeit  
2	halber Tag (5h Woche)  
3	ganzer Tag (10h Woche)  
4	mehr als 10h in der Woche  
