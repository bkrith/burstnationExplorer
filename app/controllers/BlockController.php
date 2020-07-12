
<?php

    class BlockController extends Controller {

        function blockPage($f3) {
            $blocks = new Block();

            $id = $f3->get('PARAMS.block');
            $block = $blocks->getById($id);
            $f3->set('block', $block);
            $f3->set('subTitle', 'Block #' . $block['height']);

            echo \Template::instance()->render('blocks/block.tpl');
        }

        function block($f3) {
            $blocks = new Block();

            $id = $f3->get('PARAMS.block');
            $block = $blocks->getById($id);
            $f3->set('block', $block);

            $f3->set('activeLinkMenu', 'blocksLink');
            $f3->set('subTitle', 'Block #' . $block['height']);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('blocks/block.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function blocks($f3) {
            $blocks = new Block();
            $f3->set('blocks', $blocks->getBlockPage(1));
            $f3->set('subTitle', 'Blocks');

            $f3->set('activeLinkMenu', 'blocksLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('blocks.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function blocksPage($f3) {
            $blocks = new Block();
            $f3->set('blocks', $blocks->getBlockPage(1));

            echo \Template::instance()->render('blocks.tpl'); 
        }

        function getBlocks($f3) {
            $page = $f3->get('PARAMS.page');

            $blocks = new Block();
            $page = $f3->get('PARAMS.page');
            $f3->set('blocks', $blocks->getBlockPage($page));
            
            echo \Template::instance()->render('blocks/blocks.tpl');
        }

        function height($f3) {
            $blocks = new Block();

            $height = $f3->get('PARAMS.height');
            $f3->set('block', $blocks->getByHeight($height));

            $f3->set('activeLinkMenu', 'blocksLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('blocks/block.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function heightPage($f3) {
            $blocks = new Block();

            $height = $f3->get('PARAMS.height');
            $f3->set('block', $blocks->getByHeight($height));

            $f3->set('activeLinkMenu', 'blocksLink');

            echo \Template::instance()->render('blocks/block.tpl');
        }

    }