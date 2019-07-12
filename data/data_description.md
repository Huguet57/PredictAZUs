# Data Description
En aquest document es descriuen les dades de les que disposem.

## attendance_1719.csv
Aquest fitxer conté el nombre d'assistents per assaig.

>COMPTE! dóna la sensació que no hi ha assajos de pilars.

Hi ha 96 entrades.

## attendance_detailed_1719.csv
Aquest fitxer conté l'assistència detallada per cada casteller i assaig.

>COMPTE! Encara s'hauria de fer una mica de neteja en aquest fitxer, ja que hi ha hores que no quadren gaire i, si es soluciona, potser es podria solucionar el problema de la falta de dades d'assajos de pilars.

Hi ha 32,465 registres que contenen els camps següents:
- date
- hour
- id_assaig
- id_casteller
- attendance

## castellers_2019.csv
Aquest fitxer conté la base de dades de castellers entre 2017 i 2019.

Hi ha 448 registres que contenen els camps següents:
- id_casteller
- sex
    - male: 233
    - female: 215
- height
- active
    - yes: 150
    - no: 165
    - newbie: 133
- type_casteller:
    - agulles: 10
    - altres: 65
    - baixos: 55
    - contraforts: 36
    - crosses: 91
    - falques: 41
    - laterals: 90
    - novell: 19
    - rengla: 40
    - *nan*: 1
