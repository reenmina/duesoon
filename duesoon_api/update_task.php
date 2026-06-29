<?php
include "db.php";

header("Content-Type: application/json");

$db = (new DB())->getDB();

$id = $_POST['id'] ?? '';
$title = $_POST['title'] ?? '';
$status = $_POST['status'] ?? '';
$deadline = $_POST['deadline'] ?? '';

if ($id == '' || $title == '' || $status == '' || $deadline == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Missing fields"
    ]);
    exit;
}

$stmt = $db->prepare("
UPDATE tasks 
SET title = :title,
    status = :status,
    deadline = :deadline
WHERE id = :id
");

$stmt->bindValue(':id', $id, SQLITE3_INTEGER);
$stmt->bindValue(':title', $title, SQLITE3_TEXT);
$stmt->bindValue(':status', $status, SQLITE3_TEXT);
$stmt->bindValue(':deadline', $deadline, SQLITE3_TEXT);

$result = $stmt->execute();

if ($result) {
    echo json_encode([
        "status" => "success",
        "message" => "Task updated"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Update failed"
    ]);
}
?>