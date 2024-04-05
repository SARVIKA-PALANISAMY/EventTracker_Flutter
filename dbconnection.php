<?php
function dbconnection(){
    $con=mysqli_connect("localhost","root","","events");
    return $con;
}
?>