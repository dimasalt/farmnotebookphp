<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\LiveStockTypesHelper;
use FarmWork\Libraries\CSRFToken;

class LivestockTypesController extends BaseController {

    public function index()
    {                    
        echo $this->view->render('Inventory/types/index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

     /**
     * -----------------------------------------------------
     * Function to get list of livestock types
     * -----------------------------------------------------
     */
    public function getLivestockTypes(){                  

            $livestockHelper = new LiveStockTypesHelper ();
            $livestocktypes = $livestockHelper->getLivestockTypes();
                   
            echo json_encode($livestocktypes); 
    }

     /**
     * Gets all sub categories for selected category
     */
    // public function livestockSubCatsGetAllServerSide($id){
          
    //     $helper = new LiveStockTypesHelper();
    //     $result = $helper->($id);    
        
    //     return $result;     
    // }   


    /**
     * save/add/update transaction category or sub category
     */
    public function livestockCatSave() 
    {   
        //security     
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $csrf = $data->csrf;

        if(CSRFToken::isValid($csrf)) {
               
            //call helper
            $helper = new LiveStockTypesHelper();
            $result = $helper->livestockCatSave($data->category_item);

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
    public function livestockCatsDelete(){

        //security
        session_regenerate_id();
        
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      
  
        $csrf = $data->csrf;
  
        if(CSRFToken::isValid($csrf)) {
                 
              //call helper
              $helper = new LiveStockTypesHelper();
              $result = $helper->livestockCatsDelete($data->category_id);
  
              echo json_encode($result);
        }
        else echo json_encode([
                'message' => "Invalid CSRF token", 
                'result' => false
            ]);
    }

}