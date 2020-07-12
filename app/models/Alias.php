
<?php

    class Alias extends Model {

        public function getAliases($search) {
            $result['aliases'][] = $this->getApi('/burst?requestType=getAlias&aliasName=' . $search);

            if (!array_key_exists('errorCode', $result)) {
                $result = $this->getApi('/burst?requestType=getAliases&account=' . $search);
            }

            foreach($result['aliases'] as $key => $alias) {
                $result['aliases'][$key]['timestamp'] = date('Y-m-d H:i:s', $this->timeSeed + $alias['timestamp']);
            }

            return $result;
        }

    }