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
        //security
        session_regenerate_id();

        echo $this->view->render('Bookkeeping\vehiclelogbook\index.twig',            
            [ 'csrf' => CSRFToken::getToken()]
        );
    }

     /*
    *--------------------------------------------------------
    *   vehicle log book get all records based on
    *   a selected year
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

        //convert to object
        $data = (object)$data;

        $phelper = new VehicleLogBookHelper();
        $logrecords = $phelper->bookLogsGetAll($data->odometer_id);

        echo json_encode($logrecords);
    }


    /**
     * --------------------------------------------------------
     * Adds new odometer
     * ---------------------------------------------------------
     */
    public function odometerAddOrEdit(){
        //security
        session_regenerate_id();
         
        $json = file_get_contents('php://input');
        // Converts it into a PHP object
        $data = json_decode($json);

        //convert to object
        $data = (object)$data;

        //check csrf key
        if(CSRFToken::isValid($data->csrf)){
            $phelper = new VehicleLogBookHelper();
            $result = $phelper->odometerAddOrEdit($data);

            echo json_encode($result);
        }
    }

    /**
     * ---------------------------------------------------
     * removes odometer from records and all associated vehicle book log records
     * for selected year
     * ----------------------------------------------------
     */
    public function odometerDelOne()
    {
          //security
          session_regenerate_id();
          
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $phelper = new VehicleLogBookHelper();
            $delresult = $phelper->odometerDelOne($data->id);
    
            echo json_encode($delresult);
         } 
         else echo json_encode(false);       
    }
    /**
     * -------------------------------------------------------------------------
     * add new book log item
     * -------------------------------------------------------------------------
     */
    public function booklogItemAdd(){

          //security
          session_regenerate_id();
          
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         $data = (object)$data;

         if(CSRFToken::isValid($data->csrf)){
            $phelper = new VehicleLogBookHelper();
            $delresult = $phelper->booklogItemAdd($data);
    
            echo json_encode($delresult);
         } 
         else echo json_encode(false);       
    }

 
    //       //if(! isset($data->created_at ) || strlen($data->created_at ) == 0)
    //       if(! isset($data->created_at ) || empty($data->created_at ))
    //         $data->created_at = date('Y-m-d');

    //       $created_at = $data->created_at;
}