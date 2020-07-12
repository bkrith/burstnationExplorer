
let mainTitle;
let subTitle;
let activebutton;
let currentAccount;
let currentTransaction;
let BlockPage;
let maxBlockPage;
let transactionPage; 
let txtype;
let maxTransactionPage;
let bgColors = [
    '#ac725e',
    '#d06b64',
    '#f83a22',
    '#fa573c',
    '#ff7537',
    '#ffad46',
    '#42d692',
    '#16a765',
    '#7bd148',
    '#b3dc6c',
    '#88e974',
    '#fad165',
    '#92e1c0',
    '#9f8187',
    '#9fc6e7',
    '#4986e7',
    '#9a9cff',
    '#b99aff',
    '#c2c2c2',
    '#cabdbf',
    '#cca6ac',
    '#f691b2',
    '#cd74e6',
    '#947a82',
    '#ac725e',
    '#d06b64',
    '#f83a22',
    '#fa573c',
    '#ff7537',
    '#ffad46',
    '#42d692',
    '#16a765',
    '#7bd148',
    '#b3dc6c',
    '#88e974',
    '#fad165',
    '#92e1c0',
    '#9f8187',
    '#9fc6e7',
    '#4986e7',
    '#9a9cff',
    '#b99aff',
    '#c2c2c2',
    '#cabdbf',
    '#cca6ac',
    '#f691b2',
    '#cd74e6',
    '#947a82'
];

function active(id){
    if(activebutton != '' && activebutton != null) {
        document.getElementById(activebutton).style['background-color'] = '#eee';
        document.getElementById(activebutton).style['color'] = '#000';
    }
    if (id != '' && $('#' + id).length) {
        document.getElementById(id).style['background-color'] = '#5f9cc7';
        document.getElementById(id).style['color'] = 'white';
    }

    activebutton = id;
    console.log(activebutton)
}

function formatAmounts() {
    $('.underText').each(function (i) {
        let txt = $(this).text();
        let split = txt.split('.');
        let del = '.';

        if (typeof split[1] == 'undefined') {
            split[1] = '';
            del = '';
        }

        $(this).html('<span class="bigNumber">' + split[0] + '</span>' + del + '<span class="smallNumber">' + split[1] + '</span>');
    });
};

let disableBlockNav = (alls = false) => {
    if (alls || maxBlockPage < 2) {
        $('#firstBlockPage').attr('disabled', true);
        $('#previousBlockPage').attr('disabled', true);
        $('#nextBlockPage').attr('disabled', true);
        $('#lastBlockPage').attr('disabled', true);
    }
    else {
        if (BlockPage < 2) {
            $('#firstBlockPage').attr('disabled', true);
            $('#previousBlockPage').attr('disabled', true);
            $('#nextBlockPage').attr('disabled', false);
            $('#lastBlockPage').attr('disabled', false);
        }
        else if (BlockPage < maxBlockPage) {
            $('#firstBlockPage').attr('disabled', false);
            $('#previousBlockPage').attr('disabled', false);
            $('#nextBlockPage').attr('disabled', false);
            $('#lastBlockPage').attr('disabled', false);
        }
        else {
            $('#firstBlockPage').attr('disabled', false);
            $('#previousBlockPage').attr('disabled', false);
            $('#nextBlockPage').attr('disabled', true);
            $('#lastBlockPage').attr('disabled', true);
        }
    }
}

let disableTransactionNav = (alls = false) => {
    if (alls || maxTransactionPage < 2) {
        $('#firstTransactionPage').attr('disabled', true);
        $('#previousTransactionPage').attr('disabled', true);
        $('#nextTransactionPage').attr('disabled', true);
        $('#lastTransactionPage').attr('disabled', true);
    }
    else {
        if (transactionPage < 2) {
            $('#firstTransactionPage').attr('disabled', true);
            $('#previousTransactionPage').attr('disabled', true);
            $('#nextTransactionPage').attr('disabled', false);
            $('#lastTransactionPage').attr('disabled', false);
        }
        else if (transactionPage < maxTransactionPage) {
            $('#firstTransactionPage').attr('disabled', false);
            $('#previousTransactionPage').attr('disabled', false);
            $('#nextTransactionPage').attr('disabled', false);
            $('#lastTransactionPage').attr('disabled', false);
        }
        else {
            $('#firstTransactionPage').attr('disabled', false);
            $('#previousTransactionPage').attr('disabled', false);
            $('#nextTransactionPage').attr('disabled', true);
            $('#lastTransactionPage').attr('disabled', true);
        }
    }
}

function ajaxLink(id, link, title) {
    $.ajax(linkToPage(link))
    .done(function (data) {
        $('#page-content').html(data);
        active(id);
        if (title != null && title != '') document.title = mainTitle + ' :: ' + title;

        history.pushState({menuLink: id, link: link}, title, link);
        document.getElementById("page-content").scrollIntoView(); 

        if (activebutton == 'monitorLink') {
            $.ajax('/api/monitor/lasttime')
            .done(function (data) {
                getNetDiff();
                getNewCounter(JSON.parse(data));
            })
            .fail(function () {
                failAjax();
            });
        }
    });
}

function linkToPage(link) {
    return '/page' + link;
}

function getCurrentAccountLink() {
    if (currentAccount) {
        return '/account/' + currentAccount;
    }
    else {
        return '/not-found';
    }
}

function getCurrentTransactionLink() {
    if (currentTransaction) {
        return '/transaction/' + currentTransaction;
    }
    else {
        return '/not-found';
    }
}

/* Transactions */
 
function activeTxMenu(id, parent){
    $(parent + '.txTypeMenu button').each(function (i, el) {
            if ($(el).attr('id') != id) $(el).removeClass('active');
            else $(el).addClass('active');
    });
}

/* Monitor Charts */

function getPoolChart() {
    $.ajax({
        url: '/api/monitor/pools',
        error: () => {
            console.log('no access to app api');
        },
        success: (poolsData) => {
            let pools = JSON.parse(poolsData);
            
            let ctx = document.getElementById("poolChart").getContext('2d');
            let myChart = new Chart(ctx, {
            type: 'pie',
            responsive: true,
            data: {
                labels: pools['pool'],
                datasets: [{
                    label: 'Blocks Per Pool',
                    data: pools['blocks'],
                    backgroundColor: bgColors,
                    borderColor: [
                        'rgba(255,99,132,1)',
                    ],
                    borderWidth: 1
                }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: 'Blocks Per Pool',
                        position: 'top'
                    }
                }
            });
        }
    });
}

function getNetDiff() {
    $.ajax({
        url: '/api/monitor/netdiff',
        error: (err) => {
            console.log(err);
            console.log('no access to app api');
        },
        success: (blocksData) => {
            let blocks = JSON.parse(blocksData);
            
            let ctx = document.getElementById("netDiffChart").getContext('2d');
            let myChart = new Chart(ctx, {
            type: 'line',
            responsive: true,
            data: {
                labels: blocks['height'],
                datasets: [{
                    label: 'Network Difficulty',
                    data: blocks['netDiff'],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                    ],
                    borderWidth: 1
                }]
                },
                options: {
                    elements: {
                        point: {
                            radius: 0
                        },
                        line: {
                            tension: 0
                        }
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:false
                            }
                        }]
                    }
                }
            });

            getBlocksPerDay();
        }
    });
}

function getBlocksPerDay() {
    $.ajax({
        url: '/api/monitor/blocksperday',
        error: () => {
            console.log('no access to app api');
        },
        success: (blocksData) => {
            let blocks = JSON.parse(blocksData);

            $('#todayBlocks').html(blocks['blocks'][blocks['blocks'].length - 1]);

            let days = blocks['day'];
            days.shift();
            let dayBlocks = blocks['blocks'];
            dayBlocks.shift();
            
            let ctx = document.getElementById("blocksPerDayChart").getContext('2d');
            let myChart = new Chart(ctx, {
            type: 'line',
            responsive: true,
            data: {
                labels: days,
                datasets: [{
                    label: 'Blocks Per Day',
                    data: dayBlocks,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                    ],
                    borderColor: [
                        'rgba(255,99,132,1)',
                    ],
                    borderWidth: 1
                }]
                },
                options: {
                    elements: {
                        point: {
                            radius: 1
                        },
                        line: {
                            tension: 0
                        }
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:false
                            }
                        }]
                    }
                }
            });

            getPoolChart();
        }
    });
}

/* Assets Charts */

function volumeInBurstChart(assetId, assets) {
    let ctxvb = document.getElementById("volumeInBurstChart" + assetId).getContext('2d');
    let myChartvb = new Chart(ctxvb, {
    type: 'line',
    responsive: true,
    maintainAspectRatio: false,
    data: {
        labels: assets[3],
        datasets: [{
            label: 'Trades (Burst)',
            data: assets[4],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1
        }]
        },
        options: {
            elements: {
                point: {
                    radius: 1
                },
                line: {
                    tension: 0
                }
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: false
                    }
                }]
            },
            tooltips: {
                enabled: true,
                mode: 'single',
                displayColors: false,
                callbacks: {
                    label: function(tooltipItem, data) {
                        let label = data.labels[tooltipItem.index]
                        let datasetLabel = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
                        return 'Volume: ' + datasetLabel + ' Burst'
                    },
                    title: function(tooltipItem, data) {
                        return tooltipItem[0].xLabel
                    }
                }
            }
        }
    });
}

function volumeChart(assetId, assets) {
    let ctxv = document.getElementById("volumeChart" + assetId).getContext('2d');
    let myChartv = new Chart(ctxv, {
    type: 'line',
    responsive: true,
    maintainAspectRatio: false,
    data: {
        labels: assets[3],
        datasets: [{
            label: 'Trades (Shares)',
            data: assets[2],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1
        }]
        },
        options: {
            elements: {
                point: {
                    radius: 1
                },
                line: {
                    tension: 0
                }
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: false
                    }
                }]
            },
            tooltips: {
                enabled: true,
                mode: 'single',
                displayColors: false,
                callbacks: {
                    label: function(tooltipItem, data) {
                        let label = data.labels[tooltipItem.index]
                        let datasetLabel = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
                        return 'Volume: ' + datasetLabel + ' Shares'
                    },
                    title: function(tooltipItem, data) {
                        return tooltipItem[0].xLabel
                    }
                }
            }
        }
    });
} 

function dividendsChart(assetId, dividends) {
    let ctxv = document.getElementById("dividendsChart" + assetId).getContext('2d');
    let myChartv = new Chart(ctxv, {
    type: 'line',
    responsive: true,
    maintainAspectRatio: false,
    data: {
        labels: dividends['date'],
        datasets: [{
            label: 'Dividends',
            data: dividends['amount'],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
            ],
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1
        }]
        },
        options: {
            elements: {
                point: {
                    radius: 1
                },
                line: {
                    tension: 0
                }
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: false
                    }
                }]
            },
            tooltips: {
                enabled: true,
                mode: 'single',
                displayColors: false,
                callbacks: {
                    label: function(tooltipItem, data) {
                        let label = data.labels[tooltipItem.index]
                        let datasetLabel = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
                        return 'Dividends: ' + datasetLabel + ' Burst'
                    },
                    title: function(tooltipItem, data) {
                        return tooltipItem[0].xLabel
                    }
                }
            }
        }
    });
} 

function priceChart(assetId, assets) {
    let ctx = document.getElementById("priceChart" + assetId).getContext('2d');
    let myChart = new Chart(ctx, {
    type: 'bar',

            responsive: true,
            maintainAspectRatio: false,
    data: {
        labels: assets[1],
        datasets: [{
            label: 'Value',
            type: 'line',
            yAxisID: 'y-axis-1',
            data: assets[0],
            fill: false,
            borderColor: [
                'rgba(255,99,132,1)',
            ],
            borderWidth: 1
        },{
            label: 'Trades (Shares)',
            type: 'bar',
            yAxisID: 'y-axis-2',
            data: assets[2],
            backgroundColor: '#5f9cc7',
        }]
    },
        options: {
            elements: {
                point: {
                    radius: 1
                },
                line: {
                    tension: 0
                }
            },
            tooltips: {
                mode: 'index',
                intersect: true,
            },
            scales: {
                xAxes: [{
                    display: true,
                    labels: {
                        show: true,
                    }
                }],
                yAxes: [{
                    type: "linear",
                    display: true,
                    position: "left",
                    id: "y-axis-1",
                    labels: {
                        show:true,
                        
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }, {
                    type: "linear",
                    display: true,
                    position: "right",
                    id: "y-axis-2",
                    gridLines: {
                        display: false
                    },
                    labels: {
                        show:true,
                        
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            tooltips: {
                enabled: true,
                mode: 'label',
                displayColors: false,
                callbacks: {
                    label: function(tooltipItem, data) {
                        let label = data.labels[tooltipItem.index]
                        let datasetLabel = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]

                        if (tooltipItem.datasetIndex == 0) {
                            return 'Value: ' + datasetLabel + ' Burst'
                        }
                        else {
                            return 'Trades: ' + datasetLabel + ' Shares'
                        }
                    },
                    title: function(tooltipItem, data) {
                        return tooltipItem[0].xLabel
                    }
                }
            }
        }
    });
}

function updateTitle(title) {
    document.title = mainTitle + ' :: ' + title;
}

/* Assets */

function assetPage(assetId) {
    $.ajax({
        url: '/page/asset/' + assetId + '/details',
        error: (err) => {
            console.log('no access to app api');
        },
        success: (assetData) => {
            $('#asset-content').html(assetData);
            updateTitle('Asset #' + assetId);
            history.pushState({menuLink: assetId, link: '/asset/' + assetId}, 'Asset #' + assetId, '/asset/' + assetId);

            $.ajax({
                url: '/api/assets/chart/' + assetId,
                error: (err) => {
                    console.log('no access to app api');
                },
                success: (assetData) => {
                    let assets = JSON.parse(assetData);
                        
                    priceChart(assetId, assets);
                }
            });

            $.ajax({
                url: '/api/assets/' + assetId + '/dividends',
                error: (err) => {
                    console.log('no access to app api');
                },
                success: (dividends) => {
                    let divs = JSON.parse(dividends);
                        
                    dividendsChart(assetId, divs);
                }
            });
        }
    });
}