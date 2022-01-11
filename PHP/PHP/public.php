<!DOCTYPE html>

<html>
    <head>
        <title>Information publique</title>
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
            body {
                background-color: white;
                display: flex;
                align-items: center;
                flex-direction: column;
                min-height: 100vh;
            }
            h1 {
                margin-bottom: 10px;
            }
            table {
                border: solid 3px var(--borderColor);
                border-collapse: collapse;
                width: 350px;
            }
            tr:nth-child(even) {
                background-color: var(--backColor);
            }
            tr:nth-child(odd) {
                color: white;
                background-color: var(--backDarkColor);
            }
            td {
                border: solid 3px var(--borderColor);
                padding: 3px;
            }
        </style>
    </head>

    <body>
        <h1>Nombre d'intervention par jour:</h1>
        <?php
            include("connect.php");

            $request = $cnx->query("SELECT avg(count) FROM nbintervention;");
            echo "<h3>Nombre d'intervention moyenne par jour: " . $request->fetch()[0] . "</h3>";
        ?>
        <br><br>

        <h1>Nombre d'intervention par service:</h1>
        <table>
            <thead>
                <tr>
                    <th>Service</th>
                    <th>Nombre d'intervention</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    $request = $cnx->query("SELECT * FROM nbtypeintervention;");
                    while ($ligne = $request->fetch()) {
                        echo "<tr>";
                            echo "<td>" . $ligne["nom"] . "</td>";
                            echo "<td>" . $ligne["count"] . "</td>";
                        echo "</tr>";
                    }
                ?>
            </tbody>
        </table>
        <br><br>

        <h1>Temps moyen par service:</h1>
        <table>
            <thead>
                <tr>
                    <th>Service</th>
                    <th>Temps de passage</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    $request = $cnx->query("SELECT * FROM tempspassageservice");
                    while ($ligne = $request->fetch()) {
                        echo "<tr>";
                            // Nom du service
                            $nomService = $cnx->query("SELECT nom FROM services WHERE ids =". $ligne["services"] ." ");
                            $nomReponse = $nomService->fetch();
                            echo "<td>" . $nomReponse[0] . "</td>";
                            echo "<td>" . number_format($ligne["tempspasser"], 2) . "j</td>";
                        echo "</tr>";
                    }
                ?>
            </tbody>
        </table>

    </body>
</html>