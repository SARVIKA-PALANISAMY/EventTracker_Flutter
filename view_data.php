<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");

include("dbconnection.php");
$con = dbconnection();

$query = "SELECT `id`, `name`, `descr`, `date`, `stime`, `etime` FROM todo";
$exe = mysqli_query($con, $query);

$arr = [];

while ($row = mysqli_fetch_assoc($exe)) {
    $arr[] = $row;
}

print(json_encode($arr));
?>