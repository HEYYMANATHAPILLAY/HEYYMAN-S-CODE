<?php
// Include the database connection file
require_once 'conn.php';

// Get the submitted username and password from the form
$username = $_POST['username'];
$password = $_POST['password'];

// Prepare a SQL query to select the user with the given username and password
$sql = "SELECT * FROM login WHERE username = ? AND password = ?";

// Prepare the statement
$stmt = $conn->prepare($sql);

// Bind the parameters
$stmt->bind_param("ss", $username, $password);

// Execute the statement
$stmt->execute();

// Get the result
$result = $stmt->get_result();

// Check if there's a user with the given username and password
if ($result->num_rows > 0) {
    // User found, redirect to the profile management page
    header('Location: profilemanagement.html');
} else {
    // User not found, show an error message
    echo "Invalid username or password";
}

// Close the statement and the connection
$stmt->close();
$conn->close();
?>