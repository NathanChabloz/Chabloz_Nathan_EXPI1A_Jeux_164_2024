# Module 164 2024.03.26

Le "début de la fin"

Le mode d'emploi et vos devoirs se trouvent à l'adresse suivante.

https://info164.github.io/doc164ver1/index.html

Je suis surement con mais je fais 2 dépot GIT : 1 Avec la partie client web et code | 2 Avec la partie doc du projet, la DB, mcd/mld
------------------------------------------------------------------------------------------------------------------------------------------------------------
# Bienvenue dans ce tuto qui je l'éspère marchera pour mon projet afin d'avoir un beau 6 et de pas me faire exclure de chez moi :(

## Les prérequis : 
- Installer Laragon-Full
- Installer Python en cochant bien la case "PATH" et ciquer sur "disabled length limit"
- Installer PyCharm community version et s'assurer que python est configuré en interpreter
## La procédure 
- Lancer Laragon puis "Start" puis "Base de donnée"
- Importer la base de donnée "FASOLETTI_EVAN_EXPI1A_GUNPLA.SQL" dans Laragon
- Lancer pycharm et ouvrez le projet se trouvant dans le dossier "FASOLETTI_EVAN_EXPI1A_GUNPLA_164_2024"
- Ouvrez le fichier .env et assurez vous que le port, le nom de la BD et son emplacement et correctement défini
- Clic droit sur le fichier "run_mon_app.py" puis "Run"
La console devrait vous afficher une adresse localhost, normalement 127.0.0.1:5000 |127.0.0.1 étant l'ip et 5000 le port flask
## Les échecs 
J'aurais voulu créer une page "page_browse.html" qui créer un bouton Browse a coté des 3 autres et lorsque on clic dessus, on peut parcourir tous les produits se trouvant dans cette catégorie
