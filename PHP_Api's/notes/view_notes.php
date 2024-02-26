<?php

include "../connect.php";

$notesid = filterRequest("notes_users");

$stmt = $con->prepare("SELECT * FROM notes WHERE  `notes_users` = :id");
try {
    $stmt->execute(array(":id" => $notesid));
    $data=$stmt->fetchAll(PDO::FETCH_ASSOC);
    if ($data) {
        echo json_encode(array("status" => "success", "notes" => $data));
    } else {
        echo json_encode(array("status" => "error", "message" => "No notes found for the given user ID"));
    }
} catch (PDOException $e) {
    // Handle the exception (e.g., log the error, return a specific error response)
    echo json_encode(array("status" => "error", "message" => $e->getMessage()));
}

