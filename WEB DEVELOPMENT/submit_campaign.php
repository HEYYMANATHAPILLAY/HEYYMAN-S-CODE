<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "causecascade";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Get the campaign data from the form
$campaign_title = $_POST['campaign-title'];
$campaign_description = $_POST['campaign-description'];
$campaign_goal = $_POST['campaign-goal'];
$target_completion_date = $_POST['target-completion-date'];
$campaign_story = $_POST['campaign-story'];
$visibility = $_POST['visibility'];
$category = $_POST['category'];
$tags = $_POST['tags'];

// Insert the campaign data into the database
$sql = "INSERT INTO campaign (campaign_title, campaign_description, campaign_goal, target_completion_date, campaign_story, visibility, category, tags)
VALUES ('$campaign_title', '$campaign_description', '$campaign_goal', '$target_completion_date', '$campaign_story', '$visibility', '$category', '$tags')";

if ($conn->query($sql) === TRUE) {
  echo "New campaign created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>