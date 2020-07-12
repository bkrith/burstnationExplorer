
<div id="block{{ @block.block }}" class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table slimTable">
            <thead>
              <tr>
                <th class="mdl-data-table__cell--non-numeric" colspan="2">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">view_carousel</i> Block #{{ @block.block }}</div>
                </th>
              </tr>
            </thead>
            <tbody> 
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Height</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.height }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Transactions</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.numberOfTransactions }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Total Amount</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="blockListTotalAmountNQT{{ @block.height }}">{{ @block.totalAmountNQT }} Burst</span>
                        <marketTip parent="blockListTotalAmountNQT{{ @block.height }}" value="{{ @block.totalAmountNQT }}"></marketTip>
                    </td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Transaction Fees</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <span class="underText" id="blockListTotalFeeNQT{{ @block.height }}">{{ @block.totalFeeNQT }} Burst</span>
                        <marketTip parent="blockListTotalFeeNQT{{ @block.height }}" value="{{ @block.totalFeeNQT }}"></marketTip>
                    </td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Timestamp</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.timestamp }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Generator</td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @block.generator }}">{{ @block.generatorRS }}</a></td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Block Generation Time</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.generationTime }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Base Target</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.baseTarget }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Size</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.payloadLength }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Version</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.version }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Nonce</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.nonce }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Block Reward</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @block.blockReward }} Burst</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Block Signature</td>
                    <td class="mdl-data-table__cell--non-numeric longTd">{{ @block.blockSignature }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Previous Block</td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="blocksLink" href="/block/{{ @block.previousBlock }}">{{ @block.previousBlock }}</a></td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Next Block</td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="blocksLink" href="/block/{{ @block.nextBlock }}">{{ @block.nextBlock }}</a></td>
                </tr>
            </tbody>
        </table>
        <check if = "{{ @block.numberOfTransactions > 0 }}">
    <true>
            <table class="mdl-data-table mdl-js-data-table">
                <thead>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="6">
                            <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i><span id="bTxs">{{ count(@block.transactions) }}</span> Transactions</div>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="5">
                            <div class="mdl-button-group txTypeMenu tbHeaderDiv">
                                <button id="btxType" parent="block{{ @block.block }}" class="active mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    All
                                </button>
                                <button id="btxType0" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Payment
                                </button>
                                    <button id="btxType1" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Message
                                </button>
                                <button id="btxType20" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Reward Recipient
                                </button>
                                <button id="btxType2" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Asset
                                </button>
                                <button id="btxType3" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Marketplace
                                </button>
                                <button id="btxType21" parent="block{{ @block.block }}" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                    Escrow
                                </button>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric">ID</th>
                        <th class="mdl-data-table__cell--non-numeric removeSmall longTd">Sender</th>
                        <th class="mdl-data-table__cell--non-numeric">Amount</th>
                        <th class="mdl-data-table__cell--non-numeric">Fee</th>
                        <th class="mdl-data-table__cell--non-numeric removeMedium longTd">Recipient</th>
                        <th class="mdl-data-table__cell--non-numeric dateTd">Date</th>
                    </tr>
                </thead>
                <tbody> 
                    <repeat group="{{ @block.transactions }}" value="{{ @transaction }}">
                        <tr btxType="{{ @transaction.type }}" class="txRow">
                            <td class="mdl-data-table__cell--non-numeric"><a menuLink="transactionsLink" href="/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric">
                                    <span class="underText" id="transactionAmountNQT{{ @transaction.transaction }}">{{ @transaction.amountNQT }}</span>
                                    <marketTip parent="transactionAmountNQT{{ @transaction.transaction }}" value="{{ @transaction.amountNQT }}"></marketTip>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric">
                                    <span class="underText" id="transactionFeeNQT{{ @transaction.transaction }}">{{ @transaction.feeNQT }}</span>
                                    <marketTip parent="transactionFeeNQT{{ @transaction.transaction }}" value="{{ @transaction.feeNQT }}"></marketTip>
                            </td>
                            <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @transaction.recipient }}">{{ isset(@transaction.recipientRS)?@transaction.recipientRS:'' }}</a></td>
                            <td class="mdl-data-table__cell--non-numeric">{{ @transaction.timestamp }}</td>
                        </tr>
                    </repeat>
                </tbody>
            </table>
    </true>
    <false>
        <div class="tableDiv">
            <h6><strong>No Block Transactions</strong></h6>
        </div>
    </false>
</check>
    </div>

    <script>
        updateTitle('{{ @subTitle }}');
    </script>