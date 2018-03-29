<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of SageInstaller
 *
 * @author Gandhiberry
 */
class SageInstaller
{
    private $default_file = 'inc/ci_voting.zip';
	private $installer_dir = basename( dirname(__FILE__) );
    private $dbname, $dbhost, $dbpswd, $dbuser;
    private $conn;
    private $destination, $filepath, $foldername;
    public $error;
    public $success;

    function __construct( $host, $user, $pswd, $dbname, $zipPath = NULL, $destination = NULL )
    {
	$this->init_connection($host, $user, $pswd, $dbname);
	
	if ( ! $this->create_database())
	{
	    $this->error[] = 'An error occured database was not created.'.$this->conn->error .' DATABASE:'.$this->dbuser;
	    $this->rollback();
	    die();
	}
	
	if ( !$this->extract_site( $zipPath, $destination ))
	{
	    $this->error[] =  'An error occured file was not extracted';
	    $this->rollback();
	    die();
	}
	
	if ( $this->init_site_config())
	{
	    $this->success =  'New site was installed successfully click <a href="http://localhost/'.$this->foldername.'">here</a> to redirect to site';
	    $this->delete_installation_folder();
	    die();
	}else{
	    $this->error[] =  'An error occured site installation failed';
	    die();
	}
    }

    function init_connection($host, $user, $pswd, $dbname)
    {
	$this->dbhost = $host;
	$this->dbuser = $user;
	$this->dbpswd = $pswd;
	$this->dbname = $dbname;
	
	$this->conn = new mysqli( $this->dbhost, $this->dbuser, $this->dbpswd );
	if ( $this->conn->connect_error ) {
	    die( 'Invalid connection ' );
	}
    }

    function create_database()
    {
	// Create database
	//Extract content from a database_sql file replace constants with real database values
	$dbfile = "inc/database.sql";
	$dbfile2 = "inc/dbfile.sql";
	$db_contents = str_replace( '{{DBNAME}}', $this->dbname, file_get_contents( $dbfile ) );
	file_put_contents( $dbfile2, $db_contents );

	//read the contents of DBFILE
	$handle = fopen( $dbfile2, "r" );
	$query = fread( $handle, filesize( $dbfile2 ) );
	fclose( $handle );
	return $this->conn->multi_query( $query );
    }

    //extraccts the site to its position
    function extract_site( $filepath = NULL, $destination = NULL )
    {
	$this->filepath = $filepath;
	$this->destination = $destination;
	if ( $filepath == NULL ) {
	    $this->filepath = $this->default_file;
	}

	if ( $destination == NULL ) {
	    $this->destination = '../';
	}

	//set the filepath of the new 
	$begin = strrpos( $this->default_file, '/' );
	$end = strpos( $this->default_file, '.' );
	$this->foldername = substr( $this->default_file, strrpos( $this->default_file, '/' )+1, $end - $begin-1 );
	//extract items from a zip file
	$zip = new ZipArchive;
	if ( $zip->open( $this->filepath ) === TRUE ) {
	    $zip->extractTo( $this->destination );
	    $zip->close();

	    return true;
	} else {
	    return false;
	}
    }

    function init_site_config()
    {
	$path = $this->destination . $this->foldername . '/application/config/';
	$filename = 'database.php';
	$search = array('{{DBNAME}}', '{{DBHOST}}', '{{DBPSWD}}', '{{DBUSER}}');
	$replace = array($this->dbname, $this->dbhost, $this->dbpswd, $this->dbuser);
	$contents = str_replace( $search, $replace, file_get_contents( 'inc/'.$filename ) );
	if ( file_put_contents( $path . $filename, $contents ) )
	{
	    return true;
	}
	return false;
    }

    function rollback()
    {
	$q1 = "DROP database " . $this->dbname;
	$this->conn->query( $q1 );
    }

    function delete_installation_folder()
    {
	$this->recursiveDelete('../'.$this->installer_dir.'/');
    }

    private function recursiveDelete( $str )
    {
	if ( is_file( $str ) ) {
	    return @unlink( $str );
	} elseif ( is_dir( $str ) ) {
	    $scan = glob( rtrim( $str, '/' ) . '/*' );
	    foreach ( $scan as $index => $path )
	    {
		$this->recursiveDelete( $path );
	    }
	    return @rmdir( $str );
	}
    }

}



