<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: *");

include("dbconnection.php");
$con = dbconnection();

$arr = [];

if(isset($_POST["id"])) {
    $id = mysqli_real_escape_string($con, $_POST["id"]);

    $query = "DELETE FROM `todo` WHERE id='$id'";
    $exe = mysqli_query($con, $query);

    if ($exe) {
        $arr["success"] = "true";
    } else {
        $arr["success"] = "false";
    }
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));
?>