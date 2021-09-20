<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class RecordsHelper
{
    /**
    * -----------------------------------------------------------
    * get list of all available transactions items based on search
    * term, dates and other selected parameters
    * -----------------------------------------------------------
    */
    public function transactionsGetAll($search_term, $start_date, $end_date, $category_selected, $sub_category_selected){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionsGetAll(?,?,?,?,?,?,?)');      
        $stmt->execute([
            $search_term, 
            $category_selected,
            $sub_category_selected,
            1, 
            25, 
            $start_date, 
            $end_date
        ]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        //get items for transaction record and remove ones that do not fit search parameters
        $count = count($result);
        for ($i = 0; $i < $count; $i++){
            
            //get items for transaction/vendor record
            $result[$i]['items'] = $this->transactionltemsGet($result[$i]['id'], $category_selected, $sub_category_selected);

            //create more readable date format
            $result[$i]["trans_read_date"] = date("M d, Y", strtotime($result[$i]["trans_date"]));    
        }

        //FOREACH 
        // foreach($result as $key=>$value){
        //     $items =  $this->transactionltemsGet($result[$key]['id'], $category_selected, $sub_category_selected);

        //     if(count($items) == 0)
        //         unset($result[$key]);
        //     else {
        //         $result[$key]['items'] = $items;

        //         //set more readable date
        //         $result[$key]["trans_read_date"] = date("M d, Y", strtotime($result[$key]["trans_date"]));    
        //     }
        // }
        
        return $result;
    }
    /**
     * ----------------------------------------------------------------------------------
     * Gets all transaction items for specific transaction record
     * -----------------------------------------------------------------------------------
     */
    public function transactionltemsGet($transaction_id, $category_selected, $sub_category_selected): array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionItemsGet(?,?,?)');
        $stmt->execute([
            $transaction_id,
            $category_selected,
            $sub_category_selected
        ]);       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

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
     * -------------------------------------------------------------------
     * Updates image receipt for transaction record
     * -------------------------------------------------------------------
     */
    public function transactionAddImage($id, $trans_image) : bool 
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call transactionUpdateImage(?,?)');
        $stmt->execute(array(
            $id,
            $trans_image
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
        $stmt = $pdo->prepare('call transactionUpdate(?,?,?,?,?,?)');
        $stmt->execute(array(
            $data->id,
            $data->trans_desc,
            $data->vendor_name,
            $data->vendor_address,
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
        $stmt = $pdo->prepare('call transactionItemCreate(?,?,?,?,?,?,?,?,?,?)');
        $stmt->execute(array(            
            $item->transaction_id,
            $item->item_name,
            $item->item_desc,
            $item->item_category,
            $item->item_subcategory,
            $item->amount,
            $item->hst_tax,
            $item->gst_tax,
            $item->pst_tax,
            $item->is_expence
        ));    

        if($stmt->rowCount() > 0) return true;
        else return false; 
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