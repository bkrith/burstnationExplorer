
<div class="rowDiv">
    <table class="mdl-data-table mdl-js-data-table mainTable smallAssetTable">
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Asset</td>
                <td class="mdl-data-table__cell--non-numeric">
                    {{ @asset.name }}<a href="{{ @officialWallet }}/index.html#asset:{{ @asset.asset }}" target="_blank"><i class="material-icons blockExpand">open_in_new</i></a><br>
                    <a menuLink="transactionsLink" href="/transaction/{{ @asset.asset }}">{{ @asset.asset }}</a>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Issuer</td>
                <td class="mdl-data-table__cell--non-numeric">
                    <a menuLink="accountsLink" href="/account/{{ @asset.accountRS }}">{{ @asset.accountName }}<br>{{ @asset.accountRS }}</a>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @asset.quantityQNT }} shares</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">
                    <span id="currentPriceTiny" class="underText">{{ @askOrders['orders'][0]['priceNQT'] }}</span> Burst
                    <marketTip parent="currentPriceTiny" pos="bottom" value="{{ @askOrders['orders'][0]['priceNQT'] }}"></marketTip>
                </td>
            </tr>
        </tbody>
    </table>
    <table class="mdl-data-table mdl-js-data-table mainTable removeSmall">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric longTd">Asset</th>
                <th class="mdl-data-table__cell--non-numeric longTd">Issuer</th>
                <th class="mdl-data-table__cell--non-numeric">Quantity</th>
                <th class="mdl-data-table__cell--non-numeric removeLarge">Day Volumes</th>
                <th class="mdl-data-table__cell--non-numeric removeLarge">Week Volumes</th>
                <th class="mdl-data-table__cell--non-numeric removeLarge">Month Volumes</th>
                <th class="mdl-data-table__cell--non-numeric">Price</th>
                <th class="mdl-data-table__cell--non-numeric"></th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric longTd">
                    {{ @asset.name }}<br>
                    <a menuLink="transactionsLink" href="/transaction/{{ @asset.asset }}">{{ @asset.asset }}</a>
                </td>
                <td class="mdl-data-table__cell--non-numeric longTd">
                    <a menuLink="accountsLink" href="/account/{{ @asset.accountRS }}">{{ @asset.accountName }}<br>{{ @asset.accountRS }}</a>
                </td>
                <td class="mdl-data-table__cell--non-numeric">{{ @asset.quantityQNT }} shares</td>
                <td class="mdl-data-table__cell--non-numeric removeLarge">{{ @trades['volumes'][0] }}</td>
                <td class="mdl-data-table__cell--non-numeric removeLarge">{{ @trades['volumes'][1] }}</td>
                <td class="mdl-data-table__cell--non-numeric removeLarge">{{ @trades['volumes'][2] }}</td>
                <td class="mdl-data-table__cell--non-numeric">
                    <span id="currentPrice" class="underText">{{ @askOrders['orders'][0]['priceNQT'] }}</span> Burst
                    <marketTip parent="currentPrice" pos="bottom" value="{{ @askOrders['orders'][0]['priceNQT'] }}"></marketTip>
                </td>
                <td class="mdl-data-table__cell--non-numeric"><a href="{{ @officialWallet }}/index.html#asset:{{ @asset.asset }}" target="_blank"><i class="material-icons blockExpand">open_in_new</i></a></td>
            </tr>
        </tbody>
    </table>
</div>
<div class="rowDiv"><span>{{ @asset.description | raw }}</span></div>
<div class="rowDiv">
    <div class="canvasDiv">
        <canvas id="priceChart{{ @asset.asset }}"></canvas>
    </div>
    <div class="canvasDiv">
        <canvas id="dividendsChart{{ @asset.asset }}"></canvas>
    </div>
</div>
<div class="rowDiv">
    <div>
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="4">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">remove_circle</i> {{ @askOrders['count'] }} <span>Sell Orders</span></div>
                    <div class="tbHeaderDiv floatRight">
                        Total: <span id="bidbigasksum" class="underText">{{ @askOrders['sum'] }}</span>
                        <marketTip parent="bidbigasksum" pos="bottom" value="{{ @askOrders['sum'] }}"></marketTip>
                        <i newWinAsset="{{ @asset.asset }}" item="askorders" class="material-icons blockExpand">open_in_new</i>
                    </div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric removeSmall accountTd">Account</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">Total</td>
                <td class="mdl-data-table__cell--non-numeric removeTiny">Sum</td>
            </tr>
            <repeat group="{{ @askOrders['orders'] }}" value="{{ @ask }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric removeSmall accountTd"><a menuLink="accountsLink" href="/account/{{ @ask.accountRS }}">{{ @ask.accountRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @ask.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="askp{{ @ask.order }}" class="underText">{{ @ask.priceNQT }}</span>
                        <marketTip parent="askp{{ @ask.order }}" pos="bottom" value="{{ @ask.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="askt{{ @ask.order }}" class="underText">{{ @ask.total }}</span>
                        <marketTip parent="askt{{ @ask.order }}" pos="bottom" value="{{ @ask.total }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric removeTiny">
                        <span id="asksum{{ @ask.order }}" class="underText">{{ @ask.sum }}</span>
                        <marketTip parent="asksum{{ @ask.order }}" pos="bottom" value="{{ @ask.sum }}"></marketTip>
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>
    </div>
    <div>
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="4">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">add_circle</i> {{ @bidOrders['count'] }} <span>Buy Orders</span></div>
                    <div class="tbHeaderDiv floatRight">
                        Total: <span id="bidbigbidsum" class="underText">{{ @bidOrders['sum'] }}</span>
                        <marketTip parent="bidbigbidsum" pos="bottom" value="{{ @bidOrders['sum'] }}"></marketTip>
                        <i newWinAsset="{{ @asset.asset }}" item="bidorders" class="material-icons blockExpand">open_in_new</i>
                    </div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric removeSmall accountTd">Account</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">Total</td>
                <td class="mdl-data-table__cell--non-numeric removeTiny">Sum</td>
            </tr>
            <repeat group="{{ @bidOrders['orders'] }}" value="{{ @bid }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric removeSmall accountTd"><a menuLink="accountsLink" href="/account/{{ @bid.accountRS }}">{{ @bid.accountRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @bid.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="bidp{{ @bid.order }}" class="underText">{{ @bid.priceNQT }}</span>
                        <marketTip parent="bidp{{ @bid.order }}" pos="bottom" value="{{ @bid.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="bidt{{ @bid.order }}" class="underText">{{ @bid.total }}</span>
                        <marketTip parent="bidt{{ @bid.order }}" pos="bottom" value="{{ @bid.total }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric removeTiny">
                        <span id="bidsum{{ @bid.order }}" class="underText">{{ @bid.sum }}</span>
                        <marketTip parent="bidsum{{ @bid.order }}" pos="bottom" value="{{ @bid.sum }}"></marketTip>
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>
    </div>
</div>
<div class="rowDiv">
    <div class="holdersDiv">
        <table class="mdl-data-table mdl-js-data-table scrollTable">
            <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="3">
                        <div class="tbHeaderDiv floatLeft"><i class="material-icons">group</i> {{ @holders['count'] }} <span>Holders</span></div>
                        <div class="tbHeaderDiv floatRight">
                            <i newWinAsset="{{ @asset.asset }}" item="holders" class="material-icons blockExpand">open_in_new</i>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody> 
                <tr>
                    <td class="mdl-data-table__cell--non-numeric accountTd">Account</td>
                    <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                    <td class="mdl-data-table__cell--non-numeric">Uncofirmed Quantity</td>
                </tr>
                <repeat group="{{ @holders['holders'] }}" value="{{ @holder }}">
                    <tr>
                        <td class="mdl-data-table__cell--non-numeric accountTd"><a menuLink="accountsLink" href="/account/{{ @holder.accountRS }}">{{ @holder.accountRS }}</a></td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @holder.quantityQNT }}</td>
                        <td class="mdl-data-table__cell--non-numeric">{{ @holder.unconfirmed }} %</td>
                    </tr>
                </repeat>
            </tbody>
        </table>
    </div>
    <div>
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="6">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">monetization_on</i> {{ @trades['count'] }} <span>Trades</span></div>
                    <div class="tbHeaderDiv floatRight">
                        <i newWinAsset="{{ @asset.asset }}" item="trades" class="material-icons blockExpand">open_in_new</i>
                    </div>
                </th>
            </tr>          
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric dateTd">Date</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">Total</td>
                <td class="mdl-data-table__cell--non-numeric removeSmall">Sell Order</td>
                <td class="mdl-data-table__cell--non-numeric removeSmall">Buy Order</td>
            </tr>
            <repeat group="{{ @trades['trades'] }}" value="{{ @trade }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric dateTd">{{ @trade.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @trade.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="tradep{{ @trade.askOrder }}{{ @trade.bidOrder }}" class="underText">{{ @trade.priceNQT }}</span>
                        <marketTip parent="tradep{{ @trade.askOrder }}{{ @trade.bidOrder }}" pos="bottom" value="{{ @trade.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="tradet{{ @trade.askOrder }}{{ @trade.bidOrder }}" class="underText">{{ @trade.total }}</span>
                        <marketTip parent="tradet{{ @trade.askOrder }}{{ @trade.bidOrder }}" pos="bottom" value="{{ @trade.total }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall"><a menuLink="transactionsLink" href="/transaction/{{ @trade.askOrder }}">{{ @trade.askOrder }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall"><a menuLink="transactionsLink" href="/transaction/{{ @trade.bidOrder }}">{{ @trade.bidOrder }}</a></td>
                </tr>
            </repeat>
        </tbody>
    </table>
    </div>
</div>

<script>
    updateTitle('{{ @subTitle }}');
</script>