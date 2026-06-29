<?php
include "db.php";

header("Content-Type: application/json");

$db = (new DB())->getDB();

$id = $_POST['id'] ?? '';

if ($id == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Missing ID"
    ]);
    exit;
}

$result = $db->exec("DELETE FROM tasks WHERE id='$id'");

if ($result) {
    echo json_encode([
        "status" => "success",
        "message" => "Task deleted"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Delete failed"
    ]);
}
?>