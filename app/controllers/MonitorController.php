
<?php

    class MonitorController extends Controller {

        function monitor($f3) {
            $f3->set('pools', $this->getPools());

            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $f3->set('blocks', $this->formatBlocks($blocks->find(null, array('order' => 'height desc', 'limit' => 100))));
            $f3->set('subTitle', 'Monitor');

            $f3->set('activeLinkMenu', 'monitorLink');

            echo \Template::instance()->render('header.tpl');
            echo \Template::instance()->render('topbar.tpl');
            echo \Template::instance()->render('monitor.tpl'); 
            echo \Template::instance()->render('footer.tpl');
        }

        function monitorPage($f3) {
            $f3->set('pools', $this->getPools());

            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $f3->set('blocks', $this->formatBlocks($blocks->find(null, array('order' => 'height desc', 'limit' => 100))));

            echo \Template::instance()->render('monitor.tpl'); 
        }

        function netDiff() {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            
            $last2days = $this->formatBlocks($blocks->find(array('datediff(now(), from_unixtime(timestamp + ?)) <= 1', $this->timeSeed), array('order' => 'height desc')));

            $net = [];
            foreach($last2days as $block) {
                $net['height'][] = $block['height'];
                $net['netDiff'][] = $block['netDiff'];
            }

            $net['height'] = array_reverse($net['height']);
            $net['netDiff'] = array_reverse($net['netDiff']);

            echo json_encode($net);
        }

        function burstValue() {
            $bursts = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'burst');
            
            echo json_encode($burst);
        }

        function blocksPerDay() {
            $db = \Base::instance()->get('db');
            $blocks = $db->exec('select date(from_unixtime(timestamp+1407722400)) as dt, count(timestamp) as cnt from blocks group by dt');
            
            $perDay = [];
            foreach($blocks as $block) {
                $perDay['day'][] = $block['dt'];
                $perDay['blocks'][] = $block['cnt'];
            }

            echo json_encode($perDay);
        }

        private function getPools() {
            return \Base::instance()->get('db')->exec("SELECT pool, poolRS, poolName, count(poolName) as 'blocks' from blocks where FROM_UNIXTIME((timestamp + " . $this->timeSeed . "), '%Y-%m-%d') = CURDATE()  group by poolName order by blocks desc");
        }

        function getPoolsForPie() {
            $pools = \Base::instance()->get('db')->exec("SELECT pool, poolRS, poolName, count(poolName) as 'blocks' from blocks where FROM_UNIXTIME((timestamp + " . $this->timeSeed . "), '%Y-%m-%d') = CURDATE()  group by poolName order by blocks desc");

            $perPool = [];
            foreach($pools as $pool) {
                $perPool['pool'][] = $pool['poolName'];
                $perPool['blocks'][] = $pool['blocks'];
            }

            echo json_encode($perPool);
        }

        function getLastTime() {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            echo json_encode(date('Y-m-d H:i:s', $this->timeSeed + $blocks->find(null, array('order' => 'height desc', 'limit' => 1))[0]->timestamp));
        }

        function getSyncDb() {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $lastBlock = $blocks->find(null, array('order' => 'height desc', 'limit' => 1))[0]->height;

            $reallyLast = $this->getLastBlock();
            
            if ($lastBlock < $reallyLast) {
                // Get the last 1000 blocks for initialize
                if (($reallyLast - $lastBlock) > 1000) $lastBlock = $reallyLast - 1000;

                for($i = $lastBlock + 1; $i <= $reallyLast; $i++) {
                    $block = $this->addBlock($i);
                    $lastBlock++;
                }
            }

            if ($lastBlock < $reallyLast) echo json_encode(['sync' => 'failed']);
            else echo json_encode(['sync' => 'ok']);
        }

        private function addBlock($height) {
            $tempBlock = [];

            $block = $this->getApi('/burst?requestType=getBlock&height=' . $height);
            
            $tempBlock['generator'] = $block['generator'];
            $tempBlock['generatorRS'] = $block['generatorRS'];
            $tempBlock['baseTarget'] = $block['baseTarget'];
            $tempBlock['height'] = $block['height'];
            $tempBlock['timestamp'] = $block['timestamp'];
            
            $tempBlock['blockId'] = $block['block'];
            $acc = $this->getApi('/burst?requestType=getAccount&account=' . $tempBlock['generator']);
            if (array_key_exists('name', $acc)) $tempBlock['generatorName'] = $acc['name'];
            else $tempBlock['generatorName'] = NULL;
            
            $assignment = $this->getApi('/burst?requestType=getAccountTransactions&type=20&firstIndex=0&lastIndex=0&account=' . $tempBlock['generator'])['transactions'][0];
            
            $tempBlock['pool'] = $assignment['recipient'];
            $tempBlock['poolRS'] = $assignment['recipientRS'];
            
            if ($tempBlock['generator'] == $tempBlock['pool']) $tempBlock['poolName'] = 'Solo Miner';
            else {
                $tempBlock['poolName'] = $this->getApi('/burst?requestType=getAccount&account=' . $tempBlock['pool'])['name'];
            }

            if (!trim($tempBlock['poolName'])) $tempBlock['poolName'] = 'Solo Miner';

            if ($tempBlock['baseTarget'] > 0) $tempBlock['netDiff'] = intval($this->netDiffFactor / intval($tempBlock['baseTarget']));
            else $tempBlock['netDiff'] = 0;

            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            $timestamp = $blocks->find(null, array('order' => 'height desc', 'limit' => 1));

            $tempBlock['deadline'] = intval($tempBlock['timestamp']) - intval($timestamp[0]->timestamp);
            $tempBlock['reward'] = $block['blockReward'];
            $tempBlock['fee'] = $block['totalFeeNQT'];
            
            try {
                $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
                $blocks->reset();
                $blocks->blockId = $tempBlock['blockId'];
                $blocks->height = $tempBlock['height'];
                $blocks->generator = $tempBlock['generator'];
                $blocks->generatorRS = $tempBlock['generatorRS'];
                $blocks->generatorName = $tempBlock['generatorName'];
                $blocks->pool = $tempBlock['pool'];
                $blocks->poolRS = $tempBlock['poolRS'];
                $blocks->poolName = $tempBlock['poolName'];
                $blocks->timestamp = $tempBlock['timestamp'];
                $blocks->netDiff = $tempBlock['netDiff'];
                $blocks->deadline = $tempBlock['deadline'];
                $blocks->reward = $tempBlock['reward'];
                $blocks->fee = $tempBlock['fee'];
                $blocks->save();
            }
            catch(\PDOException $e) {
                // Do nothing
            }
        }

        function getStatus($f3) {
            $lastBlock = $this->getLastBlock();
            $lastChainBlock = $this->getBlockStatus();
            $lastDbBlock = $this->getLastDbBlock();
            $isSync = true;
            $isDbSync = true;

            if ($lastBlock != $lastChainBlock) {
                $isSync = false;
            }
            else if ($lastDbBlock != $lastBlock) {
                $isDbSync = false;
            }

            echo json_encode(array(
                'lastBlock' => $lastBlock,
                'lastChainBlock' => $lastChainBlock,
                'lastDbBlock' => $lastDbBlock,
                'sync' => $isSync,
                'dbSync' => $isDbSync,
                'btc' => $this->market()['btc'],
                'usd' => $this->market()['usd'],
                'eur' => $this->market()['eur']
            ));
        }

        function getLastDbBlock() {
            $blocks = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blocks');
            return $blocks->find(null, array('order' => 'height desc', 'limit' => 1))[0]->height;
        }

        private function formatBlocks($blocks) {
            $tempBlocks = [];

            foreach($blocks as $key => $value) {
                $tempBlocks[] = $this->formatBlock($value);
            }

            return $tempBlocks;
        }

        private function formatBlock($block, $onlyDate = false) {
            $tempBlock = [];

            $tempBlock['blockId'] = $block['blockId']; 
            $tempBlock['fee'] = intval($block['fee']) / 100000000;
            $tempBlock['deadline'] = date('i:s', $block['deadline']);
            if ($onlyDate) $tempBlock['timestamp'] = date('Y-m-d', intval($this->timeSeed) + intval($block['timestamp'])); 
            else $tempBlock['timestamp'] = date('Y-m-d H:i:s', intval($this->timeSeed) + intval($block['timestamp']));
            $tempBlock['reward'] = number_format($block['reward'], 0, '.', "'");
            $tempBlock['netDiff'] = $block['netDiff'];
            $tempBlock['height'] = $block['height'];
            $tempBlock['generator'] = $block['generator'];
            $tempBlock['generatorRS'] = $block['generatorRS'];
            $tempBlock['generatorName'] = $block['generatorName'];
            if (trim($tempBlock['generatorName']) == '') $tempBlock['generatorName'] = 'Undefined';
            $tempBlock['pool'] = $block['pool'];
            $tempBlock['poolRS'] = $block['poolRS'];
            $tempBlock['poolName'] = $block['poolName'];

            return $tempBlock;
        }

        private function getLastBlock() {
            return ($this->getApi('/burst?requestType=getMiningInfo')['height'] - 1);
        }

        private function getBlockStatus() {
            return $this->getApi('/burst?requestType=getBlockchainStatus')['lastBlockchainFeederHeight'];
        }

        private function getMiningInfo() {
            return json_encode($this->getApi('/burst?requestType=getMiningInfo'));
        }

    }