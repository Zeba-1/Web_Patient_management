<?php
    include("../connect.php");
    session_start();

    if (!isset($_COOKIE["patient"])) {
        echo "HUSTON ON A UN PROBLEME (Veuillez contacter votre admonistrateur réseau)";
    }else {

    if (isset($_POST["acte"])) {
        $acte = $_POST["acte"];
    }
    if (isset($_POST["date"])) {
        $date = $_POST["date"];
    }
    if (isset($_POST["heure"])) {
        $heure = $_POST["heure"];
    }
    if (isset($_POST["resume"])) {
        $resum = $_POST["resume"];
    }

    $dateH = $date . " " . $heure . ":00";
    if ($acte != "" && $resum != "" ) {
        $re = "INSERT INTO actemed VALUES (DEFAULT, '" . $acte . "', '" . $dateH . "', '" . $resum . "', '" . $_COOKIE["patient"] . "', " . $_SESSION["medId"] . ")";
        echo $re;
        $cnx->exec("INSERT INTO actemed VALUES (DEFAULT, '" . $acte . "', '" . $dateH . "', '" . $resum . "', '" . $_COOKIE["patient"] . "', " . $_SESSION["medId"] . ")");
    }
    
    echo "La modification a été effectuer !";
    }
?>