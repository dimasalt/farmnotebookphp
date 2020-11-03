<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesHelper;
use FarmManagement\Libraries\CSRFToken;


class FinancesController extends BaseController
{
    public function index(){
               
        session_regenerate_id();

        echo $this->view->render('Finances\transactions\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /**
     * function to get list of transactions
     */
    public function transactionsGetAll(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);
   
        $helper = new FinancesHelper();
        $result = $helper->transactionsGetAll();

        echo json_encode($result);
    }


    /**
     * transaction types main page
     */
    public function transactionCatsIndex(){
        session_regenerate_id();              

        echo $this->view->render('Finances\types\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /**
     * get all transaction types 
     */
    public function transactionCatsGetAll(){
        $helper = new FinancesHelper();
        $result = $helper->transactionCatsGetAll();

        //mark first element as an active element
        if(count($result) > 1) 
            $result[0]["is_active"] = true;

        // mark rest of the array elements as inactive
        for($i = 1; $i< count($result); $i++)
            $result[$i]["is_active"] = false;           
        

        echo json_encode($result);   
    }

    /**
     * Gets all sub categories for selected category
     */
    public function transactionSubCatsGetAll(){
        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        $id = $data->id;    
          
        $helper = new FinancesHelper();
        $result = $helper->transactionSubCatsGetAll($id);

        echo json_encode($result);
         
    }   




    /**
     * add new transaction type
     */
    public function transactionCatsAdd(){

    }

    /**
     * add new transaction type
     */
    public function transactionCatsDelete(){

    }

    
    /**
     * update existing transaction type
     */
    public function transactionCatsUpdate(){

    }
}