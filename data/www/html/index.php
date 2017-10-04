<?php
$db = new PDO("mysql:host=localhost", "root","");
foreach( $db->query("show Databases;") as $row)
  print_r($row);
