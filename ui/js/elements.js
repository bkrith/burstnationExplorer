
/* Ajax */
$(document).ajaxStart(function() { 
    $("#p2").show();
});
$(document).ajaxStop(function() {
    $("#p2").hide();   
    $('#preloader').fadeOut();
});

$(document).ready(function () {
    $(document).ajaxComplete(function () {
        componentHandler.upgradeAllRegistered();
        disableBlockNav();
        disableTransactionNav();
        formatAmounts();
        if (activebutton == 'monitorLink') {
            monitorFncs();
        }
    });
});

/* Window */

$(window).on('popstate', function(e) {
    window.location.reload();
});

/* Document */

$(document).ready(function($) {  
    $("#p2").hide();
    $('#preloader').fadeOut('slow');
    active(activebutton);
});

/* Monitor */

function monitorFncs() {
    let x = 0;
    $('tr[class^="poolTr"], a[class^="poolTr"]').each(function (i, el) {
        $(el).css({
            'background-color': bgColors[parseInt(x / 2)], 
            'color': '#fff', 
            'font-weight': 700
            });
        
        x++;
    });

    tik = null;
}

/* Blocks */

$(document).on('click', 'i[blockId]', function(e) {
    e.preventDefault();
    let ths =$(this);
    let focusTrId = '#blockDetails' + ths.attr('blockId');
    if (ths.attr('blockId')) {
        if (ths.html() == 'keyboard_arrow_down') {
            ths.html('keyboard_arrow_up');

            $('tr[id^="blockDetails"]').addClass('hide');
        }
        else ths.html('keyboard_arrow_down');

        $(focusTrId).toggleClass('hide');
        ths.toggleClass('focusedTr');
    }
    if (!$(focusTrId).hasClass('hide')) {
        $('tr[id^="accountDetails"]').addClass('hide');
        $('i[accountId]').html('keyboard_arrow_down');
        $(focusTrId + ' td').load('/page/block/' + ths.attr('blockId')); 
    }
});

$(document).on('click', 'i[accountId]', function(e) {
    e.preventDefault();
    let ths =$(this);
    let focusTrId = '#accountDetails' + ths.attr('accountId');
    if (ths.attr('accountId')) {
        if (ths.html() == 'keyboard_arrow_down') {
            ths.html('keyboard_arrow_up');

            $('tr[id^="accountDetails"]').addClass('hide');
        }
        else ths.html('keyboard_arrow_down');

        $(focusTrId).toggleClass('hide');
        ths.toggleClass('focusedTr');
    }
    if (!$(focusTrId).hasClass('hide')) {
        $('tr[id^="blockDetails"]').addClass('hide');
        $('i[blockId]').html('keyboard_arrow_down');
        $(focusTrId + ' td').load('/page/account/' + ths.attr('accountId')); 
    }
});

$(document).on('click', 'button[id^="btxType"]', function (e) {
    e.preventDefault();
    let ths =$(this);
    let tp = ths.attr('id');
    let parent = ths.attr('parent');

    if (parent != '') parent = '#' + parent + ' ';

    activeTxMenu(tp, parent);

    tp = tp.split('btxType')[1];
    if (tp != '') {
        $('tr[btxType]').hide();
        $('tr[btxType="' + tp + '"]').show();
    }
    else {
        $('tr[btxType]').show();
    }
    $('#bTxs').html($('tr[btxType]:visible').length);
});

$(document).on('click', '#previousBlockPage', (event) => {
    event.preventDefault();

    if (!$('#previousBlockPage').attr('disabled')) {
        disableBlockNav(true);
        $('#blocksTableBody').load('/api/blocks/page/' + (BlockPage - 1), null, function () {
            BlockPage--;
            disableBlockNav();
            componentHandler.upgradeAllRegistered();
        });            
    }
});

$(document).on('click', '#nextBlockPage', (event) => {
    event.preventDefault();

    if (!$('#nextBlockPage').attr('disabled')) {
        disableBlockNav(true);
        $('#blocksTableBody').load('/api/blocks/page/' + (BlockPage + 1), null, function () {
            BlockPage++;
            disableBlockNav();
            componentHandler.upgradeAllRegistered();
        }); 
    }
});

$(document).on('click', '#firstBlockPage', (event) => {
    event.preventDefault();

    if (!$('#firstBlockPage').attr('disabled')) {
        disableBlockNav(true);
        $('#blocksTableBody').load('/api/blocks/page/1', null, function () {
            BlockPage = 1;
            disableBlockNav();
            componentHandler.upgradeAllRegistered();
        }); 
    }
});

$(document).on('click', '#lastBlockPage', (event) => {
    event.preventDefault();

    if (!$('#lastBlockPage').attr('disabled')) {
        disableBlockNav(true);
        $('#blocksTableBody').load('/api/blocks/page/' + maxBlockPage, null, function () {
            BlockPage = maxBlockPage;
            disableBlockNav();
            componentHandler.upgradeAllRegistered();
        }); 
    }
});

/* Transactions */


$(document).on('click', 'i[transactionId]', function(e) {
    e.preventDefault();
    let ths =$(this);
    let focusTrId = '#transactionDetails' + ths.attr('transactionId');
    if (ths.attr('transactionId')) {
        if (ths.html() == 'keyboard_arrow_down') {
            $('i[transactionId]').html('keyboard_arrow_down');
            ths.html('keyboard_arrow_up');

            $('tr[id^="transactionDetails"]').addClass('hide');
        }
        else ths.html('keyboard_arrow_down');

        $(focusTrId).toggleClass('hide');
        ths.toggleClass('focusedTr');
    }
    if (!$(focusTrId).hasClass('hide')) {
        $(focusTrId + ' td').load('/page/transaction/' + ths.attr('transactionId')); 
    }
});

$(document).on('click', 'button[id^="txType"]', function (e) {
    e.preventDefault();
    let ths =$(this);
    let tp = ths.attr('id');
    let parent = ths.attr('parent');

    if (parent != '') parent = '#' + parent + ' ';

    activeTxMenu(tp, parent);

    txtype = tp.split('txType')[1];

    if (txtype == '') txtype = -1;

    disableTransactionNav(true);
    $.get('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/count', function (countData) {
        $('#transactionsTableBody').load('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/page/1', null, function () {
            transactionPage = 1;
            maxTransactionPage = parseInt(JSON.parse(countData) / 10);
            if ((maxTransactionPage * 10) < JSON.parse(countData)) maxTransactionPage++;
            $('.countTxs').html(JSON.parse(countData));
            disableTransactionNav();
        }); 
    });
});

// Transaction Navigation

$(document).on('click', '#previousTransactionPage', (event) => {
    event.preventDefault();

    if (!$('#previousTransactionPage').attr('disabled')) {
        disableTransactionNav(true);
        $('#transactionsTableBody').load('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/page/' + (transactionPage - 1), null, function () {
            transactionPage--;
            disableTransactionNav();
            componentHandler.upgradeAllRegistered();
        });  
    }
});

$(document).on('click', '#nextTransactionPage', (event) => {
    event.preventDefault();

    if (!$('#nextTransactionPage').attr('disabled') && maxTransactionPage > 1) {
        disableTransactionNav(true);
        $('#transactionsTableBody').load('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/page/' + (transactionPage + 1), null, function () {
            transactionPage++;
            disableTransactionNav();
            componentHandler.upgradeAllRegistered();
        });  
    }
});

$(document).on('click', '#firstTransactionPage', (event) => {
    event.preventDefault();

    if (!$('#firstTransactionPage').attr('disabled')) {
        disableTransactionNav(true);
        $('#transactionsTableBody').load('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/page/1', null, function () {
            transactionPage = 1;
            disableTransactionNav();
            componentHandler.upgradeAllRegistered();
        }); 
    }
});

$(document).on('click', '#lastTransactionPage', (event) => {
    event.preventDefault();

    if (!$('#lastTransactionPage').attr('disabled') && maxTransactionPage > 1) {
        disableTransactionNav(true);
        $('#transactionsTableBody').load('/api/account/' + currentAccount + '/transactions/type/' + txtype + '/page/' + maxTransactionPage, null, function () {
            transactionPage = maxTransactionPage;
            disableTransactionNav();
            componentHandler.upgradeAllRegistered();
        });  
    }
});

$(document).on('click', 'a', function (event) {
    let ths =$(this);
    if (ths.attr('menuLink')) {
        event.preventDefault();
        ajaxLink(ths.attr('menuLink'), ths.attr('href'), '');
    }
});

/* Top Bar Menu */

$(document).on('click', '#blocksLink, #blocksLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/blocks', 'Blocks');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = '/blocks';
});

$(document).on('click', '#monitorLink, #monitorLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/monitor', 'Monitor');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = '/';
});

$(document).on('click', '#assetsLink, #assetsLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/assets', 'Assets');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = '/assets';
});

$(document).on('click', '#accountsLink, #accountsLinkMobile', function (e) {
    e.preventDefault(); 
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), getCurrentAccountLink(), 'Accounts');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = getCurrentAccountLink();
});

$(document).on('click', '#transactionsLink, #transactionsLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), getCurrentTransactionLink(), 'Transactions');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = getCurrentTransactionLink();
});

$(document).on('click', '#marketplaceLink, #marketplaceLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/marketplace', 'Marketplace');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = getCurrentTransactionLink();
});

$(document).on('click', '#aliasesLink, #aliasesLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/aliases', 'Aliases');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = getCurrentTransactionLink();
});

$(document).on('click', '#peersLink, #peersLinkMobile', function (e) {
    e.preventDefault();
    //$('#preloader').fadeIn();
    ajaxLink($(this).attr('id').replace("Mobile", ""), '/peers', 'Peers');
    $('.mdl-layout__drawer').removeClass('is-visible');
    $('.mdl-layout__obfuscator').removeClass('is-visible');
    //window.location.href = getCurrentTransactionLink();
});

/* Search */

$(document).on('click', 'i[id="searchOnExpand"]', function () {
    let search = $('#searchFld').val().trim();
    if (search != '') {
        $.get('/api/search/' + search, function(data) {
            try {
                let link = JSON.parse(data);
                ajaxLink(link.item + 'Link', link.url, link.title);
            }
            catch(e) {
                ajaxLink('', '/not-found', 'Not found');
            }
        });
    }
});

$(document).on('keypress', '#searchFld', function(event) {
    if (event.keyCode === 13) {
        let search = this.value.trim();
        $.get('/api/search/' + search, function(data) {
            try {
                let link = JSON.parse(data);
                ajaxLink(link.item + 'Link', link.url, link.title);
            }
            catch(e) {
                ajaxLink('', '/not-found', 'Not found');
            }
        });
    }
});

/* Assets */

$(document).on('input', '#searchAsset', function () {
    let search = $(this).val().toUpperCase().trim();
    if (search == '') {
        $('tr[assetTr]').show();
        $('i[cancelAssetSearch]').addClass('hide');
    }
    else {
        $('i[cancelAssetSearch]').removeClass('hide');
        $('tr[assetTr]').each(function (i, el) {
            if ($(el).attr('assetTr').toUpperCase().indexOf(search) != -1) {
                $(el).show();
            }
            else {
                $(el).hide();
            }
        });
    }
});

$(document).on('click', 'i[cancelAssetSearch]', function () {
    $('#searchAsset').val('');
    $('tr[assetTr]').show(); 
    $('i[cancelAssetSearch]').addClass('hide');
});

$(document).on('click', 'i[assetId]', function(e) {
    e.preventDefault();
    let ths =$(this);
    let assetId = ths.attr('assetId');
    assetPage(assetId);
});

$(document).on('click', 'i[newWinAsset]', function(e) {
    e.preventDefault();
    let ths =$(this);
    let assetId = ths.attr('newWinAsset');
    
    $.ajax({
        url: '/page/asset/' + assetId + '/' + ths.attr('item'),
        error: (err) => {
            console.log('no access to app api');
        },
        success: (assetData) => {
            try {
                let w = window.open();
                $(w.document.body).html(assetData);
            }
            catch(err) {
                
            }
        }
    });
});


/* Goods */

$(document).on('input', '#searchGoodCategory', function () {
    let search = $(this).val().toUpperCase().trim();
    let count = 0;
    if (search == '') {
        $('tr[goodTr]').show(); 
        count = $('tr[goodTr]').length;
        $('i[cancelGoodCategory]').addClass('hide');
    }
    else {
        $('i[cancelGoodCategory]').removeClass('hide');
        $('tr[goodTr]').each(function (i, el) {
            if ($(el).attr('goodTr').indexOf(search) != -1) {
                $(el).show();
                count++;
            }
            else {
                $(el).hide();
            }
        });
    }
    $('#numCategories').html(count);
});

$(document).on('click', 'i[cancelGoodCategory]', function () {
    $('#searchGoodCategory').val('');
    $('tr[goodTr]').show(); 
    $('i[cancelGoodCategory]').addClass('hide');
    $('#numCategories').html($('tr[goodTr]').length);
});

$(document).on('click', '#showAllCategories', function (e) {
    e.preventDefault();
    $('i[cancelGoodCategory]').click();
});

$(document).on('click', '#showNoTagCategories', function (e) {
    e.preventDefault();
    $('i[cancelGoodCategory]').click();
    $('i[cancelGoodSearch]').click();
    let countGoods = 0;
    $('div[goodTags]').each(function (i, el) {
        if ($(el).attr('goodTags') === '') {
            $(el).show();
            countGoods++;
        }
        else {
            $(el).hide();
        }
    });

    $('#numGoods').html('<strong>' + countGoods + '</strong> uncategorized products | <a id="showAllGoods" href="#">show all</a>');
});

$(document).on('input', '#searchGood', function () {
    $('i[cancelGoodCategory]').click();

    let countGoods = 0;
    let search = $(this).val().toUpperCase().trim();
    if (search == '') {
        $('div[goodTags]').show();
        $('i[cancelGoodSearch]').addClass('hide');
        countGoods = $('div[goodTags]').length;
    }
    else {
        $('i[cancelGoodSearch]').removeClass('hide');
        $('div[goodTags]').each(function (i, el) {
            if ($(el).text().toUpperCase().indexOf(search) != -1) {
                $(el).show();
                countGoods++;
            }
            else {
                $(el).hide();
            }
        });
    }
    if (search == '') {
        $('#numGoods').html('<strong>' + countGoods + '</strong> Products');
    }
    else {
        $('#numGoods').html('<strong>' + countGoods + '</strong> Products on "' + $(this).val().trim() + '" search | <a id="showAllGoods" href="#">show all</a>');
    }
});

$(document).on('click', 'i[cancelGoodSearch]', function () {
    $('#searchGood').val('');
    $('div[goodTags]').show(); 
    $('i[cancelGoodSearch]').addClass('hide');
    $('#numGoods').html('<strong>' + $('div[goodTags]').length + '</strong> products');
});

$(document).on('click', '#showAllGoods', function (e) {
    e.preventDefault();
    $('#searchGood').val('');
    $('div[goodTags]').show(); 
    $('i[cancelGoodSearch]').addClass('hide');
    $('#numGoods').html('<strong>' + $('div[goodTags]').length + '</strong> products');
});

$(document).on('click', '#goodCategoryLink', function (e) {
    e.preventDefault();
    $('i[cancelGoodSearch]').click();

    let countGoods = 0;
    let category = $(this).attr('goodTag');
    $('div[goodTags]').each(function (i, el) {
        let tags = $(el).attr('goodTags').toUpperCase();
        tags = tags.split(',');

        let found = false;
        $.each(tags, function (i, tag) {
            if (category === tag.trim()) {
                $(el).show();
                countGoods++;
                found = true;
                return false;
            }
        });

        if (!found) {
            $(el).hide();
        }
    });

    $('#numGoods').html('<strong>' + countGoods + '</strong> products in category <strong>' + category + '</strong> | <a id="showAllGoods" href="#">show all</a>');
});

/* Aliases */

$(document).on('keypress', '#searchAlias', function(event) {
    if (event.keyCode === 13) {
        let search = this.value.trim();
        $('#aliases-content').load('/page/aliases/' + search);
    }
});