<?php
// Generate receipt data
$receipt_data = [
    'date' => '2023-11-21',
    'organization' => 'American Red Cross',
    'amount' => '$50.00',
    // Add more receipt data as needed
];

// Convert the receipt data to a CSV format
$csv_data = implode(',', array_keys($receipt_data)) . "\n" . implode(',', $receipt_data) . "\n";

// Set the appropriate headers for the file download
header('Content-Type: text/csv');
header('Content-Disposition: attachment; filename="receipt.csv"');
header('Pragma: no-cache');
header('Expires: 0');

// Output the CSV data and exit the script
echo $csv_data;
exit;
