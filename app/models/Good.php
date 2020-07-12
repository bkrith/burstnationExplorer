
<?php

    class Good extends Model {

        public function getGoods() {
            $goods = $this->getApi('/burst?requestType=getDGSGoods')['goods'];
            $tags = [];

            foreach($goods as $key => $good) {
                $goods[$key]['quantity'] = number_format($good['quantity'], 0, '.', "'");
                $goods[$key]['priceUE'] = $good['priceNQT'] / pow(10, 8);
                $goods[$key]['priceNQT'] = number_format($good['priceNQT'] / pow(10, 8), 8, '.', "'");
                $goods[$key]['tagsArray'] = array_map('strtoupper', array_filter(explode(',', $good['tags'])));
                $goods[$key]['image'] = NULL;
                $tags = array_merge($tags, $goods[$key]['tagsArray']);
                $description = $good['description'];
                // Get url images
                $imgTag = 'img';
                preg_match_all("#\[" . $imgTag . "\](.*?)\[/" . $imgTag . "\]#",$description,$matches);
                if (count($matches[0])) {
                    $description = str_replace($matches[0][0], '', $description);
                    $goods[$key]['image'] = $matches[1][0];
                }
                // Get urls and convert them to links
                preg_match_all('/https?\:\/\/[^\" ]+/i', $description, $match);
                foreach($match[0] as $url) {
                    $description = str_replace($url, '<a href="' . $url . '" target="_blank">' . $url . '</a>', $description);
                }
                $goods[$key]['description'] = $description;
            }

            sort($tags);

            return [
                'goods' => $goods,
                'tags' => array_unique($tags)
            ];
        }

    }