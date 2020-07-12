
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="2">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i> Transaction #{{ @transaction.transaction }}</div>
                </th>
            </tr>
        </thead>
        <tbody> 
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Sender</td>
                <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Recipient</td>
                <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Amount</td>
                <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="transactionSingleAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }} Burst</span>
                        <marketTip parent="transactionSingleAmountNQT{{ @transaction.transaction }}" value="{{ @transaction.amountNQT }}"></marketTip>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Fee</td>
                <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="transactionFeeNQT{{ @transaction.transaction }}">{{ @transaction.feeNQT }} Burst</span>
                        <marketTip parent="transactionFeeNQT{{ @transaction.transaction }}" value="{{ @transaction.feeNQT }}"></marketTip>
                </td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Block</td>
                <td class="mdl-data-table__cell--non-numeric"><a menuLink="blocksLink" href="/block/{{ @transaction.block }}">{{ @transaction.block }}</a> / <a menuLink="blocksLink" href="/height/{{ @transaction.height }}">{{ @transaction.height }}</a></td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Type</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.type }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Message</td>
                <td class="mdl-data-table__cell--non-numeric longTd">{{ isset(@transaction.attachment.message)?@transaction.attachment.message:'-' }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">MessageIsText</td>
                <td class="mdl-data-table__cell--non-numeric">{{ isset(@transaction.attachment.messageIsText)?@transaction.attachment.messageIsText:'-' }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Version.Message</td>
                <td class="mdl-data-table__cell--non-numeric">{{ isset(@transaction.attachment['version.Message'])?@transaction.attachment['version.Message']:'-' }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Confirmations</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.confirmations }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Timestamp</td>
                <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature</td>
                <td class="mdl-data-table__cell--non-numeric longTd">{{ @transaction.signature }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Signature Hash</td>
                <td class="mdl-data-table__cell--non-numeric longTd">{{ @transaction.signatureHash }}</td>
            </tr>
            <tr>
                <td class="mdl-data-table__cell--non-numeric blockThTable">Full Hash</td>
                <td class="mdl-data-table__cell--non-numeric longTd">{{ @transaction.fullHash }}</td>
            </tr>
        </tbody>
    </table>
</div>

<script>
    currentTransaction = '{{ @transaction.transaction }}';
    updateTitle('{{ @subTitle }}');
</script>