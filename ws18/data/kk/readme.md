# Analyse Zusammensetzung Kohlekommission
## Aufgabenstellung

Aufgabe: Bitte erstellen Sie ein Netzwerk der Mitglieder der aktuellen Kohlekommission, die 2019 den Kohleausstieg beschlossen hat. Analysieren Sie dabei die Zugehörigkeit der Mitglieder zu Parteien und zu gesellschaftlichen Feldern. 

Verwenden Sie bitte dazu folgende Quelle:
https://www.klimareporter.de/deutschland/das-sind-die-mitglieder-der-kohlekommission

Weitere Quellen sind nur zur Ergänzung und nicht zur Vertiefung gedacht.
https://de.wikipedia.org/wiki/Kommission_f%C3%BCr_Wachstum,_Strukturwandel_und_Besch%C3%A4ftigung#Mitglieder

Das Netzwerk soll folgende Information umfassen:

Nachname
Parteizugehörigkeit (ansonsten NA)
Zugehörigkeit zu einem gesellschaftlichen Feld (es zählt hier die zuletzt ausgeübte Tätigkeit bzw. die genannte Tätigkeit)
Alter
Geschlecht


# Codebuch:

Erstellen Sie das Netzwerk mit der Google-Doc Vorlage aus der Veranstaltung, das Sie kopieren können und natürlich anpassen müssen

https://docs.google.com/spreadsheets/d/1LWtza6paR5HFFA-fSZV8vioL8joFOIDXtQPdxKe79Kg/edit#gid=0

 # EDGELIST

Edgelist

from,to, weight
id, Stakeholdergruppe, Einfluss

"from" -> ID des Akteurs, i.d.R. Nachname

"to" -> Zugehörigkeit der Mitglieder zu gesellschaftlichen Gruppen (Stakeholdergruppe)

Definieren Sie für die Stakeholdergruppen folgende Codierung in der Edgelist (ohne Klammern)

1 = Politik
2 = Verband (Industrie)
3 = Gewerkschaft
4 = Umweltschutz (Verband/NGO/Initiative)
5 = Industrie (Unternehmen aller Art außer Energieunternehmen)
6 = Energieunternehmen (Kohle, Strom, Gas, Wasser)
7 = Wissenschaft (Universitäten, Forschungszentren, Institute)
8 = Regionalvertreter (auch Wählerverbünde)
9 = CDU
10 = CSU
11 = SPD
12 = Gruene
NA für alles, was nicht zutrifft.

Achtung: Es zählt immer die zuletzt ausgeübte Funktion in der Kohlekommission. Wenn Doppelfunktionen vorhanden sind, müssen Sie diese auch doppelt in der Edgelist anlegen, z.B. Vertreter von Gewerkschaft und SPD-Mitglied. In diesem Fall muss der Datensatz zwei Mal angelegt werden:

Mueller, 3, 3
Mueller, 11, 1

"weight" (Einfluss)

Definieren Sie als weight den vermuteten Einfluss in der Kommission oder der Partei

1 = ohne Stimmrecht / ehemaliges Mandat, Parteimitglied 
2 = Stimmrecht / aktives Mandat
3 = Vorsitzende / aktives Mandat oder Ministeramt

# NODELIST

id, name, type, party, age, sex

"id"  = ID aller Akteure aus der Edgelist (richtig geschrieben!)
"name" = Nachname von Personen oder Bezeichnung von Organisationen

"type" = 0 = Person, 1 = Organisation

"party" = Parteizugehörigkeit wie oben (im Sinne von Besitz eines Parteibuchs auch ohne aktives Amt)

"age" = Alter in Lebensjahren, bei Organisationen NA. Bitte achten Sie darauf, das Alter in sinnvolle Abschnitte ordinal zu codieren (also nicht absolute Zahlen, sondern z.B. 1 = bis 39, 2=40-49, etc.)

"sex" = Geschlecht, bei Organisationen NA

Exportieren Sie die Edge- und Nodelist als CSV-Dateien in ein Verzeichnis Ihrer Wahl oder auf github. Ich zeige im Code nur das Beispiel für Github.

# Fragen
1) Welche Akteure haben in Ihrem Netzwerk den höchsten Zentralitätswert? Wie können Sie dies interpretieren?
2) Exportieren Sie die Netzwerk-Grafik als PDF und setzen Sie diese in Ihre Abgabe ein.
