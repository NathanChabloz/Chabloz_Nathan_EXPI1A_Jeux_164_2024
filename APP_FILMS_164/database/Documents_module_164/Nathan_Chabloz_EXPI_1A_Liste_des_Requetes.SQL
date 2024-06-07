-- Requête pour afficher toutes les catégories en ordre croissant
SELECT * FROM t_catégorie ORDER BY id_categorie ASC;

-- Requête pour afficher une catégorie spécifique en ordre croissant
SELECT * FROM t_catégorie WHERE id_categorie = 1 ORDER BY id_categorie;

-- Requête pour afficher toutes les catégories en ordre décroissant
SELECT * FROM t_catégorie ORDER BY id_categorie DESC;

-- Requête pour insérer une nouvelle catégorie
INSERT INTO t_catégorie (id_categorie, nom_categorie) VALUES (NULL, 'nouvelle_categorie');

-- Requête pour mettre à jour le nom d'une catégorie
UPDATE t_catégorie SET nom_categorie = 'nom_mis_a_jour' WHERE id_categorie = 2;

-- Requête pour sélectionner une catégorie par ID
SELECT id_categorie, nom_categorie FROM t_catégorie WHERE id_categorie = 2;

-- Requête pour supprimer les associations d'une catégorie avec des jeux
DELETE FROM t_catégorie_jeux WHERE fk_catégorie = 3;

-- Requête pour supprimer une catégorie
DELETE FROM t_catégorie WHERE id_categorie = 3;

-- Requête pour récupérer les jeux associés à une catégorie
SELECT id_catégorie_jeux, nom_jeu, id_categorie, nom_categorie FROM t_catégorie_jeux
INNER JOIN t_jeux ON t_catégorie_jeux.fk_jeux = t_jeux.id_jeux
INNER JOIN t_catégorie ON t_catégorie_jeux.fk_catégorie = t_catégorie.id_categorie
WHERE fk_catégorie = 3;

-- Requête pour consulter une catégorie par ID
SELECT * FROM t_catégorie WHERE id_categorie = 4;

-- Requête pour récupérer les jeux dans une catégorie spécifique
SELECT * FROM t_jeux
INNER JOIN t_catégorie_jeux
ON t_jeux.id_jeux = t_catégorie_jeux.FK_jeux
WHERE t_catégorie_jeux.FK_catégorie = 4;

-- Sélectionne les films avec les genres associés pour chaque film
SELECT id_jeux, nom_jeu, durée_moyenne, joueurs_min, joueurs_max, image_jeux, date_sortie_jeux, age_min, age_max,
       GROUP_CONCAT(id_categorie) AS GenresFilms
FROM t_catégorie_jeux
INNER JOIN t_jeux ON t_jeux.id_jeux = t_catégorie_jeux.fk_jeux
INNER JOIN t_catégorie ON t_catégorie.id_categorie = t_catégorie_jeux.fk_catégorie
WHERE id_jeux = %(value_id_film_selected)s

-- Sélectionne les genres non attribués au film sélectionné
SELECT id_categorie, nom_categorie
FROM t_catégorie
WHERE id_categorie NOT IN (
    SELECT id_categorie AS idGenresFilms
    FROM t_catégorie_jeux
    INNER JOIN t_jeux ON t_jeux.id_jeux = t_catégorie_jeux.fk_jeux
    INNER JOIN t_catégorie ON t_catégorie.id_categorie = t_catégorie_jeux.fk_catégorie
    WHERE id_jeux = %(value_id_film_selected)s
)

-- Sélectionne les genres attribués au film sélectionné
SELECT id_jeux, id_categorie, nom_categorie
FROM t_catégorie_jeux
INNER JOIN t_jeux ON t_jeux.id_jeux = t_catégorie_jeux.fk_jeux
INNER JOIN t_catégorie ON t_catégorie.id_categorie = t_catégorie_jeux.fk_catégorie
WHERE id_jeux = %(value_id_film_selected)s

-- Insère une nouvelle association entre un film et un genre dans t_catégorie_jeux
INSERT INTO t_catégorie_jeux (id_catégorie_jeux, fk_catégorie, fk_jeux)
VALUES (NULL, %(value_fk_genre)s, %(value_fk_film)s)

-- Efface une (des) association(s) existante(s) entre un film et un genre dans t_catégorie_jeux
DELETE FROM t_catégorie_jeux
WHERE fk_catégorie = %(value_fk_genre)s AND fk_jeux = %(value_fk_film)s

-- Insertion d'un nouveau film
INSERT INTO t_jeux (id_jeux, nom_jeu) VALUES (NULL, 'Nom_du_nouveau_jeu');

-- Mise à jour des informations d'un film
UPDATE t_jeux SET nom_jeu = 'Nouveau_nom',
                    durée_moyenne = 'Nouvelle_durée',
                    date_sortie_jeux = 'Nouvelle_date_de_sortie',
                    joueurs_min = 'Nouveau_nombre_de_joueurs_min',
                    joueurs_max = 'Nouveau_nombre_de_joueurs_max',
                    age_min = 'Nouvel_age_min',
                    age_max = 'Nouvel_age_max',
                    image_jeux = 'Nouvelle_image'
                    WHERE id_jeux = 'ID_du_jeu_a_metre_a_jour';

-- Suppression d'un film de la base de données
DELETE FROM t_jeux WHERE id_jeux = 'ID_du_film_a_effacer';

-- Suppression des associations entre un film et ses genres
DELETE FROM t_catégorie_jeux WHERE fk_jeux = 'ID_du_film_a_effacer';