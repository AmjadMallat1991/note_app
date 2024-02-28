<?php

include "connect.php";

// $stmt = $con->prepare("SELECT * FROM users  where id=1");
// $stmt->execute();
// $users = $stmt->fetch(PDO::FETCH_ASSOC);
// // $users = $stmt->fetchColumn();

// echo "<pre>";
// print_r($users);
// echo "<pre>";

// $count=$stmt->rowCount();
// echo $count;

// echo json_encode($users);

// global $con;
// function addUser($connect,$username,$email){
// $stmt = $connect->prepare("INSERT INTO `users`(`username`, `email`) VALUES (:user,:email)");
// $stmt->execute(array(
// ":user" => $username, ":email" => $email,
// ),);
// $count = $stmt->rowCount();

// if ($count > 0) {
//     echo 'succes';
// } else {
//     echo 'fail';
// }
// }

// function updateUser($connect, $username, $email){
//     $stmt = $connect->prepare("UPDATE `users` SET `username`=:username, `email`=:email WHERE id=8");
//     $stmt->execute(array(
//         ":username" => $username,
//         ":email" => $email,
//     ));
//     $count = $stmt->rowCount();
//     if($count > 0){
//         echo "update success";
//     } else {
//         echo "fail";
//     }
// }

// function deleteUser($connect){
//     $stmt = $connect->prepare("DELETE FROM users WHERE id = :id");
//     $stmt->execute(array(
//         ":id" => 9,
//     ));
//     $count = $stmt->rowCount();
//     if($count > 0){
//         echo "delete success";
//     } else {
//         echo "fail";
//     }
// }

// deleteUser($con);

// updateUser($con, 'samir kousa', 'samir@gmail.com');

// addUser($con,'ousama ','ousama@gmail.com');

 imageUpload("file");

