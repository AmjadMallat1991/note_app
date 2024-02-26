<?php

include "../connect.php";

$notesId = filterRequest("notes_id");
$content = filterRequest("notes_content");
$title = filterRequest("notes_title");


$stmt = $con->prepare("UPDATE `notes` SET `notes_title`=:title, `notes_content`=:content WHERE notes_id=:notesId");
try {
    $stmt->execute(array(":content" => $content, ":title" => $title, ":notesId" => $notesId));
} catch (PDOException $e) {
    echo json_encode(array("status" => "error", "message" => $e->getMessage()));
}

$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "error"));
}


