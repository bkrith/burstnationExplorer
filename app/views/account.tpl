
    <div class="tableDiv">
        <table class="mdl-data-table mdl-js-data-table slimTable">
            <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric" colspan="2">
                        <div class="tbHeaderDiv floatLeft"><i class="material-icons">person</i> Account #{{ @account.account }}</div>
                    </th>
                </tr>
            </thead>
            <tbody> 
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Account</td>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" href="/account/{{ @account.account }}">{{ @account.accountRS }}</a></td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Numeric Account ID</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.account }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Public Key</td>
                    <td class="mdl-data-table__cell--non-numeric longTd">{{ @account.publicKey }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Name</td>
                    <td class="mdl-data-table__cell--non-numeric longTd">{{ isset(@account.name)?@account.name:'-' }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Description</td>
                    <td class="mdl-data-table__cell--non-numeric longTd">{{ @account.description }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Reward Recipient</td>
                    <td class="mdl-data-table__cell--non-numeric longTd"><a menuLink="accountsLink" href="/account/{{ @account.rewardRecipientId }}">{{ @account.rewardRecipient }}</a></td>
                </tr>
                <tr class="{{ @account.countTransactions == -1?'hide':'' }}">
                    <td class="mdl-data-table__cell--non-numeric">Transactions</td>
                    <td class="mdl-data-table__cell--non-numeric">{{ @account.countTransactions }}</td>
                </tr>
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">Balance</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <strong>
                            <span id="{{ @account.account }}" class="underText">{{ @account.effectiveBalanceNXT }} Burst</span>
                            <marketTip parent="{{ @account.account }}" value="{{ @account.effectiveBalanceNXT }}"></marketTip>
                        </strong>
                    </td>
                </tr>
                <tr class="{{ count(@account.assets)?'':'hide' }}">
                    <td class="mdl-data-table__cell--non-numeric">Assets Issuer</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <repeat group="{{ @account.assets }}" value="{{ @asset }}">
                            <a menuLink="assetsLink" href="/asset/{{ @asset.asset }}">#{{ @asset.asset }} ({{ @asset.name }})</a><br>
                        </repeat>
                    </td>
                </tr>
            </tbody>
        </table>
                    <table class="mdl-data-table mdl-js-data-table {{ @account.countTransactions == -1?'hide':'' }}">
                        <thead>
                            <tr>
                                <th class="mdl-data-table__cell--non-numeric" colspan="5">
                                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">swap_horiz</i> <span class="countTxs {{ @account.countTransactions == -1?'hide':'' }}">{{ @account.countTransactions }}</span> Transactions</div>
                                    <div class="mdl-paging tbHeaderPagination floatLeft {{ @account.countTransactions == -1?'hide':'' }}">
                                        <a id="previousTransactionPage" disabled="true" href="" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__previous"><i class="material-icons">keyboard_arrow_left</i>
                                        </a>
                                        <a id="nextTransactionPage" href="" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__next"><i class="material-icons">keyboard_arrow_right</i>
                                        </a> 
                                    </div>
                                    <div class="mdl-paging tbHeaderPagination floatRight hideExtraReallyTiny {{ @account.countTransactions == -1?'hide':'' }}">
                                        <a id="firstTransactionPage" disabled="true" href="" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__first"><i class="material-icons">arrow_back</i>
                                        </a>
                                        <a id="lastTransactionPage" href="" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__last"><i class="material-icons">arrow_forward</i>
                                        </a>
                                    </div>
                                    <div class="mdl-paging tbHeaderPagination floatRight hideExtraReallyTiny {{ @account.countTransactions == -1?'':'hide' }}">
                                        Restricted Account - too many transactions
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th colspan="5">
                                    <div class="mdl-button-group txTypeMenu tbHeaderDiv {{ @account.countTransactions == -1?'hide':'' }}">
                                        <button id="txType" parent="" class="active mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            All
                                        </button>
                                        <button id="txType0" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Payment
                                        </button>
                                            <button id="txType1" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Message
                                        </button>
                                        <button id="txType20" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Reward Recipient
                                        </button>
                                        <button id="txType2" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Asset
                                        </button>
                                        <button id="txType3" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Marketplace
                                        </button>
                                        <button id="txType21" parent="" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect">
                                            Escrow
                                        </button>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th class="mdl-data-table__cell--non-numeric dateTd">Date</th>
                                <th class="mdl-data-table__cell--non-numeric">ID</th>
                                <th class="mdl-data-table__cell--non-numeric removeSmall longTd">Sender</th>
                                <th class="mdl-data-table__cell--non-numeric">Amount</th>
                                <th class="mdl-data-table__cell--non-numeric removeMedium longTd">Recipient</th>
                            </tr>
                        </thead>
                        <tbody id="transactionsTableBody"> 
                            <repeat group="{{ @account.transactions }}" value="{{ @transaction }}">
                                <tr txtype="txType{{ @transaction.typed }}" class="txRow">
                                    <td class="mdl-data-table__cell--non-numeric dateTd">{{ @transaction.timestamp }}</td>
                                    <td class="mdl-data-table__cell--non-numeric">
                                        <a menuLink="transactionsLink" href="/transaction/{{ @transaction.transaction }}">{{ @transaction.transaction }}</a>
                                        <i transactionId="{{ @transaction.transaction }}" class="material-icons blockExpand floatRight removeTiny">keyboard_arrow_down</i>
                                    </td>
                                    <td class="mdl-data-table__cell--non-numeric removeSmall longTd"><a menuLink="accountsLink" href="/account/{{ @transaction.sender }}">{{ @transaction.senderRS }}</a></td>
                                    <td class="mdl-data-table__cell--non-numeric {{ @transaction.move }} boldText">
                                         
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
                                    <td class="mdl-data-table__cell--non-numeric removeMedium longTd"><a menuLink="accountsLink" href="/account/{{ @transaction.recipient }}">{{ @transaction.recipientRS }}</a></td>
                                </tr>
                                <tr id="transactionDetails{{ @transaction.transaction }}" class="hide"><td class="mdl-data-table__cell--non-numeric" colspan="5"></td></tr>
                            </repeat>
                        </tbody>
                    </table>
                
            <table class="mdl-data-table mdl-js-data-table {{ count(@account.forgedBlocks)?'':'hide' }}">
                <thead>
                    <tr>
                        <th class="mdl-data-table__cell--non-numeric">
                                <div class="tbHeaderDiv"><i class="material-icons">view_day</i> Forged Blocks</div>
                        </th>
                    </tr>
                </thead>
                <tbody> 
                    <repeat group="{{ @account.forgedBlocks }}" value="{{ @forged }}">
                        <tr>
                            <td class="mdl-data-table__cell--non-numeric">
                                <strong>Block <a menuLink="blocksLink" href="/block/{{ @forged.block }}">#{{ @forged.height }}</a></strong><br>
                                Reward: {{ @forged.blockReward }} Burst<br>
                                Fee: {{ @forged.totalFeeNQT }} Burst<br>
                                {{ @forged.timestamp }}
                            </td>
                        </tr>
                    </repeat>
                </tbody>
            </table>
    </div>
    

<script>
    currentAccount = '{{ @account.account }}';
    transactionPage = 1;
    txtype = -1;
    maxTransactionPage = parseInt(parseInt('{{ @account.countTransactions }}') / 20);
    if (maxTransactionPage < parseInt('{{ @account.countTransactions }}')) maxTransactionPage++;

    updateTitle('{{ @subTitle }}');
</script>
