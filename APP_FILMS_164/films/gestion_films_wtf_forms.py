"""Gestion des formulaires avec WTF pour les jeux
Fichier : gestion_jeux_wtf_forms.py
Auteur : OM 2022.04.11

"""
from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField
from wtforms import SubmitField
from wtforms.validators import Length, InputRequired, NumberRange, DataRequired
from wtforms.validators import Regexp
from wtforms.widgets import TextArea


class FormWTFAddFilm(FlaskForm):
    """
        Dans le formulaire "jeux_ajouter_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    nom_jeu_regexp = ""
    nom_jeu_add_wtf = StringField("Nom du jeu ", validators=[Length(min=2, max=2000, message="min 2 max 20"),
                                                             Regexp(nom_jeu_regexp,
                                                                    message="Pas de chiffres, de caractères "
                                                                            "spéciaux, "
                                                                            "d'espace à double, de double "
                                                                            "apostrophe, de double trait union")
                                                             ])

    submit = SubmitField("Enregistrer jeu")

class FormWTFUpdateFilm(FlaskForm):
    id_jeux_update_wtf = IntegerField("ID du jeu à mettre à jour", validators=[DataRequired()])
    nom_jeu_update_wtf = StringField("Nom du jeu", widget=TextArea())
    duree_moyenne_jeu_update_wtf = IntegerField("Durée moyenne du jeu", validators=[NumberRange(min=1, max=5000,
                                                                                            message=u"Min %(min)d et "
                                                                                                    u"max %(max)d "
                                                                                                    u"Selon Wikipédia "
                                                                                                    u"L'Incendie du "
                                                                                                    u"monastère du "
                                                                                                    u"Lotus rouge "
                                                                                                    u"durée 1620 "
                                                                                                    u"min")])
    date_sortie_jeu_update_wtf = DateField("Date de sortie du film", validators=[InputRequired("Date obligatoire"),
                                                                                 DataRequired("Date non valide")])
    joueurs_min_update_wtf = IntegerField("Nombre de joueurs minimum")
    joueurs_max_update_wtf = IntegerField("Nombre de joueurs maximum")
    age_min_update_wtf = IntegerField("Âge minimum")
    age_max_update_wtf = IntegerField("Âge maximum")
    image_jeu_update_wtf = StringField("Lien de l'image du jeu")
    submit = SubmitField("Update jeu")

class FormWTFDeleteFilm(FlaskForm):
    """
        Dans le formulaire "jeu_delete_wtf.html"

        nom_jeu_delete_wtf : Champ qui reçoit la valeur du jeu, lecture seule. (readonly=true)
        submit_btn_del_jeu : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del_jeu : Bouton de confirmation pour effacer un "jeu".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_jeu".
    """
    nom_jeu_delete_wtf = StringField("Effacer ce jeu")
    submit_btn_del_jeu = SubmitField("Effacer jeu")
    submit_btn_conf_del_jeu = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")
