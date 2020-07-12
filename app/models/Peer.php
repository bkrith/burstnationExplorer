
<?php

    class Peer extends DB\SQL\Mapper {

        protected $wallet = '';

        public function __construct(DB\SQL $db) {
            $this->wallet = \Base::instance()->get('wallet');

            $db->exec('create table if not exists peer (ip VARCHAR(50), announcedAddress VARCHAR(60), weight INT, uploadedVolume VARCHAR(10), downloadedVolume VARCHAR(10), application VARCHAR(10), version VARCHAR(10), platform VARCHAR(50), lat float, lon float, countryCode VARCHAR(2), country VARCHAR(50), active SMALLINT, refreshed timestamp, primary key(ip)) ENGINE=MEMORY');      
            
            parent::__construct($db, 'peer');      
        }

        public function getPeers() {
            $result = $this->getApi('/burst?requestType=getPeers&active=true')['peers'];
            $up = 0;
            $down = 0; 

            foreach($result as $peer) {
                $dbPeer = $this->getPeer($peer);
                $dif = NULL;

                if (!$this->dry()) {
                    $dbPeer = $dbPeer[0];
                    $dif = (strtotime('now') - strtotime($dbPeer['refreshed']));
                }

                if ($dif == NULL || $dif > 60) {        
                    $tmp = $this->getApi('/burst?requestType=getPeer&peer=' . $peer);   
                    if ($dif == NULL) {
                        $coOrd = json_decode(file_get_contents('http://ip-api.com/json/' . $peer . '?fields=lat,lon,countryCode,country'), true);
                        $tmp['lat'] = $coOrd['lat'];
                        $tmp['lon'] = $coOrd['lon'];
                        $tmp['countryCode'] = $coOrd['countryCode'];
                        $tmp['country'] = $coOrd['country'];
                    }
                    else {
                        $tmp['lat'] = $dbPeer['lat'];
                        $tmp['lon'] = $dbPeer['lon'];
                        $tmp['countryCode'] = $dbPeer['countryCode'];
                        $tmp['country'] = $dbPeer['country'];
                    }
                    $tmp['ip'] = $peer;
                    $up += intval($tmp['uploadedVolume']);
                    $down += intval($tmp['downloadedVolume']);
                    $tmp['downloadedVolume'] = $this->getVolume($tmp['downloadedVolume']);
                    $tmp['uploadedVolume'] = $this->getVolume($tmp['uploadedVolume']);
                    $this->addPeer($tmp);
                }
            }

            return [
                'peers' => $this->getAllPeers(),
                'up' => $this->getVolume($up),
                'down' => $this->getVolume($down)
            ];
        }

        private function getVolume($bytes) {
            $bytes = $bytes / 1024;
            $mb = false;

            if ($bytes < 1) {
                $bytes = $bytes * 1024;
            }
            else {
                $bytes = $bytes / 1024;
                if ($bytes < 1) {
                    $bytes = $bytes * 1024;
                }
                else {
                    $mb = true;
                }
            }

            $volume = strval(round($bytes, 0));

            if ($mb) {
                $volume .= ' MB';
            }
            else {
                $volume .= ' KB';
            }

            return $volume;
        }

        private function getPeer($peer) {
            $this->load(['ip = ?', $peer]);
            return $this->query;
        }

        private function getAllPeers() {
            $this->load();
            return $this->query;
        }

        public function getPeersArray() {
            $this->load();
            return $this->query;
        }

        private function addPeer($peer) {
            $this->load(['ip = ?', $peer['ip']]);

            $this->ip = $peer['ip'];
            $this->lat = $peer['lat'];
            $this->lon = $peer['lon'];
            $this->countryCode = $peer['countryCode'];
            $this->country = $peer['country'];
            $this->announcedAddress = $peer['announcedAddress'];
            $this->weight = $peer['weight'];
            $this->downloadedVolume = $peer['downloadedVolume'];
            $this->uploadedVolume = $peer['uploadedVolume'];
            $this->application = $peer['application'];
            $this->version = $peer['version'];
            $this->platform = $peer['platform'];
            $this->active = $peer['state'];
            $this->refreshed = date('Y-m-d H:i:s');
            
            $this->save();
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