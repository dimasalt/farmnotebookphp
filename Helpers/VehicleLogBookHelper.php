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
    function bookLogsGetAll($year_id): array{

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleGetTravelRecords(?)');
        $stmt->execute([$year_id]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC); 

        //format date to readable human format
        for($i = 0; $i < count($result); $i++)
            $result[$i]['travel_date'] = date("M jS, Y", strtotime($result[$i]['travel_date']));

       return $result;
    }


    /**
     * get start and end year odometer reading //gets single record
     */
    public function getOdometer($date){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleGetOdometer(?)');
        $stmt->execute([$date]);

        $result = $stmt->fetch();            

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