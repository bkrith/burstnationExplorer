
<?php

    class Model {

        protected $wallet = '';
        protected $timeSeed = 0;

        public function __construct() {
            $this->wallet = \Base::instance()->get('wallet');
            $this->timeSeed = \Base::instance()->get('timeSeed');
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

    }