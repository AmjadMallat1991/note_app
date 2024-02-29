<?php

include "../connect.php";

$title = filterRequest("notes_title");
$content = filterRequest("notes_content");
$userId = filterRequest("notes_users");
$imagename = imageUpload("notes_image");

if ($imagename != 'fail') {
    $stmt = $con->prepare("INSERT INTO `notes` (`notes_title`, `notes_content`, `notes_users`,`notes_image`) VALUES (:title, :content, :userId, :images)");

    try {
        $stmt->execute(array(":title" => $title, ":content" => $content, ":userId" => $userId, ":images" => $imagename));
    } catch (PDOException $e) {
        echo json_encode(array("status" => "error", "message" => $e->getMessage()));
    }

    $count = $stmt->rowCount();
    if ($count > 0) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "error"));
    }
} else {
    echo json_encode(array("status" => "fail"));
}
