<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class RecordsHelper
{
    /**
    -----------------------------------------------------------
    * get list of all available transactions items based on search
    * term, dates and other selected parameters
    -----------------------------------------------------------
    */
    public function transactionsGetAll($search_term, $start_date, $end_date){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionsGetAll(?,?,?,?,?)');      
        $stmt->execute([$search_term, 1, 1, $start_date, $end_date]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        //get items for transaction record
        for($i = 0; $i < count($result); $i++){
            $items = $this->transactionltemsGet($result[$i]['id']);

            $result[$i]['items'] = $items;

            //convert date to more readable format
            $result[$i]["trans_read_date"] = date("M d, Y", strtotime($result[$i]["trans_date"])); 
        }

        // for($i = 0; $i< count($result); $i++){
        //     if(strlen($result[$i]["desc"]) > 100 )
        //         $result[$i]['desc'] = substr($result[$i]['desc'], 0, 110) . '...';
        // }

       return $result;
    }
    /**
     * ------------------------------------------------------------------
     * Adds main transaction record
     * -------------------------------------------------------------------
     */
    public function transactionAdd($data): bool 
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionCreate(?,?,?,?,?)');
        $stmt->execute(array(
            $data->vendor_name,
            $data->vendor_address,
            $data->trans_desc,
            $data->trans_currency,
            $data->trans_date
        ));

        if($stmt->rowCount() > 0) return true;
        else return false;        
    }

     /**
     * ------------------------------------------------------------------
     * updates main transaction record
     * -------------------------------------------------------------------
     */
    public function transactionUpdate($data): bool 
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionUpdate(?,?,?,?,?,?,?)');
        $stmt->execute(array(
            $data->id,
            $data->trans_name,
            $data->trans_desc,
            $data->trans_address_name,
            $data->trans_address,
            $data->trans_currency,
            $data->trans_date
        ));

        if($stmt->rowCount() > 0) return true;
        else return false;        
    }

    
    /*
     * ---------------------------------------------------------
     * Delete main transaction from database
     * ---------------------------------------------------------
     */
    public function transactionDelete($id) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionDelete(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;        
    }

    /**
     * ---------------------------------------------------------
     *                      Transaction types
     * ---------------------------------------------------------
     */

    /**
     * ---------------------------------------------------------
     * get all transaction types 
     * ---------------------------------------------------------
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
     * -----------------------------------------------------------
     * Gets all sub categories for selected category
     * -----------------------------------------------------------
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
     * *********************************************************************************
     * Transaction Item operations
     * *********************************************************************************
     */
    public function transactionItemAdd($item) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionItemCreate(?,?,?,?,?,?,?,?,?)');
        $stmt->execute(array(            
            $item->transaction_id,
            $item->item_name,
            $item->item_desc,
            $item->item_category,
            $item->item_subcategory,
            $item->amount,
            $item->hst_tax,
            $item->gst_tax,
            $item->pst_tax
        ));    

        if($stmt->rowCount() > 0) return true;
        else return false; 
    }
    
    /**
     * ----------------------------------------------------------------------------------
     * Gets all transaction items for specific transaction record
     * -----------------------------------------------------------------------------------
     */
    public function transactionltemsGet($transaction_id): array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionItemsGet(?)');
        $stmt->execute(array($transaction_id));       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }
      /*
     * ---------------------------------------------------------
     * Delete transaction a sub item from main transaction record
     * ---------------------------------------------------------
     */
    public function transactionItemDelete($id) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionItemDelete(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;        
    }

    /**
     * -------------------------------------------------------------------------
     * add new transaction type
     * --------------------------------------------------------------------------
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