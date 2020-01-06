<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;

class MedicationHelper
{
    public function getList(){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        for($i = 0; $i< count($result); $i++){
            $result[$i]['desc'] = substr($result[$i]['desc'], 1, 150) . '...';
        }

       return $result;
    }
}