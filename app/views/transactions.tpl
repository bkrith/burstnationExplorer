
    <repeat group="{{ @transactions }}" value="{{ @transaction }}">
        <tr txtype="txType{{ @transaction.typed }}" class="txRow">
            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
            <td class="mdl-data-table__cell--non-numeric">
                <a menuLink="transactionsLink" href="/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a>
                <i transactionId="{{ @transaction.transaction }}" class="material-icons blockExpand floatRight">keyboard_arrow_down</i>
            </td>
            <td class="mdl-data-table__cell--non-numeric hideExtraTinyColumns"><a menuLink="accountsLink" href="/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
            <td class="mdl-data-table__cell--non-numeric {{ @transaction.move }} boldText hideExtraColumns">
                
                    <check if = "{{ @transaction.move == 'greenText' }}">
                        <span class="mdl-chip mdl-chip--contact">
                            <span class="mdl-chip__contact mdl-color--light-green mdl-color-text--white">+</span>
                            <span class="mdl-chip__text underText" id="transactionAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }} Burst</span>
                        </span>
                    </check>
                    <check if = "{{ @transaction.move == 'redText' }}">
                        <span class="mdl-chip mdl-chip--contact">
                            <span class="mdl-chip__contact mdl-color--red mdl-color-text--white">-</span>
                            <span class="mdl-chip__text underText" id="transactionAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }} Burst</span>
                        </span>
                    </check>
                    <marketTip parent="transactionAmountNQT{{ @transaction.transaction }}" value="{{ @transaction.amountNQT }}"></marketTip>
                
            </td>
            <td class="mdl-data-table__cell--non-numeric hideExtraTinyColumns"><a menuLink="accountsLink" href="/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
        </tr>
        <tr id="transactionDetails{{ @transaction.transaction }}" class="hide"><td class="mdl-data-table__cell--non-numeric" colspan="5"></td></tr>
    </repeat>
