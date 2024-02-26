<?php

include "../connect.php";

$title = filterRequest("notes_title");
$content = filterRequest("notes_content");
$userId = filterRequest("notes_users");

$stmt = $con->prepare("INSERT INTO `notes` (`notes_title`, `notes_content`, `notes_users`) VALUES (:title, :content, :userId)");
try{
$stmt->execute(array(":title" => $title, ":content" => $content, ":userId" => $userId));
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


