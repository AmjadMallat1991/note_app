<?php

include "../connect.php";

$username = filterRequest("username");
$email = filterRequest("email");
$password = filterRequest("password");

$stmt = $con->prepare("INSERT INTO `users`(`username`, `email`, `password`) VALUES (:username, :email, :password)");
try{
$stmt->execute(array(":username" => $username, ":email" => $email, ":password" => $password));
}
catch (PDOException $e) {
    // Handle the exception (e.g., log the error, return a specific error response)
    echo json_encode(array("status" => "error", "message" => $e->getMessage()));
}

$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "error"));
}


