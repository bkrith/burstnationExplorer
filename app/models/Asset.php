
<?php

    class Asset extends Model {

        private $holders = [];

        public function getAssets() {
            $assets = $this->getApi('/burst?requestType=getAllAssets')['assets'];
            foreach($assets as $key => $asset) {
                $assets[$key] = $asset;
                $assets[$key]['quantityQNT'] = number_format($asset['quantityQNT'] / pow(10, $asset['decimals']), 0, '.', "'");
            }

            return $assets;
        }

        public function assetChart($asset) {
            $trades = $this->getApi('/burst?requestType=getTrades&asset=' . $asset)['trades'];

            $chartPrice = [];
            $chartTime = [];
            $volumes = [];
            $timestamp = ''; 

            foreach($trades as $trade) {
                $dt = date('Y-m-d', ($trade['timestamp'] + $this->timeSeed));
                $value = number_format($trade['priceNQT'] / pow(10, (8 - $trade['decimals'])), 8, '.', "");
                    
                if ($timestamp != $dt) {
                    $chartPrice[] = $value;
                    $chartTime[] = $dt;

                    $volumes[] = intval($trade['quantityQNT']) / pow(10, $trade['decimals']);
                }
                else if ($chartPrice[count($chartPrice) - 1] < $value) {
                    $chartPrice[count($chartPrice) - 1] = $value;

                    $volumes[count($volumes) - 1] = intval($volumes[count($volumes) - 1]) + (intval($trade['quantityQNT']) / pow(10, $trade['decimals']));
                }

                $timestamp = $dt;
            }

            return json_encode(array(array_reverse($chartPrice), array_reverse($chartTime), array_reverse($volumes)));
        }

        public function getAsset($id) {
            $asset = $this->getApi('/burst?requestType=getAsset&asset=' . $id);
            $asset['quantityQNT'] = number_format($asset['quantityQNT'] / pow(10, $asset['decimals']), 0, '.', "'");
            $tmpAcc = $this->getApi('/burst?requestType=getAccount&account=' . $asset['accountRS']);
            if (array_key_exists('name', $tmpAcc)) {
                $asset['accountName'] = $this->getApi('/burst?requestType=getAccount&account=' . $asset['accountRS'])['name'];
            }
            else {
                $asset['accountName'] = '';
            }
            $description = $asset['description'];
            preg_match_all('/https?\:\/\/[^\" ]+/i', $description, $match);
            foreach($match[0] as $url) {
                $description = str_replace($url, '<a href="' . $url . '" target="_blank">' . $url . '</a>', $description);
            }
            $asset['description'] = $description;

            return $asset;
        }

        public function getHolders($asset, $all = false) {
            $holders = $this->getApi('/burst?requestType=getAssetAccounts&asset=' . $asset['asset'])['accountAssets'];
            $tmp = [];
            $i = 0;

            foreach($holders as $key => $holder) {
                $this->holders[] = $holder['accountRS'];

                $holder['unconfirmed'] = number_format(($holders[$key]['unconfirmedQuantityQNT'] / $holders[$key]['quantityQNT']) * 100, 2, '.', "'");
                $holder['quantityQNT'] = number_format(($holder['quantityQNT'] / pow(10, $asset['decimals'])), 0, '', "'");
                $holder['unconfirmedQuantityQNT'] = number_format(($holder['unconfirmedQuantityQNT'] / pow(10, $asset['decimals'])), 0, '', "'");

                if ($all) {
                    $holders[$key] = $holder;
                }
                else {
                    $tmp[] = $holder;
                    $i++;

                    if ($i == 200) break;
                }
            }

            if ($all) {
                return [
                    'holders' => $holders,
                    'count' => count($holders)
                ];
            }
            else {
                return [
                    'holders' => $tmp,
                    'count' => count($holders)
                ];
            }
        }

        public function getAskOrders($asset, $all = false) {
            $orders = $this->getApi('/burst?requestType=getAskOrders&asset=' . $asset['asset'])['askOrders'];
            $tmp = [];
            $i = 0;
            $sum = 0;

            foreach($orders as $key => $order) {
                $order['quantityQNT'] = $order['quantityQNT'] / pow(10, $asset['decimals']);
                $order['priceNQT'] = $order['priceNQT'] / pow(10, 8 - $asset['decimals']);
                $order['total'] = $order['priceNQT'] * $order['quantityQNT'];
                $sum += $order['total'];
                
                if ($all) {
                    $orders[$key] = $order;
                }
                else {
                    $order['sum'] = number_format(($sum), 8, '.', "'");
                    $order['total'] = number_format($order['total'], 8, '.', "'");
                    $order['quantityQNT'] = number_format($order['quantityQNT'], 0, '', "'");
                    $order['priceNQT'] = number_format($order['priceNQT'], 8, '.', "'");

                    $tmp[] = $order;
                    $i++;

                    if ($i == 200) break;
                }
            }

            $sum = number_format($sum, 8, '.', "'");

            if ($all) {
                return [
                    'orders' => $orders,
                    'count' => count($orders),
                    'sum' => $sum
                ];
            }
            else {
                return [
                    'orders' => $tmp,
                    'count' => count($orders),
                    'sum' => $sum
                ];
            }
        }

        public function getBidOrders($asset, $all = false) {
            $orders = $this->getApi('/burst?requestType=getBidOrders&asset=' . $asset['asset'])['bidOrders'];
            $tmp = [];
            $i = 0;
            $sum = 0;

            foreach($orders as $key => $order) {
                
                $order['quantityQNT'] = $order['quantityQNT'] / pow(10, $asset['decimals']);
                $order['priceNQT'] = $order['priceNQT'] / pow(10, 8 - $asset['decimals']);
                $order['total'] = $order['priceNQT'] * $order['quantityQNT'];
                $sum += $order['total'];
                if ($i < 200) {
                    $order['sum'] = number_format(($sum), 8, '.', "'");
                    $order['total'] = number_format($order['total'], 8, '.', "'");
                    $order['quantityQNT'] = number_format($order['quantityQNT'], 0, '', "'");
                    $order['priceNQT'] = number_format($order['priceNQT'], 8, '.', "'");

                    if ($all) {
                        $orders[$key] = $order;
                    }
                    else {
                        $tmp[] = $order;
                        $i++;
                    }
                }
            }

            $sum = number_format($sum, 8, '.', "'");

            if ($all) {
                return [
                    'orders' => $orders,
                    'count' => count($orders),
                    'sum' => $sum
                ];
            }
            else {
                return [
                    'orders' => $tmp,
                    'count' => count($orders),
                    'sum' => $sum
                ];
            }
        }

        public function getDividends($asset) {
            $transactions = $this->getApi('/burst?requestType=getAccountTransactions&account=' . $asset['accountRS'] . '&type=0')['transactions'];
            $dividends = [];
            $dividends['date'] = [];
            $dividends['amount'] = [];

            $i = 0;
            foreach($transactions as $transaction) {
                if (in_array($transaction['recipientRS'], $this->holders)) {
                    $dt = date('Y-m-d', $transaction['timestamp'] + $this->timeSeed);

                    if (count($dividends['date']) == 0 || $dividends['date'][count($dividends['date']) - 1] != $dt) {
                        $dividends['amount'][] = number_format(($transaction['amountNQT'] / pow(10, 8)), 8, '.', "");
                        $dividends['date'][] = $dt;
                        $i++;
                    }
                    else {
                        $dividends['amount'][count($dividends['amount']) - 1] += number_format(($transaction['amountNQT'] / pow(10, 8)), 8, '.', "");
                    }
                }
            }

            return [
                'amount' => array_reverse($dividends['amount']),
                'date' => array_reverse($dividends['date'])
            ];
        }

        public function getTrades($asset, $all = false) {
            $trades = $this->getApi('/burst?requestType=getTrades&asset=' . $asset['asset'])['trades'];
            $tmp = [];
            $i = 0;
            $day = date('Y-m-d');
            $week = date('Y-m-d', strtotime('-7 days'));
            $month = date('Y-m-d', strtotime('-1 months'));
            $volumes = [0, 0, 0];
            foreach($trades as $key => $trade) {
                $dt = date('Y-m-d', ($trade['timestamp'] + $this->timeSeed));
                $trade['quantityQNT'] = $trade['quantityQNT'] / pow(10, $asset['decimals']);
                if ($dt >= $day) $volumes[0] += $trade['quantityQNT'];
                if ($dt >= $week) $volumes[1] += $trade['quantityQNT'];
                if ($dt >= $month) $volumes[2] += $trade['quantityQNT'];
                $trade['timestamp'] = date('Y-m-d', ($trade['timestamp'] + $this->timeSeed));
                $trade['priceNQT'] = $trade['priceNQT'] / pow(10, 8 - $asset['decimals']);
                $trade['total'] = number_format(($trade['priceNQT'] * $trade['quantityQNT']), 8, '.', "'");
                $trade['quantityQNT'] = number_format($trade['quantityQNT'], 0, '', "'");
                $trade['priceNQT'] = number_format($trade['priceNQT'], 8, '.', "'");
                
                if ($all) {
                    $trades[$key] = $trade;
                }
                else {
                    $tmp[] = $trade;
                    $i++;

                    if ($i == 200) break;
                }
            }

            $volumes[0] = number_format($volumes[0], 0, '.', "'");
            $volumes[1] = number_format($volumes[1], 0, '.', "'");
            $volumes[2] = number_format($volumes[2], 0, '.', "'");

            if ($all) {
                return [
                    'trades' => $trades,
                    'count' => count($trades),
                    'volumes' => $volumes
                ];
            }
            else {
                return [
                    'trades' => $tmp,
                    'count' => count($trades),
                    'volumes' => $volumes
                ];
            }
        }

    }
