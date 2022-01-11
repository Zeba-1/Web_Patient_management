<?php
    include("../connect.php");

    if (!isset($_COOKIE["patient"])) {
        echo "HUSTON ON A UN PROBLEME (Veuillez contacter votre admonistrateur réseau)";
    }else {

    $nom = $_POST["nom"];
    if (isset($_POST["nomN"])) {
        $nomN = $_POST["nomN"];
    }
    $prenom = $_POST["prenom"];
    $adresse = $_POST["adresse"];

    if ($nom != "") {
        $cnx->exec("UPDATE patients SET nomu ='" . $nom . "' WHERE numsecu = '" . $_COOKIE["patient"] . "'");
    } else { echo "NOM invalide"; }
    if ($prenom != "") {
        $cnx->exec("UPDATE patients SET prenom ='" . $prenom . "' WHERE numsecu = '" . $_COOKIE["patient"] . "'");
    } else { echo "PRENOM invalide"; }
    $cnx->exec("UPDATE patients SET nom ='" . $nomN . "' WHERE numsecu = '" . $_COOKIE["patient"] . "'");
    $cnx->exec("UPDATE patients SET adresse ='" . $adresse . "' WHERE numsecu = '" . $_COOKIE["patient"] . "'");
    
    echo "La modification a été effectuer !";
    }
?>