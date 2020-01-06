<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\LiveStockHelper;

class LivestockController extends BaseController
{
    public function index($request, $response, $args)
    {
        return $this->getView()->render('LiveStock/index.twig');
    }


    /*
     * ---------------------------------------------------
     * Get livestock inventory
     * ---------------------------------------------------
     */
    public function getLiveStockInventory($request, $response, $args) {

        $request_args = json_decode( file_get_contents('php://input') );
        $current_page = $request_args->current_page;
        $records =  $request_args->records;

        $livestockHelper = new LiveStockHelper();
        $livestockInventory = $livestockHelper->GetLiveStock($current_page, $records);

        return $response->withJson($livestockInventory, 200);
    }

    /**
     * ---------------------------------------------------------------------------------
     * Get livestock types presented on the farm
     * ---------------------------------------------------------------------------------
     */
    public function getLiveStockTypes($request, $response, $args){
        $livestockHelper = new LiveStockHelper();
        $livestockTypes = $livestockHelper->getLiveStockTypes();

        return $response->withJson($livestockTypes, 200);
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