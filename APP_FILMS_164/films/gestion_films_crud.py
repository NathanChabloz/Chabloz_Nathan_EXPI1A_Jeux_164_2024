from datetime import timedelta
from pathlib import Path
from flask import redirect, request, session, url_for, flash, render_template
from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.films.gestion_films_wtf_forms import FormWTFUpdateFilm, FormWTFAddFilm, FormWTFDeleteFilm

@app.route("/film_add", methods=['GET', 'POST'])
def film_add_wtf():
    form_add_film = FormWTFAddFilm()

    if request.method == "POST":
        try:
            if form_add_film.validate_on_submit():
                nom_jeu_add = form_add_film.nom_jeu_add_wtf.data

                valeurs_insertion_dictionnaire = {"value_nom_jeu": nom_jeu_add}
                print("valeurs_insertion_dictionnaire ", valeurs_insertion_dictionnaire)

                strsql_insert_jeu = """INSERT INTO t_jeux (id_jeux, nom_jeu) VALUES (NULL,%(value_nom_jeu)s) """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_jeu, valeurs_insertion_dictionnaire)

                flash(f"Données insérées !!", "success")
                print(f"Données insérées !!")

                return redirect(url_for('films_genres_afficher', id_film_sel=0))

        except Exception as Exception_genres_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  "
                                            f"{film_add_wtf.__name__} ; "
                                            f"{Exception_genres_ajouter_wtf}")

    return render_template("films/film_add_wtf.html", form_add_film=form_add_film)


@app.route("/film_update", methods=['GET', 'POST'])
def film_update_wtf():
    id_jeux_update = request.values['id_film_btn_edit_html']
    form_update_jeu = FormWTFUpdateFilm()
    try:
        if request.method == "POST" and form_update_jeu.submit.data:
            nom_jeu_update = form_update_jeu.nom_jeu_update_wtf.data
            duree_moyenne_jeu_update = form_update_jeu.duree_moyenne_jeu_update_wtf.data
            joueurs_min_update = form_update_jeu.joueurs_min_update_wtf.data
            joueurs_max_update = form_update_jeu.joueurs_max_update_wtf.data
            date_sortie_jeu_update = form_update_jeu.date_sortie_jeu_update_wtf.data
            age_min_update = form_update_jeu.age_min_update_wtf.data
            age_max_update = form_update_jeu.age_max_update_wtf.data
            image_jeu_update = form_update_jeu.image_jeu_update_wtf.data

            valeur_update_dictionnaire = {
                "value_id_jeux": id_jeux_update,
                "value_nom_jeu": nom_jeu_update,
                "value_duree_moyenne_jeu": duree_moyenne_jeu_update,
                "value_joueurs_min": joueurs_min_update,
                "value_joueurs_max": joueurs_max_update,
                "value_date_sortie_jeu": date_sortie_jeu_update,
                "value_age_min": age_min_update,
                "value_age_max": age_max_update,
                "value_image_jeu": image_jeu_update
            }

            print("valeur_update_dictionnaire ", valeur_update_dictionnaire)

            str_sql_update_nom_film = """UPDATE t_jeux SET nom_jeu = %(value_nom_jeu)s,
                                                                        durée_moyenne = %(value_duree_moyenne_jeu)s,
                                                                        date_sortie_jeux = %(value_date_sortie_jeu)s,
                                                                        joueurs_min = %(value_joueurs_min)s,
                                                                        joueurs_max = %(value_joueurs_max)s,
                                                                        age_min = %(value_age_min)s,
                                                                        age_max = %(value_age_max)s,
                                                                        image_jeux = %(value_image_jeu)s
                                                                        WHERE id_jeux = %(value_id_jeux)s"""

            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_update_nom_film, valeur_update_dictionnaire)

            flash(f"Donnée mise à jour !!", "success")
            print(f"Donnée mise à jour !!")

            return redirect(url_for('films_genres_afficher', id_film_sel=0))

        # Récupération des données du jeu à mettre à jour
        str_sql_id_film = "SELECT * FROM t_jeux WHERE id_jeux = %(value_id_jeux)s"
        valeur_select_dictionnaire = {"value_id_jeux": id_jeux_update}
        with DBconnection() as mybd_conn:
            mybd_conn.execute(str_sql_id_film, valeur_select_dictionnaire)
            data_film = mybd_conn.fetchone()

            # Pré-remplir les champs du formulaire avec les données du jeu à mettre à jour
            form_update_jeu.nom_jeu_update_wtf.data = data_film["nom_jeu"]
            form_update_jeu.duree_moyenne_jeu_update_wtf.data = data_film["durée_moyenne"]
            form_update_jeu.joueurs_min_update_wtf.data = data_film["joueurs_min"]
            form_update_jeu.joueurs_max_update_wtf.data = data_film["joueurs_max"]
            form_update_jeu.date_sortie_jeu_update_wtf.data = data_film["date_sortie_jeux"]
            form_update_jeu.age_min_update_wtf.data = data_film["age_min"]
            form_update_jeu.age_max_update_wtf.data = data_film["age_max"]
            form_update_jeu.image_jeu_update_wtf.data = data_film["image_jeux"]

    except Exception as Exception_film_update_wtf:
        raise ExceptionFilmUpdateWtf(f"fichier : {Path(__file__).name}  ;  "
                                     f"{film_update_wtf.__name__} ; "
                                     f"{Exception_film_update_wtf}")

    return render_template("films/film_update_wtf.html", form_update_jeu=form_update_jeu)


@app.route("/film_delete", methods=['GET', 'POST'])
def film_delete_wtf():
    # Pour afficher ou cacher les boutons "EFFACER"
    data_film_delete = None
    btn_submit_del = None
    # L'utilisateur vient de cliquer sur le bouton "DELETE". Récupère la valeur de "id_film"
    id_film_delete = request.values['id_film_btn_delete_html']

    # Objet formulaire pour effacer le film sélectionné.
    form_delete_film = FormWTFDeleteFilm()
    try:
        # Si on clique sur "ANNULER", afficher tous les films.
        if form_delete_film.submit_btn_annuler.data:
            return redirect(url_for("films_genres_afficher", id_film_sel=0))

        if form_delete_film.submit_btn_conf_del_jeu.data:
            # Récupère les données afin d'afficher à nouveau
            # le formulaire "films/film_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
            data_film_delete = session['data_film_delete']
            print("data_film_delete ", data_film_delete)

            flash(f"Effacer le film de façon définitive de la BD !!!", "danger")
            # L'utilisateur vient de cliquer sur le bouton de confirmation pour effacer...
            # On affiche le bouton "Effacer genre" qui va irrémédiablement EFFACER le genre
            btn_submit_del = True

        # L'utilisateur a vraiment décidé d'effacer.
        if form_delete_film.submit_btn_del_film.data:
            valeur_delete_dictionnaire = {"value_id_film": id_film_delete}
            print("valeur_delete_dictionnaire ", valeur_delete_dictionnaire)

            str_sql_delete_fk_film_genre = """DELETE FROM t_catégorie_jeux WHERE fk_jeux = %(value_id_film)s"""
            str_sql_delete_film = """DELETE FROM t_jeux WHERE id_jeux = %(value_id_film)s"""
            # Manière brutale d'effacer d'abord la "fk_film", même si elle n'existe pas dans la "t_genre_film"
            # Ensuite on peut effacer le film vu qu'il n'est plus "lié" (INNODB) dans la "t_genre_film"
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_delete_fk_film_genre, valeur_delete_dictionnaire)
                mconn_bd.execute(str_sql_delete_film, valeur_delete_dictionnaire)

            flash(f"Film définitivement effacé !!", "success")
            print(f"Film définitivement effacé !!")

            # afficher les données
            return redirect(url_for('films_genres_afficher', id_film_sel=0))
        if request.method == "GET":
            valeur_select_dictionnaire = {"value_id_film": id_film_delete}
            print(id_film_delete, type(id_film_delete))

            # Requête qui affiche le film qui doit être efffacé.
            str_sql_genres_films_delete = """SELECT * FROM t_jeux WHERE id_jeux = %(value_id_film)s"""

            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_genres_films_delete, valeur_select_dictionnaire)
                data_film_delete = mydb_conn.fetchall()
                print("data_film_delete...", data_film_delete)

                # Nécessaire pour mémoriser les données afin d'afficher à nouveau
                # le formulaire "films/film_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                session['data_film_delete'] = data_film_delete

            # Le bouton pour l'action "DELETE" dans le form. "film_delete_wtf.html" est caché.
            btn_submit_del = False

    except Exception as Exception_film_delete_wtf:
        raise ExceptionFilmDeleteWtf(f"fichier : {Path(__file__).name}  ;  "
                                     f"{film_delete_wtf.__name__} ; "
                                     f"{Exception_film_delete_wtf}")

    return render_template("films/film_delete_wtf.html",
                           form_delete_film=form_delete_film,
                           btn_submit_del=btn_submit_del,
                           data_film_del=data_film_delete
                           )