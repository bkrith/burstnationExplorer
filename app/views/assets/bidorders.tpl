
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="4">
                    <div class="tbHeaderDiv floatLeft">{{ @bidOrders['count'] }} <span>Buy Orders</span></div>
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
            <repeat group="{{ @bidOrders['orders'] }}" value="{{ @bid }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @bid.accountRS }}">{{ @bid.accountRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @bid.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="bidp{{ @bid.order }}" class="underText">{{ @bid.priceNQT }}</span>
                        <marketTip parent="bidp{{ @bid.order }}" pos="right" value="{{ @bid.priceNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span id="bidt{{ @bid.order }}" class="underText">{{ @bid.total }}</span>
                        <marketTip parent="bidt{{ @bid.order }}" pos="right" value="{{ @bid.total }}"></marketTip>
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>