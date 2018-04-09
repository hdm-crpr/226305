# RStudio und GitHub
Heute lernen wir die grafische Oberfläche RStudio und das Versionenverwaltungssystem GitHub kennen. Dabei werden die Basis-Funktionen beschrieben und die Bedienung erklärt.

## Einführung in RStudio
Wenn man RStudio das erste Mal öffnet, sieht man drei Fenster: links groß die Konsole, sowie rechts oben und rechts unten weitere Arbeitsbereiche, die sich in mehrere Reiter aufgliedern. Die Konsole ist nur so groß, solange man kein Skript geöffnet hat oder eine Ausgabe angefordert hat, die dann jeweils oben links angezeigt werden. Die Konsole „schrumpft“ dann sozusagen nach unten links.

### Konsole
Die Konsole entspricht der Kommandozeile in R. Die Zeile wird jeweils mit dem kleinen **>** angezeigt. Hier kann man Befehle eingeben und sie mit **Enter** bestätigen. Beim Eingeben werden dir per Auto-Vervollständigen Befehle vorgeschlagen, die du per Pfeiltasten wählen und mit Enter bestätigen kannst. Möchtest du deinen letzten Befehl wieder aufrufen, kannst du zu Beginn der neuen Eingabe einfach Pfeiltaste nach oben drücken. Die Konsole kennt und führt nur Befehle aus, die in den installierten Paketen hinterlegt sind (dazu später mehr). Die Konsole ist ebenfalls nicht das richtige Tool, um seine ausgeführten Befehle zu dokumentieren. Dazu legen wir lieber ein Skript an.

### Ausgabefenster/Editor
Das Ausgabefenster bzw. der Editor öffnet sich, wie in der Einleitung bereits beschrieben, nur, wenn es nötig ist. Wenn es nicht geöffnet ist, ist die Konsole größer dargestellt. Befehle, die in der Konsole ausgeführt werden, können in diesem Fenster eine Ausgabe generieren, zum Beispiel wenn wir uns die Inhalte eines Pakets anzeigen lassen wollen. Viel wichtiger ist jedoch der Editor, mit dem wir unsere Skripte erstellen können. Skripte sind Textdokumente, in denen wir unsere verwendeten Befehle dokumentieren, damit wir den Verlauf unseres Projekts nachvollziehen können. So ein Skript gebt ihr am Ende auch bei der Prüfung ab. Um ein neues Skript zu erstellen, drückt ihr oben links auf das grüne Plus-Zeichen und dann auf R Skript. Hier könnt ihr alle Befehle notieren und Erläuterungen, Kommentare und alles andere, was ihr im Gegensatz zu Befehlen nicht ausführen möchtet, mit einem **#** markieren. Mit **Enter** bestätigt ihr im Editor keine Befehle, sondern springt wie gewohnt eine Zeile weiter. Bedeutet das also, dass ihr eure Befehle zum Testen immer in die Konsole kopieren und ausführen müsst? Nein, ihr könnt die Befehle im Editor ausführen, indem ihr euren Cursor in die Zeile setzt und auf Run drückt. Das bedeutet, dass ihr jeden Befehl in eine eigene Zeile schreiben müsst.

Wozu dann noch die Konsole? Nun, um Grunde könnt ihr nur den Editor nutzen. Wenn ihr aber einen neuen Befehl ausprobieren möchtet, könnt ihr diesen auch einfach fix in die Konsole schreiben.

### Environment/History
Im oberen rechten Fenster gibt es zwei wichtige Reiter: Das Environment und die History. 

#### Environment
Im Environment werden euch sämtliche Datensätze, Variablen, Matrizen etc. aufgelistet, die ihr erstellt, eingelesen, definiert etc. habt. Stellt euer Environment am besten von List auf Grid, damit euch die Datentypen angezeigt werden.

#### History
In der History werden euch die Befehle aufgelistet, die ihr ausgeführt habt. Das könnt ihr nutzen, um eure Sitzung zurückzuverfolgen und nach Fehlern zu suchen.

### Plots/Packages/Files
Im unteren rechten Fenster gibt es drei Reiter, die besonders wichtig sind.

#### Plots
Im Reiter Plots werden euch die Visualisierungen eurer Netzwerke, also kleine Bilder angezeigt.

#### Packages
Im Reiter Packages werden euch die Pakete angezeigt, die ihr installiert habt. RStudio nutzt diese Pakete und die in ihnen liegenden Befehle, Datensätze etc.. Pakete könnt ihr im Reiter unter Install herunterladen. Im sich öffnenden Fenster gebt ihr den Namen des Pakets an und lasst install dependencies angehakt. Das Paket wird in der Konsole installiert und taucht danach im Reiter packages auf. Dort kann man es anhaken oder nicht: Bisher ist das Paket nämlich nur installiert. Um es nutzen zu können, müsst ihr es jedoch laden. Um es zu laden, müsst ihr den Haken setzen. Dann könnt ihr die Befehle nutzen, die das Paket zur Verfügung stellt. Infos über das Paket erhaltet ihr, wenn ihr auf dessen Namen in der Liste klickt. Das wichtigste Paket, das ihr installieren solltet, ist igraph. Aufgepasst: Pakete deinstallieren sich zwar (eigentlich) nicht, wenn ihr RStudio schließt, sie deaktivieren sich jedoch oft. Bei jeder Sitzung müsst ihr die gebrauchten Pakete also wieder neu laden, also die Häkchen setzen.

#### Files
Im Reiter Files findet ihr die Dateien, die ihr für euer Projekt verwenden wollt. Dabei arbeitet RStudio mit einem sogenannten Working Directory, das ihr dem Programm mitteilen müsst. Stellen wir es gemeinsam ein:

##### Working Directory definieren
Geht über Tools auf Global Options und wählt unter General auf browse. Wählt den Ordner aus, in dem ihr eure Dateien abspeichern wollt. Drückt auf Apply, Ok und startet RStudio neu. Wenn ihr im Reiter Files nun auf more (das blaue Rad) drückt und go to working directory wählt, zeigt euch RStudio euren Ordner an. Wenn ihr eure Skripte aus dem Editor abspeichert, speichert RStudio diese ebenfalls automatisch in diesem Verzeichnis ab.

## Einführung in GitHub
Auf GitHub könnt ihr mit euren Gruppenmitgliedern an einem Dokument arbeiten, ohne dass ihr gleichzeitig in einer Version „herumpfuscht“ oder mehrere Dokumente mit den Namen „final“, „final2“ oder „absolut_final“ habt. Dafür braucht ihr ein repository, das ihr in der letzten Stunde erstellt habt und müsst eure Gruppenmitglieder unter Settings > Collaborators einladen. Es gibt zwei Arten von Files, die ihr mit GitHub erstellen könnt: Normale Text-Files, die wie eure R Skripte in Kommandozeilen aufgebaut sind und Markdown Files, wie euer Readme File, in denen der Text formatiert wird. Um solche Dateien zu erstellen, bennent ihr eure neue Datei einfach „Name**.md**“. Eine kleine Anleitung zu markdown files findet ihr [hier](https://guides.github.com/features/mastering-markdown/). In euer Repository werden ihr später ebenfalls eure Edge- und Nodelists einstellen, die ihr im Unterricht noch kennenlernen werdet.

Unter Projects könnt ihr euch eine Art Trello-To-Do-List Übersicht erstellen, die euch bei der Absprache von Aufgaben ebenfalls behilflich ist.

### Wie arbeitet ihr mit GitHub?
In eurem Repository gibt es immer einen Hauptzweig, den master branch. In diesem liegen all eure Dateien, auch euer R Skript. Stellt euch vor, dass ihr beim Ausführen des Skripts in RStudio bemerkt, dass ein wichtiger Befehl im Skript fehlt. Um das Skript zu bearbeiten, geht ihr auf GitHub, klickt auf die Datei und bearbeitet sie in aller Ruhe. Ihr könnt die Datei entweder direkt im master branch ändern oder einen neuen Zweig erstellen, den ihr passend benennt. Dieser Zweig ist damit eine exakte Kopie des master branches, nur, dass eure Änderungen im Skript stehen. In euren Zweig könnt ihr in der Hauptansicht des Repositorys wechseln, indem ihr auf branches master drückt und euren Zweig auswählt. In eurem Zweig könnt ihr ganz sicher am Skript arbeiten, ohne dass am eigentlichen Skript im master branch etwas verändert wird. Seid ihr euch sicher mit euren Änderungen, könnt ihr eine Pull Request starten. Dort wählt ihr als Basis den master branch aus und als anderen Zweig euren neu erstellten. Die Dateien aus den Zweigen werden dann gemerged, also sozusagen um eure Änderungen erweitert. Diese Änderungen könnt ihr euch auch noch anschauen. Diese Pull Request könnte immer eine andere Person aus der Gruppe durchführen, damit sie noch einmal einen Blick über die Änderungen wirft.

Ihr könnt ebenfalls einen neuen Zweig erstellen, ohne erst auf das Dokument zu klicken und es zu verändern. Dafür drückt ihr in der Hauptansicht eures Repositorys ebenfalls auf branch master, gebt einen Namen ein und erstellt den neuen Zweig, der nun ebenfalls in diesem Drop-Down Menü ausgewählt werden kann. Dieser neue branch ist dann ebenfalls eine exakte Kopie des derzeitigen Master Branches und kann per Pull Request mit diesem gemerged werden.
