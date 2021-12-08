<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries;


class LiveStockHelper
{

    /**
     * ----------------------------------------------
     *  get livestock inventory
     * ---------------------------------------------*/
    public function GetLiveStock($current_page, $records, $is_active)
    {
        //get db
        $db = new Libraries\DBConnection();
        $pdo = $db->getPDO();

        //check if user already exists
        $stmt  = $pdo->prepare('call livestockGetAll(?,?,?)');
        $stmt->execute([$current_page, $records, $is_active]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      

        return $result;       
    }

    /**
     * -------------------------------------------------------
     * get livestock types presented on the farm
     * -------------------------------------------------------
     */
    public function getLivestockTypes() {

        //get db
        $db = new Libraries\DBConnection();
        $pdo = $db->getPDO();

        //check if user already exists
        $stmt  = $pdo->prepare('call livestockGetTypeAll()');
        $stmt->execute();

       $result = $stmt->fetchAll(\PDO::FETCH_ASSOC); 
        
       //get sub items
       for($i = 0; $i < count($result); $i++){           
           $result[$i]['sub_items'] = $this->getlivestockSubTypes($result[$i]['id']);
       }

        return $result;
   }

   public function getlivestockSubTypes($parent_id) {

       //get db
       $db = new Libraries\DBConnection();
       $pdo = $db->getPDO();

       //check if user already exists
       $stmt  = $pdo->prepare('call livestockGetSubTypeAll(?)');
       $stmt->execute([$parent_id]);

       $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

       return $result;
  }

}