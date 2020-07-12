# Burst Explorer

Block explorer for burstcoin network based on wallet api

### Credits

Big thank for their support, advices, ideas and sponsoring:

* Adam, Focus, DFWplay, Menaxerius, Zeus (BurstNation crew - http://burstnation.com)
* Shadow (owner of http://pool.burstcoin.ro)
* The community of pool.burstcoin.ro
* The community of burstnation

### Why to use the Burst Explorer

* Is unique - all in one monitors
* Is fast
* Is accurate
* Is OpenSource under MIT License
* The ONLY online accurate won blocks per day for each pool monitor
* All Blocks, Accounts, Transactions "together" for easy monitoring
* Assets monitor with statistics and details
* 1st ever Marketplace - 1st time ever user can navigate through products
* This is only the beginning.. ;) 

### Getting Started

Clone the github repository.

For apache server use file htaccess.default settings and for nginx server nginx.default settings.

### Prerequisites

Access to a local or online burst wallet.
Server(apache, nginx, etc) with php support.
MySQL database server.

### Installing

Clone the github repository.

Set the tmp folder to full privilage(777) to allow temporary storage and caching of app.

In config.ini file you can set your global variables:

* title - Application title
* officialWallet - Official Wallet for redirect links
* wallet - Wallet address for Burst Explorer
* timeSeed - Genesis time
* blockRewardLife - Block reward lifetime in blocks
* cleanPerDays - Clean up older Pools blocks in Days (Default 3 months - 90 Days)
* refreshMarket - Refresh Market Prices for Burst (Default 5 minutes)
* netDiffFactor - NetDiff Factor
* serverTimeZone - Server Time Zone

Create a database and a user for this. For example:

```
echo "CREATE DATABASE burstexplorer; CREATE USER 'burstexplorer'@'localhost' IDENTIFIED BY 'yourpassword'; GRANT ALL PRIVILEGES ON burstexplorer.* TO 'burstexplorer'@'localhost';" | mysql -uroot
mysql -uroot burstexplorer < burstexplorer.sql
```

Set your database name, user and password in index.php.

```
$f3->set('db', new DB\SQL(
    'mysql:host=localhost;port=3306;dbname=burstexplorer', <- database name
    'burstexplorer', <- username
	'12345678', <- password
	array( 
		\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION 
	)
));
```

At first time, - maybe - will need some minutes to initialize the database table.

### Built With

* [Fat-Free Framework](https://fatfreeframework.com/) - The web framework 
* [Material Design Lite](https://getmdl.io/) - Material design for interface
* [jQuery](https://jquery.com/) - JQuery
* [jQuery.simplecolorpicker](https://github.com/tkrotoff/jquery-simplecolorpicker) - JQuery Color Picker
* [ChartJS](http://www.chartjs.org/) - Simple, clean and engaging HTML5 based JavaScript charts
* [ThreeJS](https://threejs.org/) - Javascript 3D library
* [FlipClockJS](http://flipclockjs.com/) - JS counter/clock
* [MomentJS](https://momentjs.com/) - Parse, validate, manipulate, and display dates and times in JavaScript

### Authors

* **Vassilis** - If you like it make a donation BURST-YY7Z-K8KK-E2B9-AKQCQ

### License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

