
<?php

    class AccountController extends Controller {

        function account($f3) {
            $account = new Account();

            $id = $f3->get('PARAMS.account');
            $acc = $account->getAccount($id);
            $f3->set('account', $acc);
            $f3->set('subTitle', 'Account ' . $acc['accountRS']);

            $f3->set('activeLinkMenu', 'accountsLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('account.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function accountPage($f3) {
            $account = new Account();

            $id = $f3->get('PARAMS.account');
            $acc = $account->getAccount($id);
            $f3->set('subTitle', 'Account ' . $acc['accountRS']);
            $f3->set('account', $acc);

            echo \Template::instance()->render('account.tpl');
        }

    }