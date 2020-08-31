<?php 
$output = shell_exec('sh webcam.sh');
$img = '/tmp/viewcam.jpg';
header('Content-Type: image/jpeg');
readfile($img);