
<?php

    class Account extends Model {

        public function getAccount($id) {
            $account = $this->getApi('/burst?requestType=getAccount&account=' . strtoupper($id));

            $infos = $this->getBalanceInfos($account['account']);
            $account['transactions'] = $infos['transactions'];
            $account['totalReceive'] = $infos['totalReceive'];
            $account['totalSent'] = $infos['totalSent'];
            $account['countTransactions'] = $infos['countTransactions'];
            $account['rewardRecipient'] = $infos['rewardRecipient']['rewardRecipient'];
            $account['rewardRecipientId'] = $infos['rewardRecipient']['rewardRecipientId'];
            $account['forgedBlocks'] = $this->formatForgedBlocks($this->getAccountBlocks($id)['blocks']);
            $account['assets'] = $this->getAssets($id);

            return $this->formatAccount($account);
        }

        public function justAccount($id) {
            return $this->getApi('/burst?requestType=getAccount&account=' . strtoupper($id));
        }

        private function getAccountBlocks($account) {
            return $this->getApi('/burst?requestType=getAccountBlocks&firstIndex=0&lastIndex=9&account=' . $account);
        }

        private function getAssets($id) {
            return $this->getApi('/burst?requestType=getAssetsByIssuer&account=' . $id)['assets'][0];
        }

        private function getBalanceInfos($account) {
            $transactions = new Transaction();
            $totalReceive = 0;
            $totalSent = 0;
            $count = $transactions->getTransactionsCount($account);
            $page = null;

            if ($count >= 0) {
                $page = $transactions->getTransactionPage($account, 1);
            }

            return array(
                'transactions' => $page,
                'totalReceive' => $totalReceive,
                'totalSent' => $totalSent,
                'countTransactions' => $count,
                'rewardRecipient' => $transactions->getRewardRecipient($account)
            );
        }

        private function formatAccount($account) {
            $account['effectiveBalanceNXT'] = number_format($account['effectiveBalanceNXT'] / 100000000, 8, '.', "'");
            $account['totalReceive'] = number_format($account['totalReceive'] / 100000000, 8, '.', "'");
            $account['totalSent'] = number_format($account['totalSent'] / 100000000, 8, '.', "'");
            
            if ($account['effectiveBalanceNXT'] <= 0) $account['effectiveBalanceNXT'] = 0;
            if (!array_key_exists('description', $account) || trim($account['description']) == '') $account['description'] = '-';

            return $account;
        }

        private function formatForgedBlocks($blocks) {
            if ($blocks) {
                foreach($blocks as $key => $value) {
                    $blocks[$key] = $this->formatForgedBlock($value);
                }
            }

            return $blocks;
        }

        private function formatForgedBlock($block) {
            $block['blockReward'] = number_format($block['blockReward'], 0, '.', "'");
            $block['totalFeeNQT'] = number_format($block['totalFeeNQT'] / 100000000, 0, '.', "'");
            $block['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $block['timestamp']);

            return $block;
        }

    }
