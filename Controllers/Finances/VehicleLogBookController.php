<?php

namespace FarmManagement\Controllers;

use DateTime;
use FarmManagement\Helpers\VehicleLogBookHelper;
use FarmManagement\Libraries\CSRFToken;

class VehicleLogBookController extends BaseController {

    /*
    *--------------------------------------------------------
    *       Project planning page
    *---------------------------------------------------------
    */
    public function index(){       
        echo $this->view->render('Bookkeeping\vehiclelogbook\index.twig',            
            [ 'csrf' => CSRFToken::getToken()]
        );
    }

     /*
    *--------------------------------------------------------
    *      vehicle log book get all records
    *---------------------------------------------------------
    */
    public function getOdometer()
    {
        $json = file_get_contents('php://input');
         
        // Converts it into a PHP object
        $data = json_decode($json);

        //getting current year
        // $date = DateTime::createFromFormat("Y-m-d", $data->start_year);
        // $date = (string)$date;

        $date = date('Y', strtotime($data->booklog_date));

        $date = (string)$date;

        $phelper = new VehicleLogBookHelper();
        $odometer = $phelper->getOdometer($date);

        echo json_encode($odometer);
    }


    /*
    *--------------------------------------------------------
    *      vehicle log book get all records
    *---------------------------------------------------------
    */
    public function bookLogsGetAll()
    {
        $json = file_get_contents('php://input');
         
        // Converts it into a PHP object
        $data = json_decode($json);

        $phelper = new VehicleLogBookHelper();
        $projects = $phelper->bookLogsGetAll($data->year_id);

        echo json_encode($projects);
    }

    /*
    *--------------------------------------------------------
    *       removes one item from the planned project list
    *---------------------------------------------------------
    */
    public function delOne()
    {
          //security
          session_regenerate_id();
          
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $phelper = new VehicleLogBookHelper();
            $delresult = $phelper->delOne($data->id);
    
            echo json_encode($delresult);
         } 
         else echo json_encode(false);       
    }

     /*
    *--------------------------------------------------------
    *       adds one item to the planned project list
    *---------------------------------------------------------
    */
    // public function addNew()
    // {
    //     //security
    //     session_regenerate_id();

    //      // Takes raw data from the request
    //      $json = file_get_contents('php://input');

    //      // Converts it into a PHP object
    //      $data = json_decode($json);

    //      if(CSRFToken::isValid($data->csrf)){
    //         $project_name = $data->project_name;
    //         $project_price = $data->project_price;
    //         $project_price_actual = $data->project_price_actual;
    //         $is_start = $data->is_start;

    //       //check if date is empty or null. If yes assign current date value
    //       //if(! isset($data->created_at ) || strlen($data->created_at ) == 0)
    //       if(! isset($data->created_at ) || empty($data->created_at ))
    //         $data->created_at = date('Y-m-d');

    //       $created_at = $data->created_at;
    
    //       $phelper = new VehicleLogBookHelper();
    //       $result = $phelper->addNew($project_name, $project_price, $project_price_actual, $is_start, $created_at);
   
    //       echo json_encode($result);
    //     } 
    //     else echo json_encode(false);               
    // }

}