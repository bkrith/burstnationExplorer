
<?php

    class AliasController extends Controller {

        function aliases($f3) {
            $aliases = new Alias();

            $f3->set('activeLinkMenu', 'aliasesLink');
            $f3->set('subTitle', 'Aliases');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('aliases.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function aliasesPage($f3) {
            $aliases = new Alias();

            $f3->set('activeLinkMenu', 'aliasesLink');

            echo \Template::instance()->render('aliases.tpl'); 
        }

        function aliasSearchPage($f3) {
            $aliases = new Alias();

            $f3->set('activeLinkMenu', 'aliasesLink');
            $f3->set('aliases', $aliases->getAliases($f3->get('PARAMS.search')));

            echo \Template::instance()->render('aliases/aliases.tpl'); 
        }
        
    }