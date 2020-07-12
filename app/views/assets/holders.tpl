
    <table class="mdl-data-table mdl-js-data-table scrollTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="3">
                    <div class="tbHeaderDiv floatLeft">{{ @holders['count'] }} <span>Holders</span></div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric">Account</td>
                <td class="mdl-data-table__cell--non-numeric">Quantity</td>
                <td class="mdl-data-table__cell--non-numeric">Uncofirmed Quantity</td>
            </tr>
            <repeat group="{{ @holders['holders'] }}" value="{{ @holder }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @holder.accountRS }}">{{ @holder.accountRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @holder.quantityQNT }}</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @holder.unconfirmed }} %</td>
                </tr>
            </repeat>
        </tbody>
    </table>