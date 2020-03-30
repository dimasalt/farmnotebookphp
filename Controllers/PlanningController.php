<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\PlanningHelper;
use FarmManagement\Libraries\CSRFToken;

class PlanningController extends BaseController {

    /*
    *--------------------------------------------------------
    *       Project planning page
    *---------------------------------------------------------
    */
    public function projects(){       
        echo $this->view->render('Planning\projects.twig',            
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
        $phelper = new PlanningHelper();
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
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $phelper = new PlanningHelper();
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
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $project_name = $data->project_name;
            $project_price = $data->project_price;
            $project_price_actual = $data->project_price_actual;
            $is_start = $data->is_start;
            $created_at = $data->created_at;
    
           $phelper = new PlanningHelper();
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
    
           $phelper = new PlanningHelper();
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
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){

            $project_id = $data->id;
            $is_done = $data->is_done;
           
    
           $phelper = new PlanningHelper();
           $result = $phelper->projectUpdateStatus($project_id, $is_done);
            
           echo json_encode($result);
        } 
        else echo json_encode(false);       

       
    }

}