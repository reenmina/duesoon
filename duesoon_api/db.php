<?php
class DB {
    private $db;

    function __construct() {
        $this->db = new SQLite3(__DIR__ . '/duesoon.db');
    }

    function getDB() {
        return $this->db;
    }
}
?>