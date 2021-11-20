<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\BudgetHelper;
use FarmWork\Helpers\FinancesbudgetHelper;
use FarmWork\Libraries\CSRFToken;

class BudgetController extends BaseController {
    
    /*
    *--------------------------------------------------------
    *       Budget main page
    *---------------------------------------------------------
    */
    public function index(){       
        echo $this->view->render('Accounting\budget\index.twig',            
            [ 'csrf' => CSRFToken::getToken()]
        );
    }


      /*
    *--------------------------------------------------------
    *       Budget get list of all records
    *---------------------------------------------------------
    */
    public function budgetGetAll()
    {
        $bhelper = new BudgetHelper();
        $result = $bhelper->budgetGetAll();

        echo json_encode($result);
    }

    /*
    *--------------------------------------------------------
    *       adds one item to the planned project list
    *---------------------------------------------------------
    */
    public function budgetCreateItem()
    {
        //security
        session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $budget_name = $data->budget_name;
            $budget_amount = $data->budget_amount;
            $budget_amount_actual = $data->budget_amount_actual;
            $is_done = $data->is_done;
            $is_default = $data->is_default;

          //check if date is empty or null. If yes assign current date value
          //if(! isset($data->created_at ) || strlen($data->created_at ) == 0)
          if(! isset($data->budget_date ) || empty($data->budget_date ))
            $data->budget_date = date('Y-m-d');

          $budget_date = $data->budget_date;
    
          $helper = new BudgetHelper();
          $result = $helper->budgetCreateItem($budget_name, $budget_amount, $budget_amount_actual, $is_done, $is_default, $budget_date);
   
          echo json_encode($result);
        } 
        else echo json_encode(false);               
    }

     /*
    *--------------------------------------------------------
    *       removes one item from the planned budget list
    *---------------------------------------------------------
    */
    public function budgetDelete()
    {
          //security
          session_regenerate_id();
          
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $helper = new BudgetHelper();
            $result = $helper->budgetDelete($data->id);
    
            echo json_encode($result);
         } 
         else echo json_encode(false);       
    }


    /*
    *--------------------------------------------------------
    *       edit one item from the planned budget list
    *---------------------------------------------------------
    */
    public function budgetUpdate()
    {
          //security
          session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){
            $id = $data->id;
            $budget_name = $data->budget_name;
            $budget_amount = $data->budget_amount;
            $budget_amount_actual = $data->budget_amount_actual;        
            $budget_date = $data->budget_date;
    
           $helper = new BudgetHelper();
           $result = $helper->budgetUpdate($id, $budget_name, $budget_amount, $budget_amount_actual, $budget_date);
   
           echo json_encode($result);
         } 
         else echo json_encode(false);       
    }


    /*
    *--------------------------------------------------------
    *       update status of one item from the budget list
    *---------------------------------------------------------
    */
    public function budgetUpdateStatus()
    {
          //security
          session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);

         if(CSRFToken::isValid($data->csrf)){

          $id = $data->id;      
          $is_done = $data->is_done;
    
          $helper = new BudgetHelper();
          $result = $helper->budgetUpdateStatus($id, $is_done);
            
          echo json_encode($result);
        } 
        else echo json_encode(false);       

       
    }


}