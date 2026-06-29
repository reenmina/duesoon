<?php
include "db.php";

header("Content-Type: application/json");

$db = (new DB())->getDB();

$email = trim($_POST['email'] ?? '');
$password = trim($_POST['password'] ?? '');

$result = $db->query("
SELECT * FROM users 
WHERE email='$email' AND password='$password'
");

$user = $result->fetchArray(SQLITE3_ASSOC);

if ($user) {
    echo json_encode([
        "status" => "success",
        "user_id" => $user["id"],
        "name" => $user["name"]
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Invalid email or password"
    ]);
}
?>