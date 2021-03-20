<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesTypeHelper;
use FarmManagement\Libraries\CSRFToken;


class RecordsTypeController extends BaseController
{
    /**
     * transaction types main page
     */
    public function index() {         

        echo $this->view->render('Bookkeeping\types\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /**
     * get all transaction types 
     */
    public function transactionCatsGetAll(){
        $helper = new FinancesTypeHelper();
        $result = $helper->transactionCatsGetAll();

        for($i = 0; $i< count($result); $i++){         
            //get all sub categories for the main category
            $result[$i]["sub_category"] = $this->transactionSubCatsGetAllServerSide($result[$i]["id"]);

        }                  

        echo json_encode($result);   
    }

     /**
     * Gets all sub categories for selected category
     */
    public function transactionSubCatsGetAllServerSide($id){
          
        $helper = new FinancesTypeHelper();
        $result = $helper->transactionSubCatsGetAll($id);    
        
        return $result;     
    }   


    /**
     * save/add/update transaction category or sub category
     */
    public function transactionCatSave() 
    {        
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $csrf = $data->csrf;

        if(CSRFToken::isValid($csrf)) {
               
            //call helper
            $helper = new FinancesTypeHelper();
            $result = $helper->transactionCatSave($data->category_item);

            echo json_encode($result);
        }
        else echo json_encode([
                'message' => "Invalid CSRF token", 
                'result' => false
            ]);
    }

    /**
     * add new transaction type
     */
    public function transactionCatsDelete(){
        
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      
  
        $csrf = $data->csrf;
  
        if(CSRFToken::isValid($csrf)) {
                 
              //call helper
              $helper = new FinancesTypeHelper();
              $result = $helper->transactionCatsDelete($data->category_id);
  
              echo json_encode($result);
        }
        else echo json_encode([
                'message' => "Invalid CSRF token", 
                'result' => false
            ]);
    }

    
}