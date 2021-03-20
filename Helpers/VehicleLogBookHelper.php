<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;

/**
 * -------------------------------------------------------
 * Helper class to get vehicle book records 
 * -------------------------------------------------------
 */
class VehicleLogBookHelper {

     /*
    * get list of all available log items
    */
    function getAll(): array{

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      

       return $result;
    }


    /**
     * get start and end year odometer reading
     */
    public function getOdometer(): array{
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      

       return $result;
    }

    /**
     * removes record from the vehicle log book
     */
    public function delOne($id): bool{
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectDelOne(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
}