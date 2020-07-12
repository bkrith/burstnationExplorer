
<?php

ini_set("date.timezone", "Europe/Athens");

// Kickstart the framework
$f3=require('lib/base.php');

if ((float)PCRE_VERSION<7.9)
	trigger_error('PCRE version is out of date');

// Load configuration - Global Variables
$f3->config('config.ini');

// Debug function

function debugApp($debug, $f3) {
	if ($debug) {
		error_reporting(E_ALL); // for reporting all errors set E_ALL
		ini_set('display_errors', 1); // for reporting all errors set 1
		$f3->set('DEBUG', 3);
	}
	else {
		error_reporting(0); // for reporting all errors set E_ALL
		ini_set('display_errors', 0); // for reporting all errors set 1
		$f3->set('DEBUG', 0);
		$f3->set('ONERROR',function($f3){
			echo \Template::instance()->render('header.tpl');
			echo \Template::instance()->render('topbar.tpl');
			echo \Template::instance()->render('404.tpl');
			echo \Template::instance()->render('footer.tpl');
		});
	}
}

// ENABLE / DISABLE DEBUG FOR APP FROM HERE
debugApp(true, $f3);

// MySQL settings
try {
	$f3->set('db', new DB\SQL(
		'mysql:host=localhost;port=3306;dbname=burstexplorer',
		'winners',
		'12345678',
		array( 
			\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION 
		)
	));
}
catch(\PDOException $e) {
	// Do nothing
}

// MySQL settings
try {
	$f3->set('dbWallet', new DB\SQL(
		'mysql:host=localhost;port=3306;dbname=burstwallet',
		'burstwallet',
		'12345678',
		array( 
			\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION 
		)
	));
}
catch(\PDOException $e) {
	// Do nothing
}

$f3->config('routes.ini');

$f3->run();
