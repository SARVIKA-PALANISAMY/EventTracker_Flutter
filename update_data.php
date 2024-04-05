<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");
include("dbconnection.php");
$con = dbconnection();

// Check if 'name' is set in the POST data
if (isset($_POST["name"])) {
    $name = $_POST["name"];
} else {
    return;
}

// Check if 'description' is set in the POST data
if (isset($_POST["descr"])) {
    $description = $_POST["descr"];
} else {
    $description = ""; // Set a default value or handle as needed
}

// Check if 'start_time' is set in the POST data
if (isset($_POST["stime"])) {
    $stime = $_POST["stime"];
} else {
    $stime = ""; // Set a default value or handle as needed
}

// Check if 'end_time' is set in the POST data
if (isset($_POST["etime"])) {
    $etime = $_POST["etime"];
} else {
    $etime = ""; // Set a default value or handle as needed
}

// Check if 'date' is set in the POST data
if (isset($_POST["date"])) {
    $date = $_POST["date"];
} else {
    $date = ""; // Set a default value or handle as needed
}

// Assuming you have an 'id' field in your HTML form
if (isset($_POST["id"])) {
    $id = $_POST["id"];
} else {
    $id = ""; // Set a default value or handle as needed
}

$query = "UPDATE `todo` SET `name`='$name', `descr`='$description', `stime`='$stime', `etime`='$etime', `date`='$date' WHERE `id`='$id'";

$exe = mysqli_query($con, $query);
$arr = [];

if ($exe) {
    $arr["success"] = true;
} else {
    $arr["success"] = false;
    $arr["error"] = mysqli_error($con);
}

print(json_encode($arr));
?>