
<table class="mdl-data-table mdl-js-data-table mainTable removeMedium">
    <thead>
        <tr>
            <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="5">
                <div class="tbHeaderDiv floatLeft"><i class="material-icons">turned_in</i> <span>{{ count(@aliases.aliases) }} Aliases</span></div>
            </th>
        </tr>
      <tr>
        <th class="mdl-data-table__cell--non-numeric dateTd">Date</th>
        <th class="mdl-data-table__cell--non-numeric">Alias</th>
        <th class="mdl-data-table__cell--non-numeric longTd">Account</th>
        <th class="mdl-data-table__cell--non-numeric">Alias ID</th>
        <th class="mdl-data-table__cell--non-numeric">URI</th>
      </tr>
    </thead>
    <tbody id="aliasesTableBody"> 
        <repeat group="{{ @aliases.aliases }}" value="{{ @alias }}">
            <tr aliasId="{{ @alias.alias }}">
                <td class="mdl-data-table__cell--non-numeric dateTd">{{ @alias.timestamp }}</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @alias.aliasName }}</td>
                <td class="mdl-data-table__cell--non-numeric">
                    <a menuLink="accountLink" href="/account/{{ @alias.account }}">{{ @alias.accountRS }}</a>
                    <i accountId="{{ @alias.account }}" class="material-icons blockExpand floatRight removeTiny">keyboard_arrow_down</i>
                </td>
                <td class="mdl-data-table__cell--non-numeric">{{ @alias.alias }}</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @alias.aliasURI }}</td>
            </tr>
            <tr id="accountDetails{{ @alias.account }}" class="hide"><td class="mdl-data-table__cell--non-numeric" colspan="5"></td></tr>
        </repeat> 
    </tbody>
</table>

<table class="mdl-data-table mdl-js-data-table mainTable mobAliasTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">turned_in</i> <span>{{ count(@aliases.aliases) }} Aliases</span></div>
                </th>
            </tr>
          <tr>
            <th class="mdl-data-table__cell--non-numeric">Alias</th>
          </tr>
        </thead>
        <tbody id="aliasesTableBody"> 
            <repeat group="{{ @aliases.aliases }}" value="{{ @alias }}">
                <tr aliasId="{{ @alias.alias }}">
                    <td class="mdl-data-table__cell--non-numeric longTd">
                        {{ @alias.aliasName }} ({{ @alias.alias }})<br>
                        <a menuLink="accountLink" href="/account/{{ @alias.account }}">{{ @alias.accountRS }}</a><br>
                        {{ @alias.aliasURI }}<br>
                        {{ @alias.timestamp }}
                    </td>
            </repeat> 
        </tbody>
    </table>