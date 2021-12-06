<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries;


class LiveStockTypesHelper {

    /**
     * -----------------------------------------------------
     * Helper/Database Function to get list of livestock types
     * -----------------------------------------------------
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

      /**
     * add new transaction type
     */
    public function livestockCatSave($category_item): bool
    {

       //get db
       $db = new Libraries\DBConnection();
       $pdo = $db->getPDO();

        $stmt = $pdo->prepare('call livestockCatSave(?,?,?,?)');
        $stmt->execute(array(
            $category_item->id,
            $category_item->parent_id,
            $category_item->category_name,
            $category_item->category_description
        ));    

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /**
     * add new transaction type
     */
    public function livestockCatsDelete($category_id){
        
        //get db
        $db = new Libraries\DBConnection();
        $pdo = $db->getPDO();

        $stmt = $pdo->prepare('call livestockCatDelete(?)');
        $stmt->execute(array(
            $category_id
        ));    

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
}