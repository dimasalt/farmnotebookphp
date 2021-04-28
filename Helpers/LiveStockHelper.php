<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries;


class LiveStockHelper
{

    /**
     * ----------------------------------------------
     *  get sheep inventory
     * ---------------------------------------------*/
    public function GetLiveStock($current_page, $records)
    {
        //get db
        $db = new Libraries\DBConnection();
        $pdo = $db->getPDO();

        //check if user already exists
        $stmt  = $pdo->prepare('call sp_GetLiveStock('.$current_page .',' . $records .')');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        //if user found return true else return false
        //        if($result == false) return false;
        //        else return true;

        return $result;
    }

    /**
     * -------------------------------------------------------
     * get livestock types presented on the farm
     * -------------------------------------------------------
     */
    public function getLiveStockTypes(){
        //get db
        $db = new Libraries\DBConnection();
        $pdo = $db->getPDO();

        //check if user already exists
//        $sql = 'CALL getFlockTypes()';
//        $stmt =   $stmt  = $pdo->prepare($sql);
        $stmt =   $stmt  = $pdo->prepare('call sp_getFlockTypes()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }

}