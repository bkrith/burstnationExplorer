
let tday=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
let tmonth=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
let timezone = null;
let tzTime = null;
let lastDbBlock = 0;

appWorker();

function appWorker() {
    GetClock();
    refresh();
    setInterval(GetClock,1000);
    setInterval(refresh, 5000);
    clean();
}

function refresh() {
    $.ajax({
        url: '/api/blockchain/status',
        global: false
    })
    .done(function (sts) {
            let status = JSON.parse(sts);
            
            if (status.sync) {
                $('#inBlock').removeClass('errorBlockBox');
                if (!status.dbSync || lastDbBlock != status.lastDbBlock) { 
                    console.log('start syncing db..');
                    $('#offlineWallet').html('<span>Explorer syncing! Please wait...</span>');
                    $.ajax('/api/blockchain/syncdb')
                    .done(function (vvv) {  
                        $('#lastBlock').html(status.lastBlock + 1);
                        console.log('Sync DB: ok');
                        $('#offlineWallet').html('<span>Loading...</span>');
                        $.ajax('/api/monitor/lasttime')
                        .done(function (data) {
                            if (lastDbBlock != status.lastDbBlock) {
                                lastDbBlock = status.lastDbBlock;
                                if (activebutton == 'monitorLink') {
                                    console.log('reloading...');
                                    $('#page-content').load('/page/monitor/', function () {
                                        getNetDiff();
                                        $('#offlineWallet').fadeOut('slow',function(){$(this).remove();});
                                        getNewCounter(JSON.parse(data));
                                    });
                                }
                                else {
                                    $('#offlineWallet').fadeOut('slow',function(){$(this).remove();});
                                }
                            }
                        })
                        .fail(function () {
                            failAjax();
                        });
                    })
                    .fail(function () {
                        failAjax();
                    });
                }
                else {
                    $('#lastBlock').html(status.lastChainBlock + 1);
                    $('#offlineWallet').fadeOut('slow',function(){$(this).remove();});
                }
            }
            else {
                $('#lastBlock').html(status.lastBlock + 1);
                $('#inBlock').addClass('errorBlockBox');
                console.log('Wallet syncing with peers!');
        
                if (status.lastChainBlock == null) failAjax();
                else if (status.lastChainBlock == 0) $('#offlineWallet').html('<span>Wallet syncing with peers! Please wait...</span>');
                else $('#offlineWallet').html('<span>Wallet syncing! Please wait... | We are in block #' + status.lastBlock + ' | Blockchain is in block #' + status.lastChainBlock + '</span>');
            }

            $('#inBlock').html(status.lastBlock + 1);

            $('#marketPrices').html('BTC: ' + status.btc + ' | USD: ' + status.usd + ' | EUR: ' + status.eur);

            console.log('DB status: ' + status.lastDbBlock);
            console.log('Blockchain status: ' + status.lastChainBlock);
            console.log('Wallet/Node status: ' + status.lastBlock);
    })
    .fail(function () {
        failAjax();
    });
}; // check status for forked

function failAjax() {
    console.log('no access to app api');
    $('#offlineWallet').html('<span>Wallet is down! Please wait...</span>');
    $('#offlineWallet').fadeIn();
}

function clean() {
    $.ajax('/api/clean')
    .done(function (data) {
        console.log(JSON.parse(data));
    });
}; // check for old blocks and erase them

function getDateTime(d, timeOnly = false) { 
    let output = '';
    if (!timeOnly) {
        let nday = d.getDay(),
            nmonth = d.getMonth(),
            ndate = d.getDate(),
            nyear = d.getFullYear();

        output = tday[nday]+", "+tmonth[nmonth]+" "+ndate+", "+nyear+" ";
    }

    let nhour = d.getHours(),
        nmin = d.getMinutes(),
        nsec = d.getSeconds();

    if(nmin <= 9) nmin = "0"+nmin;
    if(nsec <= 9) nsec = "0"+nsec;

    output += nhour+":"+nmin+":"+nsec;

    return output;
}

function getNewCounter(lastTime) {
    if (lastTime != null && tzTime != null) {

        if ( typeof $('#lastblock').html() == 'undefined') {
            $.ajax({
                url: '/api/blockchain/status',
                global: false
            })
            .done(function (sts) {
                let status = JSON.parse(sts);
                $('#lastBlock').html(status.lastBlock + 1);
            })
            .fail(function () {
                failAjax();
            });
        }
        
        let cnt = null;
        let difDate = new Date();

        let lastTimeSplit = lastTime.split(' ');
        let lastTimeDate = lastTimeSplit[0].split('-');
        let lastTimeTime = lastTimeSplit[1].split(':');
        
        difDate.setFullYear(parseInt(lastTimeDate[0]));
        difDate.setMonth(parseInt(lastTimeDate[1]) - 1);
        difDate.setDate(parseInt(lastTimeDate[2]));
        difDate.setHours(lastTimeTime[0]);
        difDate.setMinutes(lastTimeTime[1]);
        difDate.setSeconds(lastTimeTime[2]);

        cnt = Math.abs(parseInt((tzTime - difDate) / 1000));

        let clock = $('#countNext').FlipClock(cnt);
    }
}

function GetClock() {
    if (timezone == null) {
        $.ajax('/api/timezone')
        .done(function (data) {
            timezone = JSON.parse(data).timezone;
        });
    }

    try {
        if (tzTime == null) {
            dd = moment().tz(timezone).format('dddd, MMMM D, YYYY HH:mm:ss');
            tzTime = new Date(dd);
            $.ajax('/api/monitor/lasttime')
            .done(function (data) {
                if (activebutton == 'monitorLink') {
                    getNewCounter(JSON.parse(data));
                }
                else {
                    $('#offlineWallet').fadeOut('slow',function(){$(this).remove();});
                }
            })
            .fail(function () {
                failAjax();
            });
        }
        else {
            tzTime.setSeconds(tzTime.getSeconds() + 1);
        }

        $('#clockbox').html(getDateTime(tzTime));
    }
    catch(err) {
    }
}