
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
    <header class="mdl-layout__header mdl-shadow--4dp">
        <div class="mdl-layout__header-row">
            <!-- Title -->
            <span class="mdl-layout-title"><a href="/"><img src="/ui/images/logo.png" /></a> <span>the next Generation in Burst</span></span>
            
            <div class="mdl-layout-spacer"></div>

            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable
                mdl-textfield--floating-label mdl-textfield--align-right">
                <label class="mdl-button mdl-js-button mdl-button--icon"
                for="searchFld">
                <i id="searchOnExpand" class="material-icons">search</i>
                </label>
                <div class="mdl-textfield__expandable-holder">
                    <input class="mdl-textfield__input" type="text" name="sample"
                        id="searchFld" placeholder="Id / Height / RS">
                </div>
            </div>
            <div class="vertDivider"></div>
            <span class="mdl-layout--large-screen-only headerDetails" id="marketSpan">
                <span class="mdl-layout--large-screen-only" id="blockBox">Block: <span id="inBlock"></span></span><span class="mdl-layout--large-screen-only" id="clockbox"></span><br>
                <span id="marketPrices">Market: BTC: {{ @market['btc'] }} | USD: {{ @market['usd'] }} | EUR: {{ @market['eur'] }}</span>
            </span>
        </div>
    </header>
    <div class="mdl-layout__drawer mdl-layout--small-screen-only">
        <nav class="mdl-navigation">
            <button id="monitorLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Monitor
            </button>
            <button id="blocksLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Blocks
            </button>
            <button id="accountsLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Accounts
            </button>
            <button id="transactionsLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Transactions
            </button>
            <button id="assetsLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Assets
            </button>
            <button id="marketplaceLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Marketplace
            </button>
            </button>
            <button id="aliasesLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Aliases
            </button>
            </button>
                <button id="peersLinkMobile" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                Peers
            </button>
        </nav>
    </div>
    <div class="mdl-button-group mdl-layout--large-screen-only mdl-shadow--2dp">
        <button id="monitorLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Monitor
        </button>
        <button id="blocksLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Blocks
        </button>
        <button id="accountsLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Accounts
        </button>
        <button id="transactionsLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Transactions
        </button>
        <button id="assetsLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Assets
        </button>
        <button id="marketplaceLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Marketplace
        </button>
        </button>
        <button id="aliasesLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Aliases
        </button>
        </button>
            <button id="peersLink" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
            Peers
        </button>
    </div>
    <main class="mdl-layout__content">
        <div id="page-content">
            