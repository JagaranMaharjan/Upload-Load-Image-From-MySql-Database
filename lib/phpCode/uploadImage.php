<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "upload";//database name
 
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }

    //if connection is ok then
    $image = $_FILES['image']['name'];

    //here images is the folder to store images
    $imagePath = "images/".$image;
    move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

    //execute sql query
    $conn->query("INSERT INTO image (image) VALUES ('".$image."')");
?>