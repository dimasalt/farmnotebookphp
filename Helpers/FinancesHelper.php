<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class FinancesHelper
{
    /**
    -----------------------------------------------------------
    * get list of all available transactions items based on search
    * term, dates and other selected parameters
    -----------------------------------------------------------
    */
    public function transactionsGetAll($search_term){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionsGetAll(?,?,?)');      
        $stmt->execute([$search_term, 1, 1]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        // for($i = 0; $i< count($result); $i++){
        //     if(strlen($result[$i]["desc"]) > 100 )
        //         $result[$i]['desc'] = substr($result[$i]['desc'], 0, 110) . '...';
        // }

       return $result;
    }


    
    /*
     * ---------------------------------------------------------
     * Gets one main transaction from database
     * ---------------------------------------------------------
     */
    public function transactionDel($id) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionDelMain(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;        
    }

    /**
     * ***********************************************************************************************
     *                      Transaction types
     * ************************************************************************************************
     */

      /**
     * get all transaction types 
     */
    public function getCategories(){        

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCatGetAll()');
        $stmt->execute();       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);    
        
        for($i = 0; $i< count($result); $i++){         
            //get all sub categories for the main category
            $result[$i]["sub_category"] = $this->transactionSubCatsGetAll($result[$i]["id"]);

        }                  


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