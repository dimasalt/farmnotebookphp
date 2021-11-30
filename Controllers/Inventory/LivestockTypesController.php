<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\LiveStockTypesHelper;
use FarmWork\Libraries\CSRFToken;

class LivestockTypesController extends BaseController {

    public function index()
    {               
        echo $this->view->render('Inventory/livestock/types.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

     /**
     * -----------------------------------------------------
     * Function to get list of livestock types
     * -----------------------------------------------------
     */
    public function getLiveStockTypes(){
        
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         //get security token
         $token = $data->csrf;       

        if(CSRFToken::isValid($token)){           

            $livestockHelper = new LiveStockTypesHelper ();
            $livestocktypes = $livestockHelper->getLiveStockTypes();
        
            echo json_encode($livestocktypes);
        }
    }


}