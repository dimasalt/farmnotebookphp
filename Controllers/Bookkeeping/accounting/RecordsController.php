<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\RecordsHelper;
use FarmWork\Libraries\CSRFToken;


class RecordsController extends BaseController
{
    public function index(){            

        echo $this->view->render('bookkeeping\records\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /**
     * -----------------------------------------------------------
     * function to get list of transactions
     * -----------------------------------------------------------
     */
    public function transactionsGetAll(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);
        
        //prepare search term variable 
        // if($data->search_term == '') 
        //     $data->search_term = '%' . $data->search_term . '%';
   
        $helper = new RecordsHelper();
        $result = $helper->transactionsGetAll($data->search_term, $data->start_date, $data->end_date);

        echo json_encode($result);
    }
    /**
     * -----------------------------------------------------------
     * adds main transaction record
     * -----------------------------------------------------------
     */
    public function transactionAdd(){
        
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);      
 
        $helper = new RecordsHelper();
        $result = $helper->transactionAdd($data);

        echo json_encode($result);
    }
    /**
     * ----------------------------------------------------------
     * update main transaction record
     * ---------------------------------------------------------
     */
    public function transactionUpdate(){
        
          // Takes raw data from the request
          $json = file_get_contents('php://input');

          // Converts it into a PHP object
          $data = json_decode($json);      
  
          $helper = new RecordsHelper();
          $result = $helper->transactionUpdate($data);
  
          echo json_encode($result);
    }

    /**
     * -----------------------------------------------------------
     * function to remove main transaction record
     * -----------------------------------------------------------
     */
    public function transactionDelete(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new RecordsHelper();
        $result = $helper->transactionDelete($data->id);

        echo json_encode($result);
    }
      /**
     * -----------------------------------------------------------
     * function to create transaction item and add it to main  transaction
     * record
     * -----------------------------------------------------------
     */
    public function transactionItemAdd(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);   
        
        //set proper is_expence value and if expence is true than add -1 to an amount
        $data->is_expence = (bool)$data->is_expence;
        if($data->is_expence == true) {
            
            $data->is_expence = 1;
            // $data->amount = (-1 * floatval($data->amount));           
            $data->amount = (-1 * (float)$data->amount);           
        }
        else $data->is_expence = 0;

        $helper = new RecordsHelper();
        $result = $helper->transactionItemAdd($data);

        echo json_encode($result);
    }

      /**
     * -----------------------------------------------------------
     * function to remove a sub item from main transaction record
     * -----------------------------------------------------------
     */
    public function transactionItemDelete(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);      

        $helper = new RecordsHelper();
        $result = $helper->transactionItemDelete($data->id);

        echo json_encode($result);
    }

    /**
     * -----------------------------------------------------------
     * function to get list of all main categories
     * -----------------------------------------------------------
     */
    public function getCategories(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //prepare search term variable 
        // if($data->search_term == '') 
        //     $data->search_term = '%' . $data->search_term . '%';
   
        $helper = new RecordsHelper();
        $result = $helper->getCategories();

       
        echo json_encode($result);
    }


    /**
     * Receipt image upload for transaction
     */
    public function transactionReceiptUpload(){

        //set upload dir
        $uploaddir = $this->config["upload_url"];

        // $test1 = $_POST["test1"];
        // echo $test1;

        // mkdir($uploaddir . (string)$test1, 0777, true);

        //current year directory
        $year = date('Y');

        //current month directory
        $month = date('m');     

        //current day directory
        $day = date('d');

        //full upload folder
        $uploadFolder = $uploaddir . 'transactions/' . (string)$year . '/' . (string)$month . '/' . (string)$day;

        if(!file_exists($uploadFolder))
            mkdir($uploadFolder, 0777, true);
      

        $allowedfileExtensions = array('jpg', 'gif', 'png', 'zip', 'txt', 'xls', 'doc');

        $uploaddir = $this->config["upload_url"];

        //file destination
        $uploadfile = $uploaddir . basename($_FILES['file']['name']);

        //temporary file location
        $fileTempPath = $_FILES['file']['tmp_name'];

        //check on the file 
        $fileName = $_FILES['file']['name'];

        //extention
        $fileNameCmps = explode(".", $fileName);
        $fileExtension = strtolower(end($fileNameCmps));

        if(in_array($fileExtension, $allowedfileExtensions)){
            if (move_uploaded_file($fileTempPath, $uploadfile)) {
                echo "File is valid, and was successfully uploaded.\n";
            } else {
                echo "Possible file upload attack!\n";
            }
        }
        
       

        // //working code
        // $uploaddir = $this->config["upload_url"];

        // $uploadfile = $uploaddir . basename($_FILES['file']['name']);
        
        // if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
        //     echo "File is valid, and was successfully uploaded.\n";
        // } else {
        //     echo "Possible file upload attack!\n";
        // }


       
    }

}