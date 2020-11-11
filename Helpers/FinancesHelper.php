<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;

class FinancesHelper
{
    /*
    * get list of all available medication items
    */
    public function transactionsGetAll(){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionsGetAll()');      
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

    /*
    * removes medication item from database
    */
    public function deleteAction($id){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationDeleteOne(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;

    }

    /*
    * adds medication item
    */
    public function addAction($medication){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationAdd(?,?,?,?,?)');
        $stmt->execute(array(
            $medication->med_name, 
            $medication->med_desc, 
            $medication->med_instr, 
            $medication->med_price, 
            $medication->med_on_hand
        ));

        //fetch last insert id 
        //returns array with only one number in place [0]
        $id = $stmt->fetch(\PDO::FETCH_NUM)[0];

        //set result object to return to ajax
        $result = [
            'id' => $id,
            'result' => true
        ];

        return $result;       
    }

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