<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class FinancesTypeHelper
{

    /**
     * ***********************************************************************************************
     *                      Transaction types
     * ************************************************************************************************
     */

      /**
     * get all transaction types 
     */
    public function transactionCatsGetAll(){        

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCatGetAll()');
        $stmt->execute();       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }

    /**
     * Gets all sub categories for selected category
     */
    public function transactionSubCatsGetAll($parent_id){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCatGetAllSubs(?)');
        $stmt->execute(array($parent_id));       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }

    /**
     * add new transaction type
     */
    public function transactionCatSave($category_item): bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCatSave(?,?,?,?)');
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
    public function transactionCatsDelete($category_id){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCatDelete(?)');
        $stmt->execute(array(
            $category_id
        ));    

        if($stmt->rowCount() > 0) return true;
        else return false;
    }


}