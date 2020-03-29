<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;

class MedicationHelper
{
    /*
    * get list of all available medication items
    */
    public function getList(){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        // for($i = 0; $i< count($result); $i++){
        //     if(strlen($result[$i]["desc"]) > 100 )
        //         $result[$i]['desc'] = substr($result[$i]['desc'], 0, 110) . '...';
        // }

       return $result;
    }

    /*
    * gets a single medication item
    */
    public function getOne($id){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationGetOne(?)');
        $stmt->execute(array($id));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $result;
    }
}