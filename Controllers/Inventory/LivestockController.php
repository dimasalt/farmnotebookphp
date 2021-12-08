<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\LiveStockHelper;
use FarmWork\Libraries\CSRFToken;

class LivestockController extends BaseController
{
    public function index()
    {               
        echo $this->view->render('Inventory/livestock/index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }


    /*
     * ---------------------------------------------------
     * Get livestock inventory
     * ---------------------------------------------------
     */
    public function getLiveStockInventory() {

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

        $current_page = $data->current_page;
        $records =  $data->records;        

        $livestockHelper = new LiveStockHelper();
        $livestockInventory = $livestockHelper->GetLiveStock($current_page, $records, 0);
       
        echo json_encode($livestockInventory);
    }

    // /**
    //  * ---------------------------------------------------------------------------------
    //  * Get livestock types presented on the farm
    //  * ---------------------------------------------------------------------------------
    //  */
    public function getLiveStockTypes(){
        
        $livestockHelper = new LiveStockHelper();
        $livestockTypes = $livestockHelper->getLiveStockTypes();

        echo json_encode($livestockTypes);
    }



//    public function index($request, $response, $args) {
//
//        $progHelper = new ProgramHelper();
//        $programs = $progHelper->getAllPrograms();
//        $promotion = $progHelper->getPromotion();
//
//
//        //get programs to which user has access
//        $userPrograms = $progHelper->getUserPrograms();
//
//        //mark user membership programs
//        if($userPrograms != false) {
//            foreach ($programs as &$program) //accessing by reference
//            {
//                $program_id = $program['program_id'];
//
//                foreach ($userPrograms as $member_item){
//                    if($member_item['program_id'] == $program_id)
//                    {
//                        $program['is_member'] = 1;
//                        break;
//                    }
//                }
//            }
//        }
//
//        //if user if not found or not logged in or whatever left
//        //mark it as non member programs
//        foreach ($programs as &$i) { //accessing by reference
//            if(!isset($i['is_member']))
//                $i['is_member'] = 0;
//        }
//        unset($i);
//
//
//        //$uid1 = uniqid();
//        //return $response->withRedirect('/login');
//        //to access items in the container... $this->ci->get('');
//        //$response->getBody()->write("Hello2");
//
//        return $this->getView()->render('Home/index.twig', array(
//            'programs' => $programs,
//            'promotion' => $promotion
//        ));
//    }
}