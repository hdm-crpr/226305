# Codebuch

Erhoben wurde die Gästeliste der Talkshow Anne Will im Jahr 2022 zum Thema Ukraine.  
Quelle: https://www.fernsehserien.de/anne-will/folgen/500-keine-entspannung-im-konflikt-mit-putin-wie-ist-ein-neuer-krieg-zu-verhindern-1532088  
Grundregeln: keine Sonderzeichen, keine Leerzeichen, etc.

## Edgelist
from = ID des Knoten Mitglied  
to = ID des Knoten Mitgliedschaft  
relationship: 1 = Teilnahme Talkshow,2 = Mitglied Partei  

## Nodelist
id = ID aus der Edgelist  
name = Voller Name/Bezeichnung   
party = Parteizugehörigkeit, codiert nach Parteiname  
sector = z.B. Politik, Militär, Journalismus, Wissenschaft, etc.  
country = Lebensmittelpunkt  
type = 1 als Person, 2 als Organisation  
