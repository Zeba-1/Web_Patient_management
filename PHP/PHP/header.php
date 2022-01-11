<html lang="FR">
    <head>
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
        header {
            color: white;
            background-color: var(--backDarkColor);
            display: flex;
            flex-direction: row;
            border-bottom: solid 5px var(--borderColor);
            align-items: center;
            height: 50px;
        }
        header form {
            align-self: center;
            position: absolute;
            right: 5%;
        }
        form button {
            background-color: var(--backDarkColor);
            border: solid 2px;
            border-color: var(--borderColor);
            border-radius: 5px;
            color: white;
            font-size: 15px;
            font-weight: 300;
        }
    </style>
    </head>
    <body>
        <header>
            <h1> Gestion des patients </h1>
            <?php echo "<p> (Dr " . $_SESSION["nom"] . ")" ?>
            <form action="deco.php"><input type="submit" value="deconexion"></form>
        </header>
    </body>
</html>