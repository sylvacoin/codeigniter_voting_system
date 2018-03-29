<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sage Installer</title>
	<link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
	<?php
	if ( $_SERVER[ 'REQUEST_METHOD' ] == 'POST' && isset( $_POST[ 'btnSubmit' ] ) ) {

	    extract( $_POST );
	    require_once 'SageInstaller.php';
	    $sage = new SageInstaller(
		    $dbhost,$dbuser,$dbpswd,$dbname
	    );
	}
	?>

	<div class="wrapper">
	    <h1>Sage Installer version 1.0</h1>
	    <div class="divider">
		<div class="error"></div>
		<div class="success"></div>
		<div class="bg-primary"></div>
	    </div>
	    <?php 
		if ( isset($sage->error) )
		{
		    foreach ( $sage->error as  $message )
		    {
			echo '<div class="alert error">'.$message.'</div>';
		    }
		}
		
		if ( isset($sage->success) )
		{
		    echo '<div class="alert success">'.$sage->success.'</div>';
		}
	    ?>
	    <form method="post" action="">
		<p><input name="dbhost" class="form-control" value="localhost" readonly="" required="" type="text"></p>
		<p><input name="dbname" class="form-control" value="" placeholder="Database Name" required="" type="text"></p>
		<p><input name="dbuser" class="form-control" value="" placeholder="Server Username" required="" type="text"> (default username: root)</p>
		<p><input name="dbpswd" class="form-control" value="" placeholder="Server password" type="text"></p>
		<p><input name="btnSubmit" class="btn bg-primary" value="Start Installation" type="submit"></p>
	    </form>
	</div>



    </body>
</html>
