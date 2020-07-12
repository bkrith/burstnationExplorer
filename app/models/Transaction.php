
<?php

    class Transaction extends Model {

        public function getTransaction($transaction) {
            $transaction = $this->getApi('/burst?requestType=getTransaction&transaction=' . $transaction);
            
            return $this->formatTransaction($transaction);
        }

        public function checkBlacklist($id) {
            $blacklist = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blacklist');
            return count($blacklist->find(array('accountId = ?', $id), array('limit' => 1)));
        }

        public function addInBlacklist($id) {
            $blacklist = new \DB\SQL\Mapper( \Base::instance()->get('db'), 'blacklist');
            $blacklist->accountId = $id;
            $blacklist->save();
        }

        public function getTransactionsCount($account, $txtype = -1) {
            if ($this->checkBlacklist($account)) {
                return -1;
            }
            if ($txtype < 0 || $txtype == null) $txtype = '';
            else $txtype = '&type=' . $txtype; 
            // $count = $this->getApi('/burst?requestType=getAccountTransactionCount' . $txtype . '&account=' . $account)['transactionsCount'];
            $count = count($this->getApi('/burst?requestType=getAccountTransactionIds' . $txtype . '&account=' . $account)['transactionIds']);

            if ($count > 80000) {
                $this->addInBlacklist($account);
                return -1;
            }

            return $count;
        }

        public function getTransactionPage($account, $page, $txtype = -1) {
            if ($page > 0) $page = $page - 1;
            if ($txtype < 0 || $txtype == null) $txtype = '';
            else $txtype = '&type=' . $txtype;
            
            $transactions = $this->getApi('/burst?requestType=getAccountTransactions' . $txtype . '&firstIndex=' . ($page * 20) . '&lastIndex=' . (($page * 20) + 19) . '&account=' . $account)['transactions'];

            return $this->formatTransactionsList($transactions, $account);
        }

        public function getRewardRecipient($id) {
            $recipient = $this->getApi('/burst?requestType=getAccountTransactions&type=20&firstIndex=0&lastIndex=1&account=' . $id)['transactions'][0]['recipient'];
            $account = new Account();
            $rec = $account->justAccount($recipient);
            return [
                'rewardRecipient' => $rec['name'],
                'rewardRecipientId' => $rec['account']
            ];
        }

        public function justTransaction($transaction) {
            $transaction = $this->getApi('/burst?requestType=getTransaction&transaction=' . $transaction);
            
            return $transaction;
        }


        // Util Functions

        private function formatTransactionsList($transactions, $account) {
            foreach($transactions as $key => $transaction) {
                $transactions[$key] = $this->formatTransaction($transaction, $account, false);
            }

            return $transactions;
        }

        private function formatTransaction($transaction, $account = null, $all = true) {
            $transaction['amountNQT'] = number_format($transaction['amountNQT'] / 100000000, 8, '.', "'");
            $transaction['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $transaction['timestamp']);
            if ($transaction['amountNQT'] == 0) $transaction['amountNQT'] = 0;
            if ($transaction['amountNQT'] == 0) {
                $transaction['move'] = '';
            }
            else if ($transaction['sender'] == $account || $transaction['senderRS'] == $account) {
                $transaction['move'] = 'redText';
            }
            else {
                $transaction['move'] = 'greenText';
            }

            $transaction['typed'] = $transaction['type'];
            if (!array_key_exists('recipient', $transaction)) {
                $transaction['recipient'] = '';
                $transaction['recipientRS'] = '';
            }

            if ($all) {
                $transaction['feeNQT'] = number_format($transaction['feeNQT'] / 100000000, 8, '.', "'");
                if (array_key_exists('attachment', $transaction)) {
                    if (array_key_exists('messageIsText', $transaction)) {
                        if ($transaction['attachment']['messageIsText']) $transaction['attachment']['messageIsText'] = 'True';
                        else $transaction['attachment']['messageIsText'] = 'False';
                    } 
                }

                if ($transaction['feeNQT'] == 0) $transaction['feeNQT'] = 0;

                switch($transaction['type']) {
                    case 0:
                        $transaction['type'] = 'Ordinary payment';
                        break;
                    case 1:
                        switch($transaction['subtype']) {
                            case 0:
                                $transaction['type'] = 'Arbitrary message';
                                break;
                            case 1:
                                $transaction['type'] = 'Alias assignment';
                                break;
                            case 2:
                                $transaction['type'] = 'Poll creation';
                                break;
                            case 3:
                                $transaction['type'] = 'Vote casting';
                                break;
                            case 4:
                                $transaction['type'] = 'Hub announcements';
                                break;
                            case 5:
                                $transaction['type'] = 'Acount info';
                                break;
                            case 6:
                                if ($transaction['attachment']['priceNQT'] == '0') {
                                    if ($transaction['sender'] == $account && $transaction['recipient'] == $account) {
                                        $transaction['type'] = 'Alias sale cancellation';
                                    }
                                    else {
                                        $transaction['type'] = 'Alias transfer';
                                    }
                                }
                                else {
                                    $transaction['type'] = 'Alias sell';
                                }
                                break;
                            case 7:
                                $transaction['type'] = 'Alias buy';
                                break;
                        }
                        break;
                    case 2:
                        switch($transaction['subtype']) {
                            case 0:
                                $transaction['type'] = 'Asset issuance';
                                break;
                            case 1:
                                $transaction['type'] = 'Asset transfer';
                                break;
                            case 2:
                                $transaction['type'] = 'Ask order placement';
                                break;
                            case 3:
                                $transaction['type'] = 'Bid order placement';
                                break;
                            case 4:
                                $transaction['type'] = 'Ask order cancellation';
                                break;
                            case 5:
                                $transaction['type'] = 'Bid order cancellation';
                                break;
                        }
                        break;
                    case 3:
                        switch($transaction['subtype']) {
                            case 0:
                                $transaction['type'] = 'Marketplace listing';
                                break;
                            case 1:
                                $transaction['type'] = 'Marketplace removal';
                                break;
                            case 2:
                                $transaction['type'] = 'Marketplace price change';
                                break;
                            case 3:
                                $transaction['type'] = 'Marketplace quantity change';
                                break;
                            case 4:
                                $transaction['type'] = 'Marketplace purchase';
                                break;
                            case 5:
                                $transaction['type'] = 'Marketplace delivery';
                                break;
                            case 6:
                                $transaction['type'] = 'Marketplace feedback';
                                break;
                            case 7:
                                $transaction['type'] = 'Marketplace refund';
                                break;
                        }
                        break;
                    case 4:
                        $transaction['type'] = 'Balance leasing';
                        break;
                    case 20:
                        $transaction['type'] = 'Reward recipient assignment';
                        break;
                    case 21:
                        switch($transaction['subtype']) {
                            case 0:
                                $transaction['type'] = 'Escrow creation';
                                break;
                            case 1:
                                $transaction['type'] = 'Escrow signing';
                                break;
                            case 2:
                                $transaction['type'] = 'Escrow result';
                                break;
                            case 3:
                                $transaction['type'] = 'Subscription subscribe';
                                break;
                            case 4:
                                $transaction['type'] = 'Subscription cancel';
                                break;
                            case 5:
                                $transaction['type'] = 'Subscription payment';
                                break;
                        }
                        break;
                    case 22:
                        switch($transaction['subtype']) {
                            case 0:
                                $transaction['type'] = 'AT creation';
                                break;
                            case 1:
                                $transaction['type'] = 'AT payment';
                                break;
                        }
                        break;
                }
            }

            return $transaction;
        }

    }
