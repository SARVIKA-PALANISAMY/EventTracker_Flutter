<?php
include("dbconnection.php");
$con = dbconnection();

$arr = [];

if(isset($_POST["name"]) && isset($_POST["descr"]) && isset($_POST["date"]) && isset($_POST["stime"]) && isset($_POST["etime"])) {
    $name = mysqli_real_escape_string($con, $_POST["name"]);
    $descr = mysqli_real_escape_string($con, $_POST["descr"]);
    $date = mysqli_real_escape_string($con, $_POST["date"]);
    $stime = mysqli_real_escape_string($con, $_POST["stime"]);
    $etime = mysqli_real_escape_string($con, $_POST["etime"]);

    // Example validation for date format (you can add more validations)
    if (!strtotime($date)) {
        $arr["success"] = "false";
        $arr["error"] = "Invalid date format. Use YYYY-MM-DD";
        print(json_encode($arr));
        return;
    }

    $query = "INSERT INTO todo (name, descr, date, stime, etime) VALUES ('$name', '$descr', '$date', '$stime', '$etime')";
    $exe = mysqli_query($con, $query);

    if ($exe) {
        $arr["success"] = "true";
        $arr["message"] = "Records inserted successfully!";
    } else {
        $arr["success"] = "false";
        $arr["error"] = "Error executing query: " . mysqli_error($con);
    }
} else {
    $arr["success"] = "false";
    $arr["error"] = "Missing parameters";
}

print(json_encode($arr));
?>