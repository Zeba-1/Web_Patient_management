<?php
session_start();
include("connect.php");
setcookie("patient", $_POST["idPatient"]);
?>

<!DOCTYPE html>

<html>
    <head>
        <title>Gestion des patients</title>
            <link rel="icon" type="image/x-icon" href="../images/logo.ico"/>
            <meta charset="UTF-8">
            <meta name="author" lang="fr" content="SAUTIER Sebastien">
            <meta name="lang" content="fr">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    font-family: sans-serif;
                }
                :root {
                    --backColor: rgb(200, 222, 255);
                    --backDarkColor: rgb(49, 86, 143);
                    --borderColor: rgb(22, 44, 77);
                }
                #corp {
                    display: flex;
                    flex-direction: row;
                    flex-wrap: wrap;
                }
                .ficheInfo {
                    border: solid 4px var(--borderColor);
                    border-radius: 7px;
                    margin: 10px;
                    width: 400px;
                }
                .infoHead {
                    background-color: var(--backColor);
                    border-bottom: solid 3px var(--borderColor);
                    border-top-left-radius: 4px;
                    border-top-right-radius: 4px;
                    display: flex;
                    flex-direction: row;
                    justify-content: space-around;
                    justify-content: space-between;
                    align-items: center;
                    padding-left: 20px;
                    padding-right: 20px;
                }
                .infoHead ion-icon {
                    font-size: 27px;
                    cursor: pointer;
                }
                .ficheInfo form {
                    margin: 10px;
                    font-size: 20px;
                    display: flex;
                    flex-direction: column;
                }
                .ficheInfo form button {
                    align-self: center;
                    padding: 2px;
                }
                .ficheInfo form button:disabled {
                    display: none;
                }
                .ficheInfo input[type="text"] {
                    font-size: 20px;
                    width: 100%;
                    margin-bottom: 10px;
                }
                .ficheInfo input[type="text"]:enabled {
                    color: var(--borderColor);
                    background-color: var(--backColor);
                    border: solid 1px var(--borderColor);
                    border-radius: 2px;
                    transition-duration: 0.2s;
                }
                .ficheInfo input[type="text"]:disabled {
                    color: black;
                    background-color: white;
                    border: none;
                    transition-duration: 0.2s;
                }
                .allergie {
                    background-color: var(--backColor);
                    border: solid 2px var(--borderColor);
                    border-radius: 2px;
                    margin: 5px;
                }
                .ajout {
                    display: none;
                    background-color: white;
                    position: absolute;
                    margin: auto;
                    left: 0; right: 0; bottom: 0; top: 0;
                    border: solid 4px var(--borderColor);
                    border-radius: 7px;
                    width: 400px;
                    height: 400px;
                }
                .ajout form {
                    margin: 10px;
                    font-size: 20px;
                    display: flex;
                    flex-direction: column;
                }
                .ajout form input, .ajout form select {
                    margin-bottom: 10px;
                }
                .ajout form button {
                    align-self: center;
                    padding: 2px;
                }
            </style>
    </head>

    <body>
        <?php
            include("header.php");

            $numSecu = $_POST["idPatient"];
            $requete = $cnx->query("SELECT * FROM patients WHERE numsecu = '". $numSecu . "'");

            while ($ligne = $requete->fetch()) {
                // On stock dans une liste pour s'assurer qu'on récupère bien un seul patient
                $res[] = $ligne;
            }

            if (count($res) != 1) {
                exit("HUSTON ON A UN PROBLEME");
            }
            $res = $res[0]; // On sait qu'il y a qu'une ligne
            $nom = $res["nomu"];
            $nomN = $res["nom"];
            $prenom = $res["prenom"];
            $adresse = $res["adresse"];
            $medecinT = $res["medecint"];
        ?>

        <div id="corp">
        <div class="ficheInfo">
            <div class="infoHead">
                <h1>Fiche d'information:</h1>
                <ion-icon name="create-outline" id="edit"></ion-icon>
            </div>
            <form method="POST" action="modificationBDD/modifPatient.php">
                <?php
                    echo '<p>Nom:</p><input class="toenable" type="text" name="nom" value="' . $nom . '" disabled>';
                    echo '<p>Nom de naissance:</p><input class="toenable" type="text" name="nomN" value="' . $nomN . '" disabled>';
                    echo '<p>Prenom:</p><input class="toenable" type="text" name="prenom" value="' . $prenom . '" disabled>';
                    echo '<p>Adresse:</p><input class="toenable" type="text" name="adresse" value="' . $adresse . '" disabled>';
                    echo '<p>N° de sécurité sociale:<br>' . $numSecu . '</p>';
                ?>
                <button class="toenable" type="submit" disabled>valider les modification</button>
            </form>
        </div>

        <div class="ficheInfo">
            <div class="infoHead">
                <h1>Allergies:</h1>
                <ion-icon id="addAll" name="add-outline"></ion-icon>
            </div>
            <?php
                $requete = $cnx->query("SELECT * FROM possede, allergies WHERE allergie = code AND patient = '". $numSecu . "'");
                while ($ligne = $requete->fetch()) {
                    echo "<div class='allergie'>";
                        echo "<h2>" . $ligne["allergie"] . " (" . $ligne["niv"] . ")</h2>";
                        if ($ligne["datef"] != "") {
                            echo "<p>De: ". $ligne["dated"] . " a " . $ligne["datef"] . "</p>";
                        } else {
                            echo "<p>Depuis: ". $ligne["dated"] . "</p>";
                        }
                    echo "</div>";
                }
            ?>
        </div>

        <div class="ficheInfo">
            <div class="infoHead">
                <h1>Passage:</h1>
                <ion-icon id="addPass" name="add-outline"></ion-icon>
            </div>
            <?php
                $requete = $cnx->query("SELECT * FROM services, passepar WHERE passepar.services = ids AND patient = '". $numSecu . "'");
                while ($ligne = $requete->fetch()) {
                    echo "<div class='allergie'>";
                        echo "<h2>" . $ligne["nom"] . "</h2>";
                        if ($ligne["dates"] != "") {
                            echo "<p>De: ". $ligne["datee"] . " a " . $ligne["dates"] . "</p>";
                        } else {
                            echo "<p>Depuis: ". $ligne["datee"] . "</p>";
                        }
                    echo "</div>";
                }
            ?>
        </div>

        <div class="ficheInfo">
            <div class="infoHead">
                <h1>Actes médicaux:</h1>
                <ion-icon id="addAct" name="add-outline"></ion-icon>
            </div>
            <?php
                $requete = $cnx->query("SELECT * FROM actemed WHERE patient = '". $numSecu . "'");
                while ($ligne = $requete->fetch()) {
                    echo "<div class='allergie'>";
                        echo "<h2>" . $ligne["nom"] . "</h2>";
                        echo "<p>Date: ". $ligne["dateh"] . "</p>";
                        echo "<p>Résumé: ". $ligne["resum"] . "</p>";

                        $requeteF = $cnx->query("SELECT * FROM fichier WHERE actemed = '". $ligne["ida"] . "'");
                        while ($fichier = $requeteF->fetch()) {
                            echo "fichier lié: <a href='" . $fichier["lien"] . "'>" . $fichier["descr"] . "</a>";
                        }
                    echo "</div>";
                }
            ?>
        </div>
        </div>

        <div class="ajout" id="allergie">
            <div class="infoHead">
                <h1>Ajout allergie:</h1>
                <ion-icon id="closeAll" name="close-outline"></ion-icon>
            </div>
            <form method="POST" action="modificationBDD/modifAllergie.php">
                <h3>allergie:</h3>
                <select name="allergie">
                <?php
                    $requete = $cnx->query("SELECT * FROM allergies");
                    while ($ligne = $requete->fetch()) {
                        echo "<option value='" . $ligne["code"] . "'>" . $ligne["code"] . "</option>";
                    }
                ?>
                </select>
                <h3>Date de debut:</h3>
                <input type="date" name="dated">
                <h3>Date de fin:</h3>
                <input type="checkbox" name="isDatef">
                <input type="date" name="datef">
                <button type="submit">ajouter</button>
            </form>
        </div>
        
        <div class="ajout" id="passage">
            <div class="infoHead">
                <h1>Ajout passage:</h1>
                <ion-icon id="closePass" name="close-outline"></ion-icon>
            </div>
            <form method="POST" action="modificationBDD/modifPassage.php">
                <h3>Service:</h3>
                <select name="service" >
                <?php
                    $requete = $cnx->query("SELECT * FROM services");
                    while ($ligne = $requete->fetch()) {
                        echo "<option value='" . $ligne["ids"] . "'>" . $ligne["nom"] . "</option>";
                    }
                ?>
                </select>
                <h3>Date d'entrer:</h3>
                <input type="date" name="datee">
                <h3>Date de fin:</h3>
                <input type="checkbox" name="isdates">
                <input type="date" name="dates">
                <button type="submit">ajouter</button>
            </form>
        </div>

        <div class="ajout" id="acteMed">
            <div class="infoHead">
                <h1>Ajout d'intervention:</h1>
                <ion-icon id="closeActe" name="close-outline"></ion-icon>
            </div>
            <form method="POST" action="modificationBDD/modifActeMed.php">
                <h3>Acte:</h3>
                <input type="text" name="acte">
                <h3>Date:</h3>
                <input type="date" name="date">
                <h3>heure:</h3>
                <input type="time" name="heure">
                <h3>Résumé:</h3>
                <input type="textarea" name="resume">
                <button type="submit">ajouter</button>
            </form>
        </div>

    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    </body>

    <script>
        // bouton de l'edit pour les infos personelle
        document.getElementById("edit").addEventListener("click", (event) => {
            var inputE = Array.from(document.getElementsByClassName("toenable"));
            console.log(inputE)
            inputE.forEach(element => {
                element.disabled = !element.disabled;
            });
        })

        // bouton pour l'ajout d'allergie
        document.getElementById("addAll").addEventListener("click", (event) => {
            document.getElementById("allergie").style.display = "initial";
        })
        document.getElementById("closeAll").addEventListener("click", (event) => {
            document.getElementById("allergie").style.display = "none";
        })

        // bouton pour l'ajout de passage
        document.getElementById("addPass").addEventListener("click", (event) => {
            document.getElementById("passage").style.display = "initial";
        })
        document.getElementById("closePass").addEventListener("click", (event) => {
            document.getElementById("passage").style.display = "none";
        })

        // bouton pour l'ajout d'acte medicaux
        document.getElementById("addAct").addEventListener("click", (event) => {
            document.getElementById("acteMed").style.display = "initial";
        })
        document.getElementById("closeActe").addEventListener("click", (event) => {
            document.getElementById("acteMed").style.display = "none";
        })
    </script>
</html>