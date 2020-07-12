<div class="tableDiv">

    <div class="charts1st margin5">

        <div class="mdl-card">
            <div class="mdl-card__supporting-text">
                <canvas id="netDiffChart"></canvas>
            </div>
        </div>

        <div class="mdl-card">
            <div class="mdl-card__supporting-text">
                <canvas id="blocksPerDayChart"></canvas>
            </div>
        </div>
    </div>

            <div class="charts margin5">

                <div class="mdl-card realTimeInfo">
                    <div class="mdl-card__supporting-text">
                        <span id="todayBlocks"></span> 
                        Blocks Today<br><br>
                        Block Reward <br>
                        <span id="blockRewardSpan" class="blueColor underText">{{ @blocks[0].reward }}</span> bursts<br><br>
                        <marketTip parent="blockRewardSpan" value="{{ @blocks[0].reward }}"></marketTip>
                        Mining Block #
                        <span id="lastBlock"></span>
                    </div>
                </div>
                <div id="countNext"></div>
                <div class="mdl-card">
                    <div class="mdl-card__supporting-text">
                        <canvas id="poolChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="poolsDiv margin5">
                <div class="mdl-card">
                    <div class="mdl-card__title"> 
                        <div class="tbHeaderDiv floatLeft"><i class="material-icons">group</i> <span>Blocks Per Pool</span></div>
                    </div>
                    <div class="mdl-card__supporting-text">
                        <table class="mdl-data-table mdl-js-data-table">
                            <thead>
                                <tr>
                                    <th class="mdl-data-table__cell--non-numeric">#</th>
                                    <th class="mdl-data-table__cell--non-numeric">Pool</th>
                                    <th class="mdl-data-table__cell--non-numeric">Blocks</th>
                                </tr>
                            </thead>
                            <tbody id="poolsTableBody"> 
                                <repeat group="{{ @pools }}" value="{{ @pool }}" counter="{{ @ctr }}">
                                    <tr class="poolTr{{ @ctr }}">
                                        <td class="mdl-data-table__cell--non-numeric">{{ @ctr }}</td>
                                        <td class="mdl-data-table__cell--non-numeric"><a menuLink="accountsLink" class="poolTr{{ @ctr }}" href="/account/{{ @pool.pool }}">{{ @pool.poolName }}</a></td>
                                        <td class="mdl-data-table__cell--non-numeric">{{ @pool.blocks }}</td>
                                    </tr>
                                </repeat>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

</div>

<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table poolsTable">
        <thead>
        <tr>
            <th class="mdl-data-table__cell--non-numeric">Block #</th>
            <th class="mdl-data-table__cell--non-numeric dateTd">Date</th>
            <th class="mdl-data-table__cell--non-numeric removeMedium">NetDiff</th>
            <th class="mdl-data-table__cell--non-numeric removeTiny">Deadline</th>
            <th class="mdl-data-table__cell--non-numeric removeMedium">Block Reward / Fee</th>
            <th class="mdl-data-table__cell--non-numeric longTd removeSmall">Address / Name</th>
            <th class="mdl-data-table__cell--non-numeric longTd">Pool Name</th>
        </tr>
        </thead>
        <tbody id="winnersTableBody"> 
            <repeat group="{{ @blocks }}" value="{{ @block }}">
                <tr>
                    <td class="mdl-data-table__cell--non-numeric"><a menuLink="blocksLink" href="/block/{{ @block.blockId }}">{{ @block.height }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric dateTd">{{ @block.timestamp }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeMedium">{{ @block.netDiff }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeTiny">{{ @block.deadline }}</td>
                    <td class="mdl-data-table__cell--non-numeric removeMedium">
                        <span id="winnerListReward{{ @block.height }}" class="underText">{{ @block.reward }}</span>
                        <marketTip parent="winnerListReward{{ @block.height }}" value="{{ @block.reward }}"></marketTip>
                        / 
                        <span id="winnerListFee{{ @block.height }}" class="underText">{{ @block.fee }}</span>
                        <marketTip parent="winnerListFee{{ @block.height }}" value="{{ @block.fee }}"></marketTip>
                    </td>
                    <td class="mdl-data-table__cell--non-numeric longTd removeSmall"><a menuLink="accountsLink" href="/account/{{ @block.generator }}">{{ @block.generatorName }}<br>{{ @block.generatorRS }}</a></td>
                    <td class="mdl-data-table__cell--non-numeric bold longTd"><a menuLink="accountsLink" class="winnerPoolLink" href="/account/{{ @block.pool }}">{{ @block.poolName }}</a></td>
                </tr>
            </repeat>
        </tbody>
    </table>
</div>
