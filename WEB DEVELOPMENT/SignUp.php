<?php
// signup_process.php

// Include the database connection file
require_once 'conn.php';

// Get the form data
$fullname = $_POST['fullname'];
$email = $_POST['email'];
$user_type = $_POST['user_type'];
$create_password = password_hash($_POST['create_password'], PASSWORD_DEFAULT);
$confirm_password = password_hash($_POST['confirm_password'], PASSWORD_DEFAULT);

// Check if the passwords match
if ($create_password !== $confirm_password) {
    echo "Error: Passwords do not match.";
    exit;
}

// Prepare an SQL statement to insert the user data
$stmt = $conn->prepare("INSERT INTO users (fullname, email, user_type, password) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $fullname, $email, $user_type, $create_password);

// Execute the SQL statement and check for errors
if (!$stmt->execute()) {
    echo "Error: " . $stmt->error;
} else {
    echo "User registered successfully.";
}

// Close the prepared statement
$stmt->close();
?>