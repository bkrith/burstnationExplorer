
<?php

    class GoodController extends Controller {

        function goods($f3) {
            $goods = new Good();

            $f3->set('activeLinkMenu', 'marketplaceLink');
            $f3->set('goods', $goods->getGoods());
            $f3->set('subTitle', 'Marketplace');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('goods.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function goodsPage($f3) {
            $goods = new Good();

            $f3->set('activeLinkMenu', 'marketplaceLink');
            $f3->set('goods', $goods->getGoods());

            echo \Template::instance()->render('goods.tpl'); 
        }
        
    }