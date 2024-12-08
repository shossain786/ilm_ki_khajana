<?php
header('Content-Type: application/json');

$host = '';
$db = '';
$user = '';
$password = '';

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => $conn->connect_error]);
    exit;
}

$sql = "SELECT id, content, category, date FROM irshadateali";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
    echo json_encode(['status' => 'success', 'data' => $data]);
} else {
    echo json_encode(['status' => 'success', 'data' => []]);
}

$conn->close();
?>
