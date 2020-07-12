
<?php

    class MainController extends Controller {

        function home($f3) {
            $page = $f3->get('PARAMS.page');

            $blocks = new Block();
            $f3->set('blocks', $blocks->getBlockPage($page));
            $f3->set('subTitle', '');

            $f3->set('activeLinkMenu', 'monitorLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('monitor.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function tzone($f3) {
            echo json_encode(['timezone' => $f3->get('serverTimeZone')]);
        }

        function clean($f3) {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $blocks->load(array("FROM_UNIXTIME((timestamp + " . $f3->get('timeSeed') . "), '%Y-%m-%d') < (CURDATE() - INTERVAL " . $f3->get('cleanPerDays') . " DAY)"));
            
            try {
                while(!$blocks->dry()) {
                    $blocks->erase();
                    $blocks->next();
                }
            }
            catch(\PDOException $e) {
                // Do nothing
            }
            
            echo json_encode(array('cleaned' => 'ok', 'count' => $blocks->count(array("FROM_UNIXTIME((timestamp + " . $f3->get('timeSeed') . "), '%Y-%m-%d') < (CURDATE() - INTERVAL " . $f3->get('cleanPerDays') . " DAY)"))));
        }

        function search($f3) {
            $search = $f3->get('PARAMS.search');
            $result = null;

            $block = new Block();
            $result = $block->justById($search)['block'];

            if ($result == $search) {
                echo json_encode([
                    'url' => '/block/' . $search,
                    'item' => 'blocks',
                    'title' => 'Blocks'
                ]);
            }
            else {
                $result = $block->justByHeight($search)['height'];

                if ($result == $search) {
                    echo json_encode([
                        'url' => '/height/' . $search,
                        'item' => 'blocks',
                        'title' => 'Blocks'
                    ]);
                }
                else {
                    $account = new Account();
                    if (is_numeric($search)) $result = $account->justAccount($search)['account'];
                    else $result = $account->justAccount($search)['accountRS'];
            
                    if ($result == $search) {
                        echo json_encode([
                            'url' => '/account/' . $search,
                            'item' => 'accounts',
                            'title' => 'Accounts'
                        ]);
                    }
                    else {
                        $transaction = new Transaction();
                        $result = $transaction->justTransaction($search)['transaction'];

                        if ($result == $search) {
                            echo json_encode([
                                'url' => '/transaction/' . $search,
                                'item' => 'transactions',
                                'title' => 'Transactions'
                            ]);
                        }
                        else {
                            echo '/not-found';
                        }
                    }
                }
            }
        }

        function notFound($f3) {
            $f3->set('subTitle', 'Not Found');
            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('404.tpl');
            echo \Template::instance()->render('footer.tpl');
        }

        function notFoundPage($f3) {
            echo \Template::instance()->render('404.tpl');
        }

    }