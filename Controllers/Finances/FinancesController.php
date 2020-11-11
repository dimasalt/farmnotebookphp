<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesHelper;
use FarmManagement\Libraries\CSRFToken;


class FinancesController extends BaseController
{
    public function index(){            

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
    
}