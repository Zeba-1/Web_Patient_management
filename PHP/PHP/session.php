<?php

include('connect.php');
list($prenom, $nom) = explode(".", $_POST["idzone"]);

$requete = $cnx->query("SELECT * FROM medecinH WHERE nom = '". $nom . "'");
while ($ligne = $requete->fetch()) {
    $res[] = $ligne;
}

if (count($res) != 1) {
    echo "HUSTON ON A UN PROBLEME (Veuillez contacter votre admonistrateur réseau)";
}else {
    $mdp = md5($_POST["passzone"]);
    if ($mdp != $res[0]["mdp"]) {
        echo "mdp invalide";
    }
    else {
        session_start();
        $_SESSION['medId'] = $res[0]["idm"];
        $_SESSION['nom'] = $res[0]["nom"];

        // On recupère le service du medecin
        $requete = $cnx->query("SELECT services FROM travaille WHERE medecin = '". $res[0]["idm"] . "'");
        $ids = $requete->fetch()[0];
        $_SESSION['ids'] = $ids;

        header('location: chrchPatient.php');
    }
}
?>