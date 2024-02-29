<?php

// include "../connect.php";

// $notesid = filterRequest("notes_users");

// $stmt = $con->prepare("SELECT * FROM notes WHERE  `notes_users` = :id");
// try {
//     $stmt->execute(array(":id" => $notesid));
//     $data=$stmt->fetchAll(PDO::FETCH_ASSOC);
//     if ($data) {
//         echo json_encode(array("status" => "success", "notes" => $data));
//     } else {
//         echo json_encode(array("status" => "error", "message" => "No notes found for the given user ID"));
//     }
// } catch (PDOException $e) {
//     // Handle the exception (e.g., log the error, return a specific error response)
//     echo json_encode(array("status" => "error", "message" => $e->getMessage()));
// }


include "../connect.php";

$notesid = filterRequest("notes_users");
$page = isset($_GET['page']) ? intval($_GET['page']) : 1; // Default page is 1
$limit = isset($_GET['limit']) ? intval($_GET['limit']) : 2; // Default limit is 10

$offset = ($page - 1) * $limit;

$stmt = $con->prepare("SELECT * FROM notes WHERE  `notes_users` = :id LIMIT :limit OFFSET :offset");
try {
    $stmt->bindParam(':id', $notesid, PDO::PARAM_INT);
    $stmt->bindParam(':limit', $limit, PDO::PARAM_INT);
    $stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
    
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if ($data) {
        echo json_encode(array("status" => "success", "notes" => $data));
    } else {
        echo json_encode(array("status" => "error", "message" => "No notes found for the given user ID"));
    }
} catch (PDOException $e) {
    // Handle the exception (e.g., log the error, return a specific error response)
    echo json_encode(array("status" => "error", "message" => $e->getMessage()));
}
