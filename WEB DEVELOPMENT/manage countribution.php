<?php
require_once 'conn.php';

// Get the user ID from the session or other authentication mechanism
$user_id = 1; // Replace this with the actual user ID from the session

// Fetch donation history from the database
$sql = "SELECT donation_date, organization, amount FROM donation_history WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$donation_history = $result->fetch_all(MYSQLI_ASSOC);
$stmt->close();

// Close the connection
$conn->close();
?>