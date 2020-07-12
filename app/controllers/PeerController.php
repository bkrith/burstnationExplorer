
<?php

    class PeerController extends Controller {

        function peers($f3) {
            $peers = new Peer(\Base::instance()->get('db'));

            $f3->set('activeLinkMenu', 'peersLink');
            $f3->set('subTitle', 'Peers');
            
            $prs = $peers->getPeers();
            $f3->set('peers', $prs['peers']);
            $f3->set('up', $prs['up']);
            $f3->set('down', $prs['down']);

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('peers.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function peersPage($f3) {
            $peers = new Peer(\Base::instance()->get('db'));

            $f3->set('activeLinkMenu', 'peersLink');

            $prs = $peers->getPeers();
            $f3->set('peers', $prs['peers']);
            $f3->set('up', $prs['up']);
            $f3->set('down', $prs['down']);
            
            echo \Template::instance()->render('peers.tpl'); 
        }

        function peersArray() {
            $peers = new Peer(\Base::instance()->get('db'));
            $tmp = [];
            $countries = [];

            $i = 0;
            foreach($peers->getPeersArray() as $peer) {
                $exist = false;
                for($x = 0 ; $x < count($countries); $x++) {
                    if ($countries[$x] == $peer['countryCode']) {
                        $exist = true;
                        break;
                    }
                }

                if (!$exist && $peer['countryCode'] != NULL) {
                    $countries[count($countries)] = $peer['countryCode'];
                }

                $exist = false;
                for($x = 0 ; $x < $i; $x++) {
                    if ($tmp[$x][1] == $peer['lat'] && $tmp[$x][0] == $peer['lon'] && $tmp[$x][2] == $peer['active']) {
                        $tmp[$x][4]++;
                        $exist = true;
                        break;
                    }
                }

                if (!$exist) {
                    $tmp[$i][1] = floatval($peer['lat']);
                    $tmp[$i][0] = floatval($peer['lon']);
                    $tmp[$i][2] = intval($peer['active']);
                    $tmp[$i][3] = $peer['countryCode'];
                    $tmp[$i][4] = 1; 
                    
                    $i++;
                }
            }
            //var_dump($countries);

            echo json_encode([
                'peers' => $tmp,
                'countries' => $countries
            ]);
        }
        
    }