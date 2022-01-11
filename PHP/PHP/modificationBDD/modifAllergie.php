<?php
    include("../connect.php");

    if (!isset($_COOKIE["patient"])) {
        echo "HUSTON ON A UN PROBLEME (Veuillez contacter votre admonistrateur réseau)";
    }else {

    if (isset($_POST["allergie"])) {
        $code = $_POST["allergie"];
    }
    if (isset($_POST["dated"])) {
        $dated = $_POST["dated"];
    }
    if (isset($_POST["isDatef"])) {
        $isDatef = $_POST["isDatef"];
    }
    if (isset($_POST["datef"])) {
        $datef = $_POST["datef"];
    }
    
    if ($isDatef) {
        $cnx->exec("INSERT INTO possede VALUES ('" . $_COOKIE["patient"] . "', '" . $code . "', '" . $dated . "', '" . $datef . "')");
    } else {
        $cnx->exec("INSERT INTO possede VALUES ('" . $_COOKIE["patient"] . "', '" . $code . "', '" . $dated . "', NULL)");
    }
    
    echo "La modification a été effectuer !";
    }
?>