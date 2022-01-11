<?php
    // local connextion
    $user =  "USERNAME";
    $pass = "";
    try {
        $cnx = new PDO('pgsql:host=localhost;dbname=projet', $user, $pass);
    }
    catch (PDOException $e)
    {
        echo "ERREUR : La connexion a échouée";
        echo "Error: " . $e;
    }
?>