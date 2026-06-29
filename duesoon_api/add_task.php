<?php
include "db.php";
header("Content-Type: application/json");

$db = (new DB())->getDB();

$user_id = $_POST['user_id'] ?? '';
$title = $_POST['title'] ?? '';
$status = $_POST['status'] ?? '';
$deadline = $_POST['deadline'] ?? '';

if ($user_id==''||$title==''||$status==''||$deadline=='') {
    echo json_encode(["status"=>"error","message"=>"Missing fields"]);
    exit;
}

$db->exec("INSERT INTO tasks (user_id,title,status,deadline)
VALUES ('$user_id','$title','$status','$deadline')");

echo json_encode(["status"=>"success","message"=>"Task added"]);
?>