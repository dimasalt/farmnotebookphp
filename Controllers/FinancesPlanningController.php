<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesPlanningHelper;
use FarmManagement\Libraries\CSRFToken;

class FinancesPlanningController extends BaseController {

    /*
    *--------------------------------------------------------
    *       Project planning page
    *---------------------------------------------------------
    */
    public function projects(){       
        echo $this->view->render('Finances\planning\projects.twig',            
            [ 'csrf' => CSRFToken::getToken()]
        );
    }

    /*
    *--------------------------------------------------------
    *       Project planning get list of all
    *---------------------------------------------------------
    */
    public function getList()
    {
        $phelper = new FinancesPlanningHelper();
        $projects = $phelper->getList();

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
            $phelper = new FinancesPlanningHelper();
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
    public function addNew()
    {
        //security
        session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $project_name = $data->project_name;
            $project_price = $data->project_price;
            $project_price_actual = $data->project_price_actual;
            $is_start = $data->is_start;

          //check if date is empty or null. If yes assign current date value
          //if(! isset($data->created_at ) || strlen($data->created_at ) == 0)
          if(! isset($data->created_at ) || empty($data->created_at ))
            $data->created_at = date('Y-m-d');

          $created_at = $data->created_at;
    
          $phelper = new FinancesPlanningHelper();
          $result = $phelper->addNew($project_name, $project_price, $project_price_actual, $is_start, $created_at);
   
          echo json_encode($result);
        } 
        else echo json_encode(false);               
    }


      /*
    *--------------------------------------------------------
    *       edit one item from the planned project list
    *---------------------------------------------------------
    */
    public function updateOne()
    {
          //security
          session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $project_id = $data->id;
            $project_name = $data->project_name;
            $project_price = $data->project_price;
            $project_price_actual = $data->project_price_actual;        
            $created_at = $data->created_at;
    
           $phelper = new FinancesPlanningHelper();
           $result = $phelper->updateOne($project_id, $project_name, $project_price, $project_price_actual, $created_at);
   
           echo json_encode($result);
         } 
         else echo json_encode(false);       

      
    }

      /*
    *--------------------------------------------------------
    *       update status of one item from the planned project list
    *---------------------------------------------------------
    */
    public function projectUpdateStatus()
    {
          //security
          session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){

            $project_id = $data->id;
            $is_done = $data->is_done;
           
    
           $phelper = new FinancesPlanningHelper();
           $result = $phelper->projectUpdateStatus($project_id, $is_done);
            
           echo json_encode($result);
        } 
        else echo json_encode(false);       

       
    }

}