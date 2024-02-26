<?php

include "../connect.php";

$email = filterRequest("email");
$password = filterRequest("password");

$stmt = $con->prepare("SELECT * FROM users WHERE `password` = :password AND `email` = :email");
try {
    $stmt->execute(array(":password" => $password, ":email" => $email));

} catch (PDOException $e) {
    // Handle the exception (e.g., log the error, return a specific error response)
    echo json_encode(array("status" => "error", "message" => $e->getMessage()));
}
$data=$stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success","data"=>$data));
} else {
    echo json_encode(array("status" => "error"));
}


