
<?php

    class Block extends Model {

        private $blocks = null;

        public function getBlockPage($page) {
            if ($page > 0) $page = $page - 1;
            else $page = 1;

            $this->blocks = $this->getApi('/burst?requestType=getBlocks&firstIndex=' . ($page * 100) . '&lastIndex=' . (($page * 100) + 99));
            
            return $this->formatBlocks()['blocks'];
        }

        public function getLastBlock() {
            $status = $this->getApi('/burst?requestType=getBlockchainStatus');
            $lastBlockHeight = $this->getApi('/burst?requestType=getBlock&block=' . $status['lastBlock'])['height'];
            
            return $lastBlockHeight;
        }

        public function getByHeight($height) {
            $block = $this->getApi('/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true');
            
            if (array_key_exists('errorCode', $block)) {
                return NULL;
            }
            else {
                $block = $this->formatBlock(true, $block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
        }

        public function justByHeight($height) {
            $block = $this->getApi('/burst?requestType=getBlock&height=' . $height . '&includeTransactions=true');
            
            return $block;
        }

        public function getById($id) {
            $block = $this->getApi('/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true');
            
            if (array_key_exists('errorCode', $block)) {
                return NULL;
            }
            else {
                $block = $this->formatBlock(true, $block);
                $block['transactions'] = $this->formatTransactions($block['transactions']);
                
                return $block;
            }
        }

        public function justById($id) {
            $block = $this->getApi('/burst?requestType=getBlock&block=' . $id . '&includeTransactions=true');
            
            if (array_key_exists('errorCode', $block)) {
                return NULL;
            }
            else {
                return block;
            }
        }

        private function formatBlocks($forPools = false) {
            foreach($this->blocks['blocks'] as $key => $value) {
                $this->blocks['blocks'][$key] = $this->formatBlock(false, $this->blocks['blocks'][$key], $forPools);
            }

            return $this->blocks;
        }

        private function formatBlock($single, $block, $forPools = false) {
            $block['totalAmountNQT'] = number_format($block['totalAmountNQT'] / 100000000, 8, '.', "'");
            $block['totalFeeNQT'] = number_format($block['totalFeeNQT'] / 100000000, 8, '.', "'");
            if ($single || $forPools) {
                $block['generationTime'] = $this->findBlockTimestamp($block['height'] - 1, $single);
                $block['generationTime'] = date('i:s', $block['timestamp'] - $block['generationTime']);

                $account = new Account(); 
                $tmpAcc = $account->justAccount($block['generator']);
                if (array_key_exists('name', $tmpAcc)) $block['generatorName'] = $account->justAccount($block['generator'])['name'];
                $block['generatorName'] = 'Undefined';
                $poolId = $this->getApi('/burst?requestType=getAccountTransactions&account=' . $block['generator'] . '&type=20&firstIndex=0&lastIndex=0')['transactions'][0]['recipient'];
                if ($block['generator'] == $poolId) {
                    $block['poolName'] = 'Solo Miners';
                }
                else {
                    $block['poolName'] = $account->justAccount($poolId)['name'];
                    if (trim($block['poolName']) == '') $block['poolName'] = 'Solo Miners';
                }
            }
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);
            $block['blockReward'] = number_format($block['blockReward'], 0, '.', "'");
            if ($block['payloadLength'] > 1024) $block['payloadLength'] = round($block['payloadLength'] / 1024, 2) . 'K';

            if ($block['totalAmountNQT'] <= 0) $block['totalAmountNQT'] = 0;
            if ($block['totalFeeNQT'] <= 0) $block['totalFeeNQT'] = 0;

            if ($forPools) {
                if ($block['baseTarget'] > 0) $block['netDiff'] = intval($this->netDiffFactor / intval($block['baseTarget']));  
                else $block['netDiff'] = 0;
            }

            return $block;
        }

        private function findBlockTimestamp($height, $single) {
            if ($single) {
                return $this->justByHeight($height)['timestamp']; 
            }
            else {
                foreach($this->blocks as $block) {
                    if ($block['height'] == $height) return $block['timestamp'];
                }
            }

            return 0;
        }

        private function formatTransactions($transactions) {
            foreach($transactions as $key => $value) {
                if (!array_key_exists('recipient', $transactions[$key])) {
                    $transactions[$key]['recipient'] = '';
                    $transactions[$key]['recipientRS'] = '';
                }
                $transactions[$key]['amountNQT'] = number_format($value['amountNQT'] / 100000000, 8, '.', "'");
                $transactions[$key]['feeNQT'] = number_format($value['feeNQT'] / 100000000, 8, '.', "'");
                $transactions[$key]['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $value['timestamp']);
                if ($transactions[$key]['amountNQT'] <= 0) $transactions[$key]['amountNQT'] = 0;
                if ($transactions[$key]['feeNQT'] <= 0) $transactions[$key]['feeNQT'] = 0;
            }

            return $transactions;
        }

    }
