
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="6">
                    <div class="tbHeaderDiv floatLeft"> {{ @trades['count'] }} <span>Trades</span></div>
                </th>
            </tr>          
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Date</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">Total</td>
                <td class="mdl-data-table__cell--non-numeric">Sell Order</td>
                <td class="mdl-data-table__cell--non-numeric">Buy Order</td>
            </tr>
            <repeat group="{{ @trades['trades'] }}" value="{{ @trade }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">{{ @trade.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @trade.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="tradep{{ @trade.askOrder }}{{ @trade.bidOrder }}" class="underText">{{ @trade.priceNQT }}</span>
                        <marketTip parent="tradep{{ @trade.askOrder }}{{ @trade.bidOrder }}" pos="right" value="{{ @trade.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="tradet{{ @trade.askOrder }}{{ @trade.bidOrder }}" class="underText">{{ @trade.total }}</span>
                        <marketTip parent="tradet{{ @trade.askOrder }}{{ @trade.bidOrder }}" pos="right" value="{{ @trade.total }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="transactionsLink" href="/transaction/{{ @trade.askOrder }}">{{ @trade.askOrder }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="transactionsLink" href="/transaction/{{ @trade.bidOrder }}">{{ @trade.bidOrder }}</a></td>
                </tr>
            </repeat>
        </tbody>
    </table>