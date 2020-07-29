<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "upload";
    
 
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
    //if connection is ok
    $result = $conn->query("SELECT * FROM image");
    $list = array();//declare array which stores mixed data type values

    while($fetchData = $result->fetch_assoc()){
        $list[] = $fetchData;
    }
    echo json_encode($list);

?>