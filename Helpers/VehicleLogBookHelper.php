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
    function bookLogsGetAll($odometer_id): array{

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleGetTravelRecords(?)');
        $stmt->execute([$odometer_id]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC); 

        //format date to readable human format
        for($i = 0; $i < count($result); $i++)
            $result[$i]['travel_date'] = date("M jS, Y", strtotime($result[$i]['travel_date']));

       return $result;
    }

    /**
     * ---------------------------------------------------------------
     * adds new odometer reading 
     * ---------------------------------------------------------------
     */

    public function odometerAddOrEdit($data){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleAddOrEditOdometer(?,?,?,?,?)');
        $stmt->execute([
            $data->odometer->id,
            $data->odometer->year_start_odometer,
            $data->odometer->year_end_odometer,
            $data->odometer->vehicle_desc,  
            $data->created_at
        ]);

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /**
     * get start and end year odometer reading //gets single record
     */
    public function getOdometer($data){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleGetOdometer(?)');
        $stmt->execute([$data]);

        $result = $stmt->fetch();            

       return $result;
    }

   /**
     * ---------------------------------------------------
     * removes odometer from records and all associated vehicle book log records
     * for selected year
     * ----------------------------------------------------
     */
    public function odometerDelOne($id): bool{
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleDelOdometer(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

      /**
     * -------------------------------------------------------------------------
     * add new book log item
     * -------------------------------------------------------------------------
     */
    public function booklogItemAdd($data): bool{

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleAddTravelRecord(?,?,?,?,?,?)');
        $stmt->execute([
            $data->vehicle_log_book_id,           
            $data->booklog_item->destination,
            $data->booklog_item->address,
            $data->booklog_item->purpose,
            $data->booklog_item->travel_distance,
            $data->booklog_item->travel_date
        ]);

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

       /**
     * -------------------------------------------------------------------------
     * delete vehidle book log item
     * -------------------------------------------------------------------------
     */
    public function booklogItemDel($id): bool{

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call vehicleDelTravelRecord(?)');
        $stmt->execute([ $id ]);

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
}