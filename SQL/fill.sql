-- allergies
INSERT INTO allergies VALUES ('POLN', 1);
INSERT INTO allergies VALUES ('LAV', 2);
INSERT INTO allergies VALUES ('ARA', 3);
INSERT INTO allergies VALUES ('MOISI', 3);
INSERT INTO allergies VALUES ('POILE', 4);
INSERT INTO allergies VALUES ('lATEX', 4);
INSERT INTO allergies VALUES ('GLUTN', 5);
INSERT INTO allergies VALUES ('BLATE', 6);
INSERT INTO allergies VALUES ('BEE', 7);
INSERT INTO allergies VALUES ('PENIC', 8);
INSERT INTO allergies VALUES ('ASPIR', 8);
INSERT INTO allergies VALUES ('GUEPE', 10);

-- medecin traitant (maybe auto plus tard)
INSERT INTO medecint VALUES ('125548762', 'MARTIN', 'Luc', '14 Boulevard Truf Paris');
INSERT INTO medecint VALUES ('125884787', 'ROBERTE', 'Gerard', '2 Rue paver Paris');
INSERT INTO medecint VALUES ('264481274', 'GOUBIX', 'Julie', '123 Rue de la porte Paris');
INSERT INTO medecint VALUES ('157845587', 'SAUTIER', 'Sebastien', '12 Villa Saint-Pierre Charenton');

-- services
INSERT INTO services(nom, loc) VALUES ('Urgence', 'A1'); --1
INSERT INTO services(nom, loc) VALUES ('Pediatrie', 'A2'); --2
INSERT INTO services(nom, loc) VALUES ('Neurologie', 'A3'); --3
INSERT INTO services(nom, loc) VALUES ('Traumatologie', 'B1'); --4
INSERT INTO services(nom, loc) VALUES ('Cardiologie', 'B2'); --5
INSERT INTO services(nom, loc) VALUES ('Radiologie', 'A1'); --6

-- medecin de l'hopital
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('ATTIG', 'Leo', '45 Avenue Forestiere Champs-sur-Marne', '10e3f153b4de898b01f25a011520ba74'); --1
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('FOURIER', 'Transformer', '9 Rue Du Puis Profond Paris', '3d2a9e7d89b863362b9c2acd61378900'); --2
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('ISAACSON', 'Walter', '109 Rue Du Livre Paris', '9a40164cde5de879bf21dbab5d727ec6'); --3
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('HOUSE', 'Grégorie', '22 Baker Street Princeton', 'a3396d7f732ba4aec72126ba575e9362'); --4
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('DE COS', 'Hippocrate', '1 Rue Du Savoir Kos', '6ef1070aaa008d1405df14b07e67f1dd'); --5
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('JOBS', 'Steev', '2066 Crist Drive Los Altos', 'a4eb064bf11c923a69f12b1fbf5b45fe'); --6
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('MACRON', 'Emmanuel', '55 Rue du Faubourg Saint-Honoré Paris', 'c7654fe81f545c577d821897005be4b0'); --7
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('GLUBUX', 'Loux', '2 Base Lunaire Lune', '25721d2f25c600ac7a164f92f59d84f1'); --8
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('JEAN', 'Alex', '2 Rue des pavees Paris', '49103fc76f253a2a385519966f6b57e4'); --9
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('BOROWIEC', 'Chloe', '45 Avenue Forestiere Champs-sur-Marne', 'a62a1629a54602176381f52006948a89'); --10
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('CAPET', 'Lucile', '6 Rue des vierges Marseille', '8ef52acadd1bafa017ef0b501a8e92c1'); --11
INSERT INTO medecinh(nom, prenom, adresse, mdp) VALUES ('JEAN', 'Alix', '2 Rue des pavees Paris', '923371ad7b52ce153610453b568c8ed8'); --12

-- relation medecin services
INSERT INTO travaille VALUES (1, 1, 'Chef de service', '2017-05-11');
INSERT INTO travaille VALUES (2, 1, 'interne', '2020-11-24');
INSERT INTO travaille VALUES (3, 2, 'Chef de service', '2015-02-27');
INSERT INTO travaille VALUES (4, 2, 'Chef de nuit', '2018-01-02');
INSERT INTO travaille VALUES (5, 3, 'Neurologue', '2021-02-06');
INSERT INTO travaille VALUES (6, 4, 'Chef de service', '2017-05-12');
INSERT INTO travaille VALUES (7, 4, 'Anestesiste', '2018-09-18');
INSERT INTO travaille VALUES (8, 5, 'Chef de service', '2019-06-19');
INSERT INTO travaille VALUES (9, 5, 'medecin', '2019-06-19');
INSERT INTO travaille VALUES (10, 3, 'Chef de service', '2019-06-19');
INSERT INTO travaille VALUES (11, 6, 'Chef de service', '2019-06-19');
INSERT INTO travaille VALUES (12, 6, 'Operateur radio', '2019-06-19');

-- On ajoute un patient avec un fichier lier a son intervention (le générateur aléatoire ne pouvant pas le faire)
INSERT INTO patients VALUES ('102099406908259', 'DESLACS', '', 'Charles-Alan', '4 Rue de la fée Paris', '125884787');
INSERT INTO possede VALUES ('102099406908259', 'PENIC', '2019-07-18', NULL);
INSERT INTO dateentre(datee) VALUES ('2021-09-29') ON CONFLICT (datee) DO NOTHING; -- ON CONFLICT DO NOTHING -> si la date exite déjà on ne fait rien
INSERT INTO passepar VALUES ('102099406908259', 2, '2021-09-29', '2021-10-01');
INSERT INTO actemed(nom, dateh, resum, patient, medecin) VALUES ('Radio', '2021-09-29 16:43:21', 'fracture du poignet', '102099406908259', 1); -- 1 (premiere acte med)
INSERT INTO fichier VALUES ('Radio_poignet_DESLACS', 'https://image.jimcdn.com/app/cms/image/transf/none/path/s4d31f2fccfc3b171/image/iccc64fbf1faaf445/version/1500213757/chirurgie-du-sport-fracture-poignet-toulouse-chirurgie-orthopédique-dr-rémi.jpg', 'Poignet bien casser comme il faut !', 1);