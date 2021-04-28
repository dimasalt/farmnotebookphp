<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesHelper;
use FarmManagement\Libraries\CSRFToken;


class BookkeepingController extends BaseController
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
   
        $helper = new FinancesHelper();
        $result = $helper->transactionsGetAll($data->search_term);

        echo json_encode($result);
    }

    /**
     * -----------------------------------------------------------
     * function to remove main transaction item
     * -----------------------------------------------------------
     */
    public function transactionDel(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new FinancesHelper();
        $result = $helper->transactionDel($data->id);

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
   
        $helper = new FinancesHelper();
        $result = $helper->getCategories();

       
        echo json_encode($result);
    }
    
}