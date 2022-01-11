<?php
session_start();
include("connect.php")
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
            button:hover {
                cursor: pointer;
            }
            .corp {
                display: flex;
                flex-direction: row;
            }
            #recherche {
                color: white;
                background-color: var(--backDarkColor);
                display: flex;
                flex-direction: column;
                border-right: solid 5px var(--borderColor);
                width: 150px;
                min-height: 100vh;
                padding: 5px;
            }
            #recherche form {
                margin-bottom: 50px;
                display: flex;
                flex-direction: column;
            }
            #recherche .txt{
                margin-bottom: 15px;
            }
            #recherche button{
                color: black;
                background-color: var(--backColor);
                margin-top: 15px;
                transition-duration: 0.2s;
            }
            #recherche button:hover {
                color: white;
                background-color: var(--backDarkColor);
                transition-duration: 0.2s;
            }
            .patients {
                width: 100%;
            }
            .patient {
                background-color: var(--backColor);
                border: solid 2px;
                border-color: var(--borderColor);
                border-radius: 5px;
                padding: 5px;
                margin: 10px;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }
            .patient form {
                width: 10%;
                min-width: 120px;
            }
            .patient button {
                background-color: var(--backDarkColor);
                border: solid 2px;
                border-color: var(--borderColor);
                border-radius: 5px;
                color: white;
                font-size: 30px;
                font-weight: 300;
                height: 70px;
                width: 100%;
                transition-duration: 0.2s;
            }
            .patient button:hover {
                color: black;
                background-color: var(--backColor);
                border: solid 3px;
                transition-duration: 0.2s;
            }
        </style>
    </head>

    <body>
        <?php
            if (!isset($_SESSION['medId'])) {
                // redirection vers une autre page
                echo '<h1>VEUILLEZ VOUS CONNECTER: <br></h1> <a href="../">connexion</a>';
            }
            include("header.php");
        ?>
        <div class="corp">
            <div id="recherche">
                <h2>Recherche:</h2>
                <form method="post" action="chrchPatient.php">
                    <p>Nom: </p>
                    <input type="text" name="nom" class="txt">
                    <div><input type="checkBox" name="option[]" value="prenom"> Prenom:</div>
                    <input type="text" name="prenom" class="txt" style="display: none;">
                    <div><input type="checkBox" name="option[]" value="adresse"> Adresse:</div>
                    <input type="text" name="adresse" class="txt" style="display: none;">
                    <div><input type="checkBox" name="option[]" value="numsecu"> N° de sécu:</div>
                    <input type="text" name="numsecu" class="txt" style="display: none;">
                    <div><input type="checkBox" name="allPat"> Inclure tout les patients</div>

                    <button type="submit">Rechercher</button>
                </form>

                <h2>Ajouter:</h2>
                <form method = "post" action="chrchPatient.php">
                    <p>Nom: </p>
                    <input type="text" name="nomA" class="txt">
                    <p>Prénom: </p>
                    <input type="text" name="prenomA" class="txt">
                    <p>Nom naissance: </p>
                    <input type="text" name="NomNaiA" class="txt">
                    <p>adresse: </p>
                    <input type="text" name="adresseA" class="txt">
                    <p>N° de sécu: </p>
                    <input type="text" name="numsecA" class="txt">
                    <p>N° medecin </p>
                    <select name='numMedecin' id ="">
                    <?php 
                    $requeteMe = $cnx -> query("SELECT nom,npro FROM medecint");
                    while ($ligne = $requeteMe->fetch()) {
                        echo "<option value='" . $ligne["npro"] . "'>" . $ligne["nom"] . "</option>";
                    }
                    ?>
                    </select>
                    <button type="submit" name="ajout">Ajouter</button>
                </form>
            </div>

            <div class="patients">
            <?php
            //Ajout de patient
            if(isset($_POST['ajout'])){ // si le formulaire ajouter est celui d'ajout
                $req_insert = "INSERT INTO patients VALUES('".$_POST['numsecA'] ."','".$_POST['nomA'] ."','".$_POST['nomNaiA'] ."','".$_POST['prenomA'] ."','".$_POST['adresseA'] ."','".$_POST['numMedecin'] ."')";
                if($cnx->exec($req_insert)){
                    echo "<script> alert(\"Patient ajouter\"); </script>";
                }else{
                    echo "<script> alert(\"Erreur dans l'ajout\"); </script>";
                }              
            }

            // Recherche de patient
            if (isset($_POST["nom"])) {
                $nom = $_POST["nom"];
                // On vas creer la requete de recherche
                $requete = "SELECT * FROM patients WHERE nomu like '%". strtoupper($nom) . "%'"; // Recherche par nom obligatoire
                if (isset($_POST["option"])) {
                    foreach ($_POST["option"] as $key => $value) { // Pour chaque option de recherhe activer
                        $requete = $requete . " AND " . $value . " like '%" . $_POST[$value] . "%'";
                    }
                }
                if (!isset($_POST["allPat"])) {
                    $requete = $requete . " AND EXISTS (SELECT * FROM passepar WHERE patient = patients.numsecu AND services =". $_SESSION["ids"] .");";
                }

                $reponse = $cnx->query($requete); // execution de la requete
                while ($ligne = $reponse->fetch()) { // Pour chaque patient trouver
                    echo "<div class='patient'>";
                        echo "<div class='info'>";
                            echo "<div>";
                                echo "<h1>Nom: ". $ligne["nomu"];
                                if ($ligne["nom"] != "") { // Si il a un nom de naissance
                                    echo " (" . $ligne["nom"] . ")";
                                }
                                echo ", ". $ligne["prenom"] . "<br></h1>";
                            echo "</div>";
                            echo "<div>";
                                echo "<p>N°: ". $ligne["numsecu"] . "</p>";
                                echo "<p>adresse: ". $ligne["adresse"] . "</p>";
                            echo "</div>";
                        echo "</div>";
                        echo "<form method='POST' action='patient.php'>";
                            // le bouton d'acces est enfaite un formulaire cacher
                            echo '<input type="text" name="idPatient" value="' . $ligne["numsecu"] . '" style="display: none;">';
                            echo '<button type="submit">acceder</button>';
                        echo "</form>";
                    echo "</div>";
                }
            }
            ?>
            </div>
        </div>
    </body>

    <script>
        // script permetant de cahcher les champs de recherche si ils sont decocher
        var checkBox = document.getElementsByName("option[]");
        checkBox.forEach(element => {
            element.addEventListener("change", (event) => {
                if (element.checked) {
                    document.getElementsByName(element.value)[0].style.display = "initial";
                }else if (!element.checked) {
                    document.getElementsByName(element.value)[0].style.display = "none";
                }
            })
        });
    </script>
</html>