<?php
include "db.php";
header("Content-Type: application/json");

$db = (new DB())->getDB();

$db->busyTimeout(5000); 

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if ($name == '' || $email == '' || $password == '') {
    echo json_encode(["status"=>"error","message"=>"Missing fields"]);
    exit;
}

try {
    $stmt = $db->prepare("INSERT INTO users (name,email,password) VALUES (:n,:e,:p)");
    $stmt->bindValue(':n', $name);
    $stmt->bindValue(':e', $email);
    $stmt->bindValue(':p', $password);

    $result = $stmt->execute();

    echo json_encode([
        "status"=>"success",
        "message"=>"Registered"
    ]);

} catch (Exception $e) {
    echo json_encode([
        "status"=>"error",
        "message"=>$e->getMessage()
    ]);
}
?>