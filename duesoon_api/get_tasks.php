<?php
include "db.php";

header("Content-Type: application/json");

$db = (new DB())->getDB();

$user_id = $_POST['user_id'] ?? '';

if ($user_id == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Missing user_id",
        "debug_post" => $_POST
    ]);
    exit;
}

$stmt = $db->prepare("SELECT * FROM tasks WHERE user_id = :uid");
$stmt->bindValue(':uid', $user_id, SQLITE3_TEXT);

$result = $stmt->execute();

$tasks = [];

while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
    $tasks[] = $row;
}

echo json_encode($tasks);
?>