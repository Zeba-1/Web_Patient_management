<?php
    include("../connect.php");

    if (!isset($_COOKIE["patient"])) {
        echo "HUSTON ON A UN PROBLEME (Veuillez contacter votre admonistrateur réseau)";
    }else {

    if (isset($_POST["service"])) {
        $service = $_POST["service"];
    }
    if (isset($_POST["datee"])) {
        $datee = $_POST["datee"];
    }
    if (isset($_POST["isdates"])) {
        $isdates = $_POST["isdates"];
    }
    if (isset($_POST["dates"])) {
        $dates = $_POST["dates"];
    }

    $cnx->exec("INSERT INTO dateentre VALUES ('" . $datee . "')");
    if ($isdates) {
        $cnx->exec("INSERT INTO passepar VALUES ('" . $_COOKIE["patient"] . "', '" . $service . "', '" . $datee . "', '" . $dates . "')");
    } else {
        $cnx->exec("INSERT INTO passepar VALUES ('" . $_COOKIE["patient"] . "', '" . $service . "', '" . $datee . "', NULL)");
    }
    
    echo "La modification a été effectuer !";
    }
?>