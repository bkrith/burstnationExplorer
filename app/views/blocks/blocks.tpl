
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
        <tr id="accountDetails{{ @block.generator }}" class="hide removeTiny"><td class="mdl-data-table__cell--non-numeric" colspan="9"></td></tr>
        <tr id="blockDetails{{ @block.block }}" class="hide removeTiny"><td class="mdl-data-table__cell--non-numeric" colspan="9"></td></tr>
    </repeat>
