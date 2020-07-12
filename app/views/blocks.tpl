
<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table blocksDataTable mainTable">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader" colspan="9">
                    <div class="tbHeaderDiv floatLeft"><i class="material-icons">view_day</i> <span>Blocks</span></div>
                    <div class="mdl-paging tbHeaderPagination floatLeft">
                        <a id="previousBlockPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__previous"><i class="material-icons">keyboard_arrow_left</i>
                        </a>
                        <a id="nextBlockPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__next"><i class="material-icons">keyboard_arrow_right</i>
                        </a>
                    </div>
                    <div class="mdl-paging tbHeaderPagination floatRight">
                        <a id="firstBlockPage" disabled="true" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__first"><i class="material-icons">arrow_back</i>
                        </a>
                        <a id="lastBlockPage" href="#" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-paging__last"><i class="material-icons">arrow_forward</i>
                        </a>
                    </div>
                </th>
            </tr>
          <tr>
            <th class="mdl-data-table__cell--non-numeric">Height</th>
            <th class="mdl-data-table__cell--non-numeric dateTd">Date</th>
            <th class="mdl-data-table__cell--non-numeric removeTiny">Txs</th>
            <th class="mdl-data-table__cell--non-numeric removeSmall">Amount</th>
            <th class="mdl-data-table__cell--non-numeric removeSmall">Fee</th>
            <th class="mdl-data-table__cell--non-numeric longTd">Generator</th>
            <th class="mdl-data-table__cell--non-numeric removeMedium">Size</th>
            <th class="mdl-data-table__cell--non-numeric removeMedium">Base Target</th>
            <th class="removeTiny"></th>
          </tr>
        </thead>
        <tbody id="blocksTableBody"> 
            <repeat group="{{ @blocks }}" value="{{ @block }}">
                <tr blockId="{{ @block.block }}">
                    <td class="mdl-data-table__cell--non-numeric {{ @block.numberOfTransactions?'bold':'' }}"><a menuLink="blocksLink" href="/block/{{ @block.block }}">{{ @block.height }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric dateTd">{{ @block.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeTiny">{{ @block.numberOfTransactions }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall">
                        <span class="underText" id="blockListTotalAmountNQT{{ @block.height }}">{{ @block.totalAmountNQT }}</span>
                        <marketTip parent="blockListTotalAmountNQT{{ @block.height }}" value="{{ @block.totalAmountNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric removeSmall">
                        <span class="underText" id="blockListFee{{ @block.height }}">{{ @block.totalFeeNQT }}</span>
                        <marketTip parent="blockListFee{{ @block.height }}" value="{{ @block.totalFeeNQT }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric longTd">
                        <a menuLink="accountsLink" href="/account/{{ @block.generator }}">{{ @block.generatorRS }}</a> 
                        <i accountId="{{ @block.generator }}" class="material-icons blockExpand floatRight removeTiny">keyboard_arrow_down</i>
                    </td> 
                    <td class="mdl-data-table__cell--non-numeric removeMedium">{{ @block.payloadLength }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeMedium">{{ @block.baseTarget }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeTiny"><i blockId="{{ @block.block }}" class="material-icons blockExpand floatRight">keyboard_arrow_down</i></td>
                </tr>
                <tr id="accountDetails{{ @block.generator }}" class="hide"><td class="mdl-data-table__cell--non-numeric" colspan="9"></td></tr>
                <tr id="blockDetails{{ @block.block }}" class="hide"><td class="mdl-data-table__cell--non-numeric" colspan="9"></td></tr>
            </repeat> 
        </tbody>
    </table>
</div>

<script>
    BlockPage = 1;
    maxBlockPage = parseInt(parseInt("{{ @blocks[0].height }}") / 100);
    if (maxBlockPage < parseInt("{{ @blocks[0].height }}")) maxBlockPage++;
</script>