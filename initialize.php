<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
session_status();

require_once 'SageInstaller.php';

$data = $_SESSION['config'];
extract( $data );

//print_r($data); die();
$sage = new SageInstaller(
    $_SESSION['config']['dbhost'], 
    $_SESSION['config']['dbuser'], 
    $_SESSION['config']['dbpswd'], 
    $_SESSION['config']['dbname']
);

