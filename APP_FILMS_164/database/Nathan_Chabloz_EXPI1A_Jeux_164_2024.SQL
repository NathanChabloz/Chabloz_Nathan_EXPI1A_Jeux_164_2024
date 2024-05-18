-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour nathan_chabloz_expi1a_jeux_164_2024
DROP DATABASE IF EXISTS `nathan_chabloz_expi1a_jeux_164_2024`;
CREATE DATABASE IF NOT EXISTS `nathan_chabloz_expi1a_jeux_164_2024` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nathan_chabloz_expi1a_jeux_164_2024`;

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_adresse
DROP TABLE IF EXISTS `t_adresse`;
CREATE TABLE IF NOT EXISTS `t_adresse` (
  `id_adresse` int NOT NULL AUTO_INCREMENT,
  `FK_compte_adresse` int NOT NULL DEFAULT '0',
  `FK_fournisseur_adresse` int NOT NULL DEFAULT '0',
  `adresse_personne` varchar(50) DEFAULT NULL,
  `NPA_personne` int DEFAULT NULL,
  `ville_personne` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_adresse`),
  KEY `fk_adresse_compte` (`FK_compte_adresse`),
  KEY `FK_t_adresse_t_fournisseur` (`FK_fournisseur_adresse`) USING BTREE,
  CONSTRAINT `fk_adresse_compte` FOREIGN KEY (`FK_compte_adresse`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `FK_t_adresse_t_compte` FOREIGN KEY (`FK_compte_adresse`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `FK_t_adresse_t_fournisseur` FOREIGN KEY (`FK_fournisseur_adresse`) REFERENCES `t_fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_adresse : ~20 rows (environ)
INSERT INTO `t_adresse` (`id_adresse`, `FK_compte_adresse`, `FK_fournisseur_adresse`, `adresse_personne`, `NPA_personne`, `ville_personne`) VALUES
	(1, 16, 1, 'Adresse 30', 8022, 'Ville'),
	(2, 9, 14, 'Adresse 70', 9038, 'Ville'),
	(3, 4, 12, 'Adresse 99', 3817, 'Ville'),
	(4, 16, 12, 'Adresse 91', 3482, 'Ville'),
	(5, 5, 9, 'Adresse 75', 5296, 'Ville'),
	(6, 5, 17, 'Adresse 63', 7216, 'Ville'),
	(7, 17, 19, 'Adresse 67', 9805, 'Ville'),
	(8, 17, 20, 'Adresse 96', 7436, 'Ville'),
	(9, 4, 16, 'Adresse 81', 5237, 'Ville'),
	(10, 16, 3, 'Adresse 31', 5697, 'Ville'),
	(11, 9, 20, 'Adresse 17', 7929, 'Ville'),
	(12, 8, 19, 'Adresse 40', 9185, 'Ville'),
	(13, 2, 2, 'Adresse 91', 2208, 'Ville'),
	(14, 3, 16, 'Adresse 90', 2378, 'Ville'),
	(15, 5, 17, 'Adresse 10', 5572, 'Ville'),
	(16, 14, 18, 'Adresse 48', 5253, 'Ville'),
	(17, 11, 5, 'Adresse 89', 5214, 'Ville'),
	(18, 5, 14, 'Adresse 38', 3870, 'Ville'),
	(19, 11, 17, 'Adresse 81', 9933, 'Ville'),
	(20, 18, 3, 'Adresse 88', 8432, 'Ville');

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_catégorie
DROP TABLE IF EXISTS `t_catégorie`;
CREATE TABLE IF NOT EXISTS `t_catégorie` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_catégorie : ~26 rows (environ)
INSERT INTO `t_catégorie` (`id_categorie`, `nom_categorie`) VALUES
	(2, 'familial'),
	(3, 'mots et langages'),
	(4, 'Dextérité'),
	(5, 'Stratégie'),
	(6, 'Stratégie'),
	(7, 'Cartes'),
	(8, 'Coopératif'),
	(9, 'Stratégie'),
	(10, 'Parti'),
	(11, 'Parti'),
	(12, 'Familial'),
	(13, 'Stratégie'),
	(14, 'Imagination'),
	(15, 'Stratégie'),
	(16, 'Familial'),
	(17, 'Stratégie'),
	(18, 'Stratégie'),
	(19, 'Stratégie'),
	(20, 'Stratégie'),
	(39, 'Bonjour'),
	(40, 'Fuckevan'),
	(41, 'merdique'),
	(43, 'test'),
	(46, 'stratégie');

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_catégorie_jeux
DROP TABLE IF EXISTS `t_catégorie_jeux`;
CREATE TABLE IF NOT EXISTS `t_catégorie_jeux` (
  `id_catégorie_jeux` int NOT NULL AUTO_INCREMENT,
  `FK_catégorie` int NOT NULL DEFAULT '0',
  `FK_jeux` int DEFAULT NULL,
  PRIMARY KEY (`id_catégorie_jeux`),
  KEY `FK_t_catégorie_jeux_t_catégorie` (`FK_catégorie`),
  KEY `FK_t_catégorie_jeux_t_jeux` (`FK_jeux`),
  CONSTRAINT `FK_t_catégorie_jeux_t_catégorie` FOREIGN KEY (`FK_catégorie`) REFERENCES `t_catégorie` (`id_categorie`),
  CONSTRAINT `FK_t_catégorie_jeux_t_jeux` FOREIGN KEY (`FK_jeux`) REFERENCES `t_jeux` (`id_jeux`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_catégorie_jeux : ~26 rows (environ)
INSERT INTO `t_catégorie_jeux` (`id_catégorie_jeux`, `FK_catégorie`, `FK_jeux`) VALUES
	(1, 2, 8),
	(2, 7, 3),
	(3, 8, 17),
	(4, 6, 2),
	(5, 2, 8),
	(7, 14, 9),
	(8, 17, 10),
	(9, 9, 10),
	(10, 9, 10),
	(11, 3, 2),
	(13, 6, 7),
	(14, 19, 19),
	(15, 15, 19),
	(16, 19, 6),
	(17, 9, 10),
	(18, 16, 2),
	(19, 17, 17),
	(20, 18, 17),
	(22, 17, 1),
	(23, 43, 1),
	(24, 13, 1),
	(25, 41, 1),
	(28, 40, 1),
	(29, 46, 1),
	(30, 9, 205),
	(31, 4, 205),
	(32, 7, 205),
	(33, 11, 1);

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_compte
DROP TABLE IF EXISTS `t_compte`;
CREATE TABLE IF NOT EXISTS `t_compte` (
  `id_compte` int NOT NULL AUTO_INCREMENT,
  `prenom_utilisateur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nom_utilisateur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_naissance_utilisateur` date DEFAULT NULL,
  `mail_utilisateur` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `num_tel_utilisateur` int DEFAULT NULL,
  PRIMARY KEY (`id_compte`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_compte : ~20 rows (environ)
INSERT INTO `t_compte` (`id_compte`, `prenom_utilisateur`, `nom_utilisateur`, `date_naissance_utilisateur`, `mail_utilisateur`, `num_tel_utilisateur`) VALUES
	(1, 'John', 'Doe', '1990-01-01', 'john.doe@example.com', 123456789),
	(2, 'Alice', 'Smith', '1992-05-15', 'alice.smith@example.com', 987654321),
	(3, 'Bob', 'Johnson', '1985-11-30', 'bob.johnson@example.com', 456123789),
	(4, 'Emma', 'Davis', '1988-08-20', 'emma.davis@example.com', 789123456),
	(5, 'Michael', 'Wilson', '1995-03-10', 'michael.wilson@example.com', 321654987),
	(6, 'Sophia', 'Martinez', '1993-12-25', 'sophia.martinez@example.com', 654987321),
	(7, 'David', 'Anderson', '1991-06-05', 'david.anderson@example.com', 987321654),
	(8, 'Olivia', 'Taylor', '1987-09-12', 'olivia.taylor@example.com', 456789123),
	(9, 'James', 'Brown', '1984-04-18', 'james.brown@example.com', 321789456),
	(10, 'Emily', 'Garcia', '1994-02-28', 'emily.garcia@example.com', 789654123),
	(11, 'Daniel', 'Harris', '1989-07-08', 'daniel.harris@example.com', 654321789),
	(12, 'Charlotte', 'Lee', '1997-10-22', 'charlotte.lee@example.com', 123789654),
	(13, 'Alexander', 'Wang', '1996-09-15', 'alexander.wang@example.com', 987456321),
	(14, 'Mia', 'Thompson', '1998-11-05', 'mia.thompson@example.com', 321987654),
	(15, 'Ethan', 'White', '1986-06-30', 'ethan.white@example.com', 456789321),
	(16, 'Isabella', 'Lopez', '1990-03-20', 'isabella.lopez@example.com', 789654321),
	(17, 'William', 'King', '1983-08-08', 'william.king@example.com', 654123789),
	(18, 'Ava', 'Hall', '1999-01-12', 'ava.hall@example.com', 321789654),
	(19, 'Liam', 'Young', '1992-07-25', 'liam.young@example.com', 987654123),
	(20, 'Sofia', 'Clark', '1995-05-30', 'sofia.clark@example.com', 789123654);

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_compte_jeux_posséder
DROP TABLE IF EXISTS `t_compte_jeux_posséder`;
CREATE TABLE IF NOT EXISTS `t_compte_jeux_posséder` (
  `id_compte_jeux_posséder` int NOT NULL AUTO_INCREMENT,
  `FK_compte_posséder` int NOT NULL DEFAULT '0',
  `FK_jeux_posséder` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_compte_jeux_posséder`) USING BTREE,
  KEY `FK_t_compte_jeux_posséder_t_compte` (`FK_compte_posséder`),
  KEY `FK_t_compte_jeux_posséder_t_jeux` (`FK_jeux_posséder`),
  CONSTRAINT `FK_t_compte_jeux_posséder_t_compte` FOREIGN KEY (`FK_compte_posséder`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `FK_t_compte_jeux_posséder_t_jeux` FOREIGN KEY (`FK_jeux_posséder`) REFERENCES `t_jeux` (`id_jeux`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_compte_jeux_posséder : ~0 rows (environ)

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_compte_jeux_rechercher
DROP TABLE IF EXISTS `t_compte_jeux_rechercher`;
CREATE TABLE IF NOT EXISTS `t_compte_jeux_rechercher` (
  `id_compte_jeux_rechercher` int NOT NULL AUTO_INCREMENT,
  `FK_compte_rechercher` int NOT NULL DEFAULT '0',
  `FK_jeux_rechercher` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_compte_jeux_rechercher`) USING BTREE,
  KEY `FK_t_compte_jeux_rechercher_t_compte` (`FK_compte_rechercher`),
  KEY `FK_t_compte_jeux_rechercher_t_jeux` (`FK_jeux_rechercher`),
  CONSTRAINT `FK_t_compte_jeux_rechercher_t_compte` FOREIGN KEY (`FK_compte_rechercher`) REFERENCES `t_compte` (`id_compte`),
  CONSTRAINT `FK_t_compte_jeux_rechercher_t_jeux` FOREIGN KEY (`FK_jeux_rechercher`) REFERENCES `t_jeux` (`id_jeux`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_compte_jeux_rechercher : ~0 rows (environ)

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_fournisseur
DROP TABLE IF EXISTS `t_fournisseur`;
CREATE TABLE IF NOT EXISTS `t_fournisseur` (
  `id_fournisseur` int NOT NULL AUTO_INCREMENT,
  `nom_fournisseur` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_fournisseur : ~20 rows (environ)
INSERT INTO `t_fournisseur` (`id_fournisseur`, `nom_fournisseur`) VALUES
	(1, 'Hasbro'),
	(2, 'Asmodee'),
	(3, 'Z-Man Games'),
	(4, 'Ravensburger'),
	(5, 'Days of Wonder'),
	(6, 'Mayfair Games'),
	(7, 'Mattel'),
	(8, 'Z-Man Games'),
	(9, 'Hasbro'),
	(10, 'Czech Games Edition'),
	(11, 'Repos Production'),
	(12, 'Blue Orange Games'),
	(13, 'Rio Grande Games'),
	(14, 'Libellud'),
	(15, 'Rio Grande Games'),
	(16, 'Hans im Glück'),
	(17, 'Days of Wonder'),
	(18, 'Days of Wonder'),
	(19, 'Renegade Game Studios'),
	(20, 'Space Cowboys');

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_fournisseur_jeux
DROP TABLE IF EXISTS `t_fournisseur_jeux`;
CREATE TABLE IF NOT EXISTS `t_fournisseur_jeux` (
  `id_fournisseur_jeux` int NOT NULL AUTO_INCREMENT,
  `FK_fournisseur` int NOT NULL DEFAULT '0',
  `FK_jeux` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_fournisseur_jeux`),
  KEY `FK_t_fournisseur_jeux_t_fournisseur` (`FK_fournisseur`),
  KEY `FK_t_fournisseur_jeux_t_jeux` (`FK_jeux`),
  CONSTRAINT `FK_t_fournisseur_jeux_t_fournisseur` FOREIGN KEY (`FK_fournisseur`) REFERENCES `t_fournisseur` (`id_fournisseur`),
  CONSTRAINT `FK_t_fournisseur_jeux_t_jeux` FOREIGN KEY (`FK_jeux`) REFERENCES `t_jeux` (`id_jeux`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_fournisseur_jeux : ~20 rows (environ)
INSERT INTO `t_fournisseur_jeux` (`id_fournisseur_jeux`, `FK_fournisseur`, `FK_jeux`) VALUES
	(1, 12, 1),
	(2, 8, 4),
	(3, 2, 13),
	(4, 3, 19),
	(5, 14, 12),
	(6, 4, 12),
	(7, 6, 8),
	(8, 14, 5),
	(9, 7, 18),
	(10, 12, 8),
	(11, 1, 8),
	(12, 18, 13),
	(13, 15, 20),
	(14, 3, 12),
	(15, 1, 1),
	(16, 20, 10),
	(17, 11, 16),
	(18, 18, 7),
	(19, 9, 1),
	(20, 4, 4);

-- Listage de la structure de table nathan_chabloz_expi1a_jeux_164_2024. t_jeux
DROP TABLE IF EXISTS `t_jeux`;
CREATE TABLE IF NOT EXISTS `t_jeux` (
  `id_jeux` int NOT NULL AUTO_INCREMENT,
  `nom_jeu` varchar(50) DEFAULT NULL,
  `joueurs_min` tinyint DEFAULT NULL,
  `joueurs_max` tinyint DEFAULT NULL,
  `durée_moyenne` int DEFAULT NULL,
  `date_sortie_jeux` date DEFAULT NULL,
  `prix_jeux` tinyint DEFAULT NULL,
  `age_min` int DEFAULT NULL,
  `age_max` int DEFAULT NULL,
  `image_jeux` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id_jeux`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table nathan_chabloz_expi1a_jeux_164_2024.t_jeux : ~22 rows (environ)
INSERT INTO `t_jeux` (`id_jeux`, `nom_jeu`, `joueurs_min`, `joueurs_max`, `durée_moyenne`, `date_sortie_jeux`, `prix_jeux`, `age_min`, `age_max`, `image_jeux`) VALUES
	(1, 'Chess', 2, 2, 60, '1990-01-01', 0, 6, 99, 'https://download.vikidia.org/vikidia/fr/images/thumb/d/d2/%C3%89chiquier_avec_pi%C3%A8ces.jpg/640px-%C3%89chiquier_avec_pi%C3%A8ces.jpg'),
	(2, 'Monopoly', 2, 6, 120, '1935-03-07', 30, 8, 99, 'https://cf.geekdo-images.com/9nGoBZ0MRbi6rdH47sj2Qg__opengraph/img/Dm8scRK_5hJrDrv8OPyDHP1WVf8=/0x0:1307x686/fit-in/1200x630/filters:strip_icc()/pic5786795.jpg'),
	(3, 'Scrabble', 2, 4, 90, '1938-12-01', 20, 8, 99, 'https://e3.365dm.com/22/11/2048x1152/skynews-scrabble-boardgame_5968487.jpg'),
	(4, 'Jenga', 1, 8, 30, '1983-01-01', 15, 6, 99, 'https://mlvhcgd5ovnr.i.optimole.com/cb:1FOq.9aae/w:1024/h:512/q:mauto/f:best/https://www.apwide.com/wp-content/uploads/2023/07/apwide-test-environment-jenga-blog-image-cover.jpg'),
	(5, 'Ticket to Ride', 2, 5, 90, '2004-01-01', 40, 8, 99, 'https://miro.medium.com/v2/resize:fit:2000/1*9DYQWpFI3AfPuAttAkoPjA.jpeg'),
	(6, 'Catan', 3, 4, 120, '1995-01-01', 45, 10, 99, 'https://miro.medium.com/v2/resize:fit:7848/1*r_rq_fRLNliX91GSgMi38Q.jpeg'),
	(7, 'Uno', 2, 10, 45, '1971-01-01', 10, 6, 99, 'https://store-images.s-microsoft.com/image/apps.48553.14344458635455356.eefaff89-96c7-49d0-a5b2-1718554b3f16.5e633389-3ce3-4582-9644-911a59c1767b?mode=scale&q=90&h=1080&w=1920'),
	(8, 'Pandemic', 2, 4, 60, '2008-01-01', 50, 10, 99, 'https://www.chicagotribune.com/wp-content/uploads/migration/2020/03/05/PNCQBF77LFFP5HRIARSCZGTUOY.jpg?w=1024'),
	(9, 'Risk', 2, 6, 120, '1957-01-01', 35, 10, 99, 'https://m.media-amazon.com/images/I/8182xDY-5kL._AC_UF894,1000_QL80_DpWeblab_.jpg'),
	(10, 'Codenames', 4, 12, 30, '2015-01-01', 20, 10, 99, 'https://i.etsystatic.com/20386064/r/il/4ca653/4072943882/il_fullxfull.4072943882_tuqc.jpg'),
	(11, '7 Wonders', 2, 7, 30, '2010-01-01', 50, 10, 99, 'https://cdn.svc.asmodee.net/production-rprod/storage/games/7-wonders/sev-content-159243209212Feq.png'),
	(12, 'Azul', 2, 4, 45, '2017-01-01', 40, 8, 99, 'https://therewillbe.games/media/reviews/photos/original/b5/3f/74/azul-saturday-review-61-1599741314.jpg'),
	(13, 'Dixit', 3, 6, 30, '2008-01-01', 30, 8, 99, 'https://media.wbur.org/wp/2023/12/Dixit-Disney-1920x1080-1.jpg'),
	(14, 'Dominion', 2, 4, 30, '2008-01-01', 40, 10, 99, 'https://m.media-amazon.com/images/I/51oLNanfMnL._AC_UF894,1000_QL80_.jpg'),
	(15, 'Carcassonne', 2, 5, 45, '2000-01-01', 30, 8, 99, 'https://www.deerfieldlibrary.org/wp-content/uploads/2022/10/Carassonne-Featured.jpg'),
	(16, 'Ticket to Ride: Europe', 2, 5, 90, '2005-01-01', 45, 8, 99, 'https://assets-prd.ignimgs.com/2021/09/16/ticket-to-ride-europe-15th-anniversary-edition-1631823447104.jpeg'),
	(17, 'Small World', 2, 5, 120, '2009-01-01', 50, 8, 99, 'https://cdn.akamai.steamstatic.com/steam/apps/235620/capsule_616x353.jpg?t=1705574948'),
	(18, 'Clank!', 2, 4, 60, '2016-01-01', 60, 10, 99, 'https://cf.geekdo-images.com/DPjV1iI0ygo5Bl3XLNRiIg__opengraph/img/UtUFDFO1VXGmLKyq83bGyka-8JU=/0x0:1497x786/fit-in/1200x630/filters:strip_icc()/pic4449526.jpg'),
	(19, 'Splendor', 2, 4, 30, '2014-01-01', 40, 10, 99, 'https://cdn.mos.cms.futurecdn.net/RqGo7W3g4escRJ9F5PoaHB.jpg'),
	(20, 'King of Tokyo', 2, 6, 30, '2011-01-01', 35, 8, 99, 'https://files.ludonix.ch/bilder/king-of-tokyo-681-original.jpg'),
	(205, 'Color Addict', 2, 6, 15, '2024-05-07', 30, 4, 99, 'https://m.media-amazon.com/images/I/61am5oDbfNL.jpg');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
