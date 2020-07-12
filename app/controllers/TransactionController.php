
<?php

    class TransactionController extends Controller {
        
        function transaction($f3) {
            $transaction = new Transaction();

            $id = $f3->get('PARAMS.transaction');
            $f3->set('transaction', $transaction->getTransaction($id));
            $f3->set('subTitle', 'Transaction #' . $id);

            $f3->set('activeLinkMenu', 'transactionsLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('transaction.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function transactionPage($f3) {
            $transaction = new Transaction();

            $id = $f3->get('PARAMS.transaction');
            $f3->set('transaction', $transaction->getTransaction($id));
            $f3->set('subTitle', 'Transaction #' . $id);

            $f3->set('activeLinkMenu', 'transactionsLink');

            echo \Template::instance()->render('transaction.tpl');
        }

        function transactions($f3) {
            $transactions = new Transaction();

            $page = $f3->get('PARAMS.page');
            $account = $f3->get('PARAMS.account');
            $txtype = $f3->get('PARAMS.txtype');
            $f3->set('transactions', $transactions->getTransactionPage($account, $page, $txtype));
            $f3->set('subTitle', 'Transactions');
            
            echo \Template::instance()->render('transactions.tpl');
        }

        function transactionsCount($f3) {
            $transactions = new Transaction();
            echo $transactions->getTransactionsCount($f3->get('PARAMS.account'), $f3->get('PARAMS.txtype'));
        }

    }