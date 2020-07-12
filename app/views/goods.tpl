<div class="tableDiv">
    <table class="mdl-data-table mdl-js-data-table assetScrollTable goodSide">
        <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric tbHeader">
                    <div class="tbAssetHeaderDiv floatLeft"><i class="material-icons">shopping_basket</i> <span>{{ count(@goods['goods']) }} Products</span></div>
                </th>
            </tr>
            <tr>
                <th class="mdl-data-table__cell--non-numeric">
                    <i class="material-icons">search</i>
                    <div class="mdl-textfield mdl-js-textfield assetSearchDiv">
                        <input class="mdl-textfield__input" type="text" name="sample" id="searchGoodCategory" placeholder="search category...">
                    </div>
                    <i cancelGoodCategory="true" class="material-icons blockExpand hide">close</i>
                </th>
            </tr>
            <tr>
                <th class="mdl-data-table__cell--non-numeric">
                    <span id="numCategories">{{ count(@goods.tags) }}</span> Categories
                    <span class="floatRight"><a id="showAllCategories" href="#">all</a> | <a id="showNoTagCategories" href="#">no categorized</a></span>
                </th>
            </tr>
        </thead>
        <tbody id="assetsTableBody"> 
            <repeat group="{{ @goods.tags }}" value="{{ @tag }}">
                <tr goodTr="{{ @tag }}">
                    <td class="mdl-data-table__cell--non-numeric">
                        <a id="goodCategoryLink" goodTag="{{ @tag }}" href="#">{{ @tag }}</a>
                    </td>
                </tr>
            </repeat>
        </tbody>
    </table>
    <div id="good-content">
        <div class="rowDiv">
            <div id="numGoods" class="floatLeft numGoods">
                    <strong>{{ count(@goods['goods']) }}</strong> Products
            </div>
            <div class="floatRight">
                <i class="material-icons">search</i>
                <div class="mdl-textfield mdl-js-textfield assetSearchDiv">
                    <input class="mdl-textfield__input" type="text" name="sample" id="searchGood" placeholder="search...">
                </div>
                <i cancelGoodSearch="true" class="material-icons blockExpand hide">close</i>
            </div>
        </div>
        <div id="goodsDiv">
            <repeat group="{{ @goods.goods }}" value="{{ @good }}">
                <div class="mdl-card goods" goodTags="{{ @good.tags }}">
                    <div class="mdl-card__actions priceActionCard mdl-shadow--2dp">
                        <span class="floatRight goodPrice"><span id="goodPrice{{ @good.goods }}" class="underText">{{ @good.priceNQT }}</span> <img src="/ui/images/burst.png" /></span>
                        <marketTip parent="goodPrice{{ @good.goods }}" pos="bottom" value="{{ @good.priceNQT }}"></marketTip>
                        <div class="mdl-card__actions buyActionCard">
                            <span class="floatRight"><i class="material-icons">shopping_cart</i></span>
                        </div>
                    </div>
                    <div class="mdl-card__title mdl-card--border" style="height: 200px; background: url('/ui/images/empty.png') center / cover">
                        <check if="{{ @good.image }}">
                            <true>
                                <img id="goodImg" src="{{ @good.image }}" />
                            </true>
                        </check>
                    </div>
                    <div class="mdl-card__supporting-text mdl-card--border">
                        <h5>{{ @good.name }}</h5>
                    </div>
                    <div class="mdl-card__supporting-text flexText">
                        {{ @good.description | raw }}
                    </div>
                    <check if="{{ count(@good.tagsArray) }}">
                        <true>
                            <div class="mdl-card__actions">
                                <repeat group="{{ @good.tagsArray }}" value="{{ @tag }}">
                                    <span class="mdl-chip">
                                        <span class="mdl-chip__text"><a id="goodCategoryLink" goodTag="{{ @tag }}" href="#">{{ @tag }}</a></span>
                                    </span>
                                </repeat>
                            </div>
                        </true>
                    </check>
                    <span class="smallNumber floatRight">
                        from: <a menuLink="accountsLink" href="/account/{{ @good.sellerRS }}">{{ @good.sellerRS }}</a>
                    </span>
                </div>
            </repeat>
        </div>
    </div>
</div>
