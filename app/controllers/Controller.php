
<?php

    class Controller {

        private $refreshMarketEvery;
        public $timeSeed;
        public $wallet;
        public $netDiffFactor; 


        public function __construct() { 
            $this->refreshMarketEvery = \BASE::instance()->get('refreshMarket');
            $this->wallet = \BASE::instance()->get('wallet');
            $this->timeSeed = \BASE::instance()->get('timeSeed');
            $this->netDiffFactor = \BASE::instance()->get('netDiffFactor');

            \BASE::instance()->set('market', $this->market());
            
            \Template::instance()->extend('marketTip', function($node) {
                $value = $node['@attrib']['value'];
                $value = str_replace("{{ ", "", $value);
                $value = str_replace(" }}", "", $value);
                $parent = $node['@attrib']['parent'];
                if (array_key_exists('pos', $node)) $pos = $node['@attrib']['pos'];
                else $pos = 'right';

                return \Template::instance()->build('<div class="mdl-tooltip mdl-tooltip--' . $pos . ' mdl-tooltip--large alignLeft" for="' . $parent . '"> BTC: {{ number_format((@market["btc"] * str_replace("\'", "", ' . $value . ')), 8, ".", "\'") }}<br>USD: {{ number_format((@market["usd"] * str_replace("\'", "", ' . $value . ')), 8, ".", "\'") }}<br>EUR: {{ number_format((@market["eur"] * str_replace("\'", "", ' . $value . ')), 8, ".", "\'") }} </div>');
            });
        }  

        public function getUrl($url) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            $response = curl_exec($ch);
            curl_close($ch);
            return $response;
        }

        public function getApi($url) { 
            return json_decode($this->getUrl($this->wallet . $url), true);
        }

        public function market() { 
            $this->refreshMarket();

            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $marketValues = $market->find(null, array('limit' => 1))[0];

            $marketValues['btc'] = number_format($marketValues['btc'], 8, '.', "'");
            $marketValues['usd'] = number_format($marketValues['usd'], 8, '.', "'");
            $marketValues['eur'] = number_format($marketValues['eur'], 8, '.', "'");

            return $marketValues;
        }

        private function refreshMarket() {
            $market = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'market');
            $market->load(null, array('limit' => 1))[0];

            $d = new DateTime('', new DateTimeZone(\Base::instance()->get('serverTimeZone'))); 
            $tm = strtotime($d->format('Y-m-d H:i:s'));
            $tm2 = strtotime(date($market->timestamp));

            if (($tm - $tm2) > $this->refreshMarketEvery) {
                try {
                    $cap = json_decode(file_get_contents('http://api.coinmarketcap.com/v1/ticker/burst/?convert=EUR'))[0];

                    $market->btc = $cap->price_btc;
                    $market->usd = $cap->price_usd;
                    $market->eur = $cap->price_eur;

                    $d = new DateTime('', new DateTimeZone(\Base::instance()->get('serverTimeZone'))); 
                    $market->timestamp = $d->format('Y-m-d H:i:s');

                    $market->save();
                }
                catch (\PDOException $e) {
                    // Do nothing
                }
                catch(Exception $e) {
                    // Do nothing
                }
            }
        }

    }