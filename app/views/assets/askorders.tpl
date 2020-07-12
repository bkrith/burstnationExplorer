
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="4">
                    <div class="tbHeaderDiv floatLeft"> {{ @askOrders['count'] }} <span>Sell Orders</span></div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Account</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Price</td>
                <td class="mdl-data-table__cell--non-numeric">Total</td>
            </tr>
            <repeat group="{{ @askOrders['orders'] }}" value="{{ @ask }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @ask.accountRS }}">{{ @ask.accountRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @ask.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="askp{{ @ask.order }}" class="underText">{{ @ask.priceNQT }}</span>
                        <marketTip parent="askp{{ @ask.order }}" pos="right" value="{{ @ask.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="askt{{ @ask.order }}" class="underText">{{ @ask.total }}</span>
                        <marketTip parent="askt{{ @ask.order }}" pos="right" value="{{ @ask.total }}"></marketTip>
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>