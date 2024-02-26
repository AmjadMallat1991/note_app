<?php

include "../connect.php";

$id = filterRequest("notes_id");


$stmt = $con->prepare("DELETE FROM `notes` WHERE `notes_id` = :id");
try{
$stmt->execute(array(":id" => $id));
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


