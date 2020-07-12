
<?php

    class AssetController extends Controller {

        function assets($f3) {
            $assets = new Asset();

            $f3->set('activeLinkMenu', 'assetsLink');
            $f3->set('assets', $assets->getAssets());
            $f3->set('subTitle', 'Assets');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('assets.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function asset($f3) {
            $assets = new Asset();

            $f3->set('activeLinkMenu', 'assetsLink');
            $f3->set('assets', $assets->getAssets());
            $f3->set('assetPage', $f3->get('PARAMS.asset'));

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('assets.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function assetPage($f3) {
            $assets = new Asset();

            $f3->set('activeLinkMenu', 'assetsLink');
            $f3->set('assets', $assets->getAssets());
            $f3->set('assetPage', $f3->get('PARAMS.asset'));

            echo \Template::instance()->render('assets.tpl'); 
        }

        function assetChart($f3) {
            $asset = new Asset();

            echo $asset->assetChart($f3->get('PARAMS.asset'));
        }

        function dividendsChart($f3) {
            $dividends = new Asset();
            $asset = $dividends->getAsset($f3->get('PARAMS.asset'));

            $dividends->getHolders($asset);
            echo json_encode($dividends->getDividends($asset));
        }

        function assetsPage($f3) {
            $assets = new Asset();

            $f3->set('activeLinkMenu', 'assetsLink');
            $f3->set('assets', $assets->getAssets());

            echo \Template::instance()->render('assets.tpl'); 
        }

        function detailsPage($f3) {
            $assets = new Asset();
            $asset = $assets->getAsset($f3->get('PARAMS.asset'));
            $f3->set('activeLinkMenu', 'assetsLink');
            $f3->set('subTitle', 'Asset #' . $asset['asset']);
            
            $f3->set('holders', $assets->getHolders($asset));
            $f3->set('askOrders', $assets->getAskOrders($asset));
            $f3->set('bidOrders', $assets->getBidOrders($asset));
            $f3->set('trades', $assets->getTrades($asset));

            $f3->set('asset', $asset);

            echo \Template::instance()->render('assets/details.tpl'); 
        }

        function allHolders($f3) {
            $assets = new Asset();
            $asset = $assets->getAsset($f3->get('PARAMS.asset'));
            $f3->set('holders', $assets->getHolders($asset, true));

            echo \Template::instance()->render('assets/holders.tpl'); 
        }

        function allAskOrders($f3) {
            $assets = new Asset();
            $asset = $assets->getAsset($f3->get('PARAMS.asset'));
            $f3->set('askOrders', $assets->getAskOrders($asset));

            echo \Template::instance()->render('assets/askorders.tpl'); 
        }

        function allBidOrders($f3) {
            $assets = new Asset();
            $asset = $assets->getAsset($f3->get('PARAMS.asset'));
            $f3->set('bidOrders', $assets->getBidOrders($asset));

            echo \Template::instance()->render('assets/bidorders.tpl'); 
        }

        function allTrades($f3) {
            $assets = new Asset();
            $asset = $assets->getAsset($f3->get('PARAMS.asset'));
            $f3->set('trades', $assets->getTrades($asset));

            echo \Template::instance()->render('assets/trades.tpl'); 
        }

    }