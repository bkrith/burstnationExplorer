<!DOCTYPE html>
<html lang="en" class="js">
	<head>
		<meta charset="{{ @ENCODING }}" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Burstcoin block explorer">
		<meta name="author" content="Vassilis">
		<title>{{ @title }}{{ isset(@subTitle)? ' :: ' . @subTitle:'' }}</title>
		<base href="{{ @SCHEME . '://' . @HOST . ':' . @PORT . @BASE . '/'}}" />
		<link rel="icon" href="/ui/images/favicon.ico" type="image/x-icon">
		<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
		<link rel="stylesheet" href="/lib/code.css" type="text/css" />
		<link rel="stylesheet" href="/ui/css/style.css" type="text/css" />
		<link rel="stylesheet" href="/ui/css/material-icons.css">
		<link rel="stylesheet" href="/ui/css/material.indigo-pink.min.css">
		<link rel="stylesheet" href="/ui/css/flipclock.css" type="text/css" />
		<script defer src="/ui/js/material.min.js"></script>
		<script src="/ui/js/jquery-3.2.1.min.js"></script>
		<script src="/ui/js/chart.min.js"></script>
		<script src="/ui/js/moment.js"></script>
		<script src="/ui/js/moment-timezone.js"></script>
		<script src="/ui/js/app.js"></script>
		<script src="/ui/js/elements.js"></script>
		<script src="/ui/js/worker.js"></script>
		<script src="/ui/js/flipclock.min.js"></script>
		<script src="/ui/js/three.min.js"></script>
		<script src="/ui/js/orbitControls.js"></script>
		<script src="/ui/js/globe.js"></script>
	</head>
	<body>
		<!-- div id="preloader"></div -->
		<div id="offlineWallet"><span></span></div>


		<script>
			/* Pass vars from PHP */
			mainTitle = '{{ @title }}';
			subTitle = '{{ isset(@subTitle)?@subTitle:"" }}';
			activebutton = '{{ @activeLinkMenu }}';
			timezone = '{{ @serverTimeZone }}';
		</script>