<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\RecordsHelper;
use FarmWork\Libraries\CSRFToken;


class RecordsController extends BaseController
{
    public function index(){            

        echo $this->view->render('bookkeeping\records\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /**
     * -----------------------------------------------------------
     * function to get list of transactions
     * -----------------------------------------------------------
     */
    public function transactionsGetAll(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //prepare search term variable 
        // if($data->search_term == '') 
        //     $data->search_term = '%' . $data->search_term . '%';
   
        $helper = new RecordsHelper();
        $result = $helper->transactionsGetAll($data->search_term);

        echo json_encode($result);
    }
    /**
     * -----------------------------------------------------------
     * adds main transaction record
     * -----------------------------------------------------------
     */
    public function transactionAdd(){
        
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);      
 
        $helper = new RecordsHelper();
        $result = $helper->transactionAdd($data);

        echo json_encode($result);
    }
    /**
     * ----------------------------------------------------------
     * update main transaction record
     * ---------------------------------------------------------
     */
    public function transactionUpdate(){
        
          // Takes raw data from the request
          $json = file_get_contents('php://input');

          // Converts it into a PHP object
          $data = json_decode($json);      
  
          $helper = new RecordsHelper();
          $result = $helper->transactionUpdate($data);
  
          echo json_encode($result);
    }

    /**
     * -----------------------------------------------------------
     * function to remove main transaction record
     * -----------------------------------------------------------
     */
    public function transactionDelete(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new RecordsHelper();
        $result = $helper->transactionDelete($data->id);

        echo json_encode($result);
    }
      /**
     * -----------------------------------------------------------
     * function to create transaction item and add it to main  transaction
     * record
     * -----------------------------------------------------------
     */
    public function transactionItemAdd(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new RecordsHelper();
        $result = $helper->transactionItemAdd($data);

        echo json_encode($result);
    }

      /**
     * -----------------------------------------------------------
     * function to remove a sub item from main transaction record
     * -----------------------------------------------------------
     */
    public function transactionItemDelete(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new RecordsHelper();
        $result = $helper->transactionItemDelete($data->id);

        echo json_encode($result);
    }

    /**
     * -----------------------------------------------------------
     * function to get list of all main categories
     * -----------------------------------------------------------
     */
    public function getCategories(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //prepare search term variable 
        // if($data->search_term == '') 
        //     $data->search_term = '%' . $data->search_term . '%';
   
        $helper = new RecordsHelper();
        $result = $helper->getCategories();

       
        echo json_encode($result);
    }


}