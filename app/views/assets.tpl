<div class="dropAssets">
        <button id="demo-menu-lower-left"
            class="mdl-button mdl-js-button">
            <i class="material-icons">trending_up</i>
            <span>{{ count(@assets) }} Assets</span>
        </button>

        <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect"
            for="demo-menu-lower-left">
            <repeat group="{{ @assets }}" value="{{ @asset }}">
                <li class="mdl-menu__item" assetTr="{{ @asset.asset }}{{ @asset.name }}{{ @asset.accountRS }}">
                    <a menuLink="assetsLink" href="/asset/{{ @asset.asset }}">
                        <span class="bold">{{ @asset.name }}</span> 
                    </a>
                </li>
            </repeat>
        </ul>
</div>

<div class="assetDiv tableDiv">
    <table class="mdl-data-table mdl-js-data-table assetScrollTable assetSide removeMedium">
        <thead>
            <tr class="removeMedium">
                <th class="mdl-data-table__cell--non-numeric">
                    <div class="tbAssetHeaderDiv floatLeft"><i class="material-icons">trending_up</i> <span>{{ count(@assets) }} Assets</span></div>
                </th>
            </tr>
            <tr class="removeMedium">
                <th class="mdl-data-table__cell--non-numeric">
                    <i class="material-icons">search</i>
                    <div class="mdl-textfield mdl-js-textfield assetSearchDiv">
                        <input class="mdl-textfield__input" type="text" name="sample" id="searchAsset" placeholder="search...">
                    </div>
                    <i cancelAssetSearch="true" class="material-icons blockExpand hide">close</i>
                </th>
            </tr>
            <tr class="removeMedium">
                <th class="mdl-data-table__cell--non-numeric">Assets</th>
            </tr>
        </thead>
        <tbody id="assetsTableBody" class="removeMedium"> 
            <repeat group="{{ @assets }}" value="{{ @asset }}">
                <tr assetTr="{{ @asset.asset }}{{ @asset.name }}{{ @asset.accountRS }}">
                    <td class="mdl-data-table__cell--non-numeric">
                        <span class="bold">{{ @asset.name }}</span> 
                        <i assetId="{{ @asset.asset }}" accountRS="{{ @asset.accountRS }}" class="material-icons blockExpand floatRight">open_in_new</i><br>
                        <a menuLink="transactionsLink" href="/transaction/{{ @asset.asset }}">{{ @asset.asset }}</a><br>
                        {{ @asset.quantityQNT }} shares
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>
    <div id="asset-content">
        Select asset for details.
    </div>
</div>

<script>

    if ('{{ @assetPage }}' != '') {
        assetPage('{{ @assetPage }}');
    }

</script>