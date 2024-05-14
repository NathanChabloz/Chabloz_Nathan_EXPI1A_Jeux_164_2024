from pathlib import Path
from flask import redirect, request, session, url_for, flash, render_template
from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFAjouterGenres, FormWTFDeleteGenre, FormWTFUpdateGenre

@app.route("/genres_afficher/<string:order_by>/<int:id_genre_sel>", methods=['GET', 'POST'])
def genres_afficher(order_by, id_genre_sel):
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                if order_by == "ASC" and id_genre_sel == 0:
                    strsql_categore_afficher = """SELECT * FROM t_catégorie ORDER BY id_categorie ASC"""
                elif order_by == "ASC":
                    strsql_categore_afficher = """SELECT * FROM t_catégorie WHERE id_categorie = %(value_id_categorie_selected)s ORDER BY id_categorie"""
                else:
                    strsql_categore_afficher = """SELECT * FROM t_catégorie ORDER BY id_categorie DESC"""

                mc_afficher.execute(strsql_categore_afficher, {"value_id_categorie_selected": id_genre_sel})
                data_genres = mc_afficher.fetchall()

                if not data_genres and id_genre_sel == 0:
                    flash("""La table "t_catégorie" est vide. !!""", "warning")
                elif not data_genres and id_genre_sel > 0:
                    flash(f"La catégorie demandée n'existe pas !!", "warning")
                else:
                    flash(f"Données catégorie affichées !!", "success")
        except Exception as Exception_genres_afficher:
            raise ExceptionGenresAfficher(f"fichier : {Path(__file__).name}  ;  {genres_afficher.__name__} ; {Exception_genres_afficher}")

    return render_template("genres/genres_afficher.html", data=data_genres)

@app.route("/categorie_ajouter", methods=['GET', 'POST'])
def genres_ajouter_wtf():
    form = FormWTFAjouterGenres()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                name_genre_wtf = form.nom_genre_wtf.data.lower()
                strsql_insert_genre = """INSERT INTO t_catégorie (id_categorie, nom_categorie) VALUES (NULL, %(value_intitule_genre)s)"""
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_genre, {"value_intitule_genre": name_genre_wtf})
                flash(f"Données insérées !!", "success")
                return redirect(url_for('genres_afficher', order_by='DESC', id_genre_sel=0))
        except Exception as Exception_genres_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  {genres_ajouter_wtf.__name__} ; {Exception_genres_ajouter_wtf}")
    return render_template("genres/genres_ajouter_wtf.html", form=form)

@app.route("/genre_update", methods=['GET', 'POST'])
def genre_update_wtf():
    id_genre_update = request.values['id_genre_btn_edit_html']
    form_update = FormWTFUpdateGenre()
    try:
        if request.method == "POST" and form_update.submit.data:
            name_genre_update = form_update.nom_genre_update_wtf.data.lower()
            str_sql_update_intitulegenre = """UPDATE t_catégorie SET nom_categorie = %(value_name_genre)s WHERE id_categorie = %(value_id_genre)s"""
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_update_intitulegenre, {"value_id_genre": id_genre_update, "value_name_genre": name_genre_update})
            flash(f"Donnée mise à jour !!", "success")
            return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=id_genre_update))
        elif request.method == "GET":
            str_sql_id_genre = "SELECT id_categorie, nom_categorie FROM t_catégorie WHERE id_categorie = %(value_id_genre)s"
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_id_genre, {"value_id_genre": id_genre_update})
                data_nom_genre = mybd_conn.fetchone()
            if data_nom_genre:
                form_update.nom_genre_update_wtf.data = data_nom_genre["nom_categorie"]
            else:
                flash("Erreur : données non trouvées", "danger")
                return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=id_genre_update))
    except Exception as Exception_genre_update_wtf:
        raise ExceptionGenreUpdateWtf(f"fichier : {Path(__file__).name}  ;  {genre_update_wtf.__name__} ; {Exception_genre_update_wtf}")
    return render_template("genres/genre_update_wtf.html", form_update=form_update)

@app.route("/genre_delete", methods=['GET', 'POST'])
def genre_delete_wtf():
    data_films_attribue_genre_delete = None
    btn_submit_del = None
    id_genre_delete = request.values['id_genre_btn_delete_html']
    form_delete = FormWTFDeleteGenre()
    try:
        if request.method == "POST" and form_delete.validate_on_submit():
            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("genres_afficher", order_by="ASC", id_genre_sel=0))
            if form_delete.submit_btn_conf_del.data:
                data_films_attribue_genre_delete = session['data_films_attribue_genre_delete']
                flash(f"Effacer le genre de façon définitive de la BD !!!", "danger")
                btn_submit_del = True
            if form_delete.submit_btn_del.data:
                with DBconnection() as mconn_bd:
                    mconn_bd.execute("""DELETE FROM t_catégorie_jeux WHERE fk_catégorie = %(value_id_genre)s""", {"value_id_genre": id_genre_delete})
                    mconn_bd.execute("""DELETE FROM t_catégorie WHERE id_categorie = %(value_id_genre)s""", {"value_id_genre": id_genre_delete})
                flash(f"Genre définitivement effacé !!", "success")
                return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))
        if request.method == "GET":
            with DBconnection() as mydb_conn:
                mydb_conn.execute("""SELECT id_catégorie_jeux, nom_jeu, id_categorie, nom_categorie FROM t_catégorie_jeux 
                                     INNER JOIN t_jeux ON t_catégorie_jeux.fk_jeux = t_jeux.id_jeux
                                     INNER JOIN t_catégorie ON t_catégorie_jeux.fk_catégorie = t_catégorie.id_categorie
                                     WHERE fk_catégorie = %(value_id_genre)s""", {"value_id_genre": id_genre_delete})
                data_films_attribue_genre_delete = mydb_conn.fetchall()
                session['data_films_attribue_genre_delete'] = data_films_attribue_genre_delete
                str_sql_id_genre = "SELECT id_categorie, nom_categorie FROM t_catégorie WHERE id_categorie = %(value_id_genre)s"
                mydb_conn.execute(str_sql_id_genre, {"value_id_genre": id_genre_delete})
                data_nom_genre = mydb_conn.fetchone()
            form_delete.nom_genre_delete_wtf.data = data_nom_genre["nom_categorie"]
            btn_submit_del = False
    except Exception as Exception_genre_delete_wtf:
        raise ExceptionGenreDeleteWtf(f"fichier : {Path(__file__).name}  ;  {genre_delete_wtf.__name__} ; {Exception_genre_delete_wtf}")
    return render_template("genres/genre_delete_wtf.html", form_delete=form_delete, btn_submit_del=btn_submit_del, data_films_associes=data_films_attribue_genre_delete)
