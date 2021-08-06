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
        $result = $helper->transactionsGetAll($data->search_term, $data->start_date, $data->end_date, $data->category_selected, $data->sub_category_selected);

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
     * ------------------------------------------------------
     * Receipt image upload for transaction
     * ------------------------------------------------------
     */
    public function transactionReceiptUpload(){

        //security
        session_regenerate_id();

        //get csrf tocket and check if it's valid/ if not throw an error
        $csrf = (string)$_POST["csrf"];
        if(!CSRFToken::isValid($csrf)){
            http_response_code(403);
            echo "Upload did not pass security";
            die();
        }

        //get file and check if extention is allowed
        $allowedfileExtensions = array('jpg', 'gif', 'png', 'jpeg');
        $fileName = $_FILES['file']['name'];
        
        $fileNameCmps = explode(".", $fileName);
        $fileExtension = strtolower(end($fileNameCmps));
        if(!in_array($fileExtension, $allowedfileExtensions)){
            http_response_code(403);
            echo "File extention is not supported";
            die();
        }


        // //set upload dir
        $uploaddir = $this->config["upload_url"];
               
        //getting transaction date and creating folders accordingly
        $time = strtotime($_POST["transaction_date"]);
        $uploadFolder =  $uploaddir . 'transactions/' . (string)date('Y', $time) . '/' . (string)date('m', $time) . '/' . (string)date('d', $time);
        
        //if folder doesn't exist let's create one
        if(!file_exists($uploadFolder))
            mkdir($uploadFolder, 0777, true);    

        //check if an old file already exist, if yes remove
         //new file location //replce spaces in vendor name //preg_replace('/\s+/', '_', $_POST["vendor_name"])
         $vendor_name = str_replace(' ', '_', $_POST["vendor_name"]);
         $vendor_name = strtolower($vendor_name);
         $newFileName = $uploadFolder . '/'. $vendor_name . '-' . $_POST["transaction_id"] . '.' . $fileExtension;

         //call function to remove the file
         $this->deleteFile($newFileName);
        

        //temporary file location
        $fileTempPath = $_FILES['file']['tmp_name'];

        //move newly uploaded file to its permament location
        if(move_uploaded_file($fileTempPath, $newFileName)){           

            //update image in database
            $rcHelper = new RecordsHelper();
            $imageResult = $rcHelper->transactionAddImage($_POST["transaction_id"], $newFileName);

            if($imageResult == true){

                $result = [
                    'message' => 'File is valid and has been successfully uploaded',
                    'filePath' => $newFileName
                ];

                http_response_code(200);
                echo json_encode($result); //"File is valid and has been successfully uploaded";
            }
        }
        else {
            http_response_code(403);
            echo "Possible file upload attack!\n";
        }

        //shell_exec("rm -rf " . $dir);
        


        //remove all files and directorise in cpecific path / recursive function
        // function rrmdir($dir) { 
        //     if (is_dir($dir)) { 
        //       $objects = scandir($dir);
        //       foreach ($objects as $object) { 
        //         if ($object != "." && $object != "..") { 
        //           if (is_dir($dir. DIRECTORY_SEPARATOR .$object) && !is_link($dir."/".$object))
        //             rrmdir($dir. DIRECTORY_SEPARATOR .$object);
        //           else
        //             unlink($dir. DIRECTORY_SEPARATOR .$object); 
        //         } 
        //       }
        //       rmdir($dir); 
        //     } 
        //   }

       
    }

    /**
     * ----------------------------------------------------------------------------
     * Remove image from server and database
     * ---------------------------------------------------------------------------
     */
    public function transactionReceiptRemove(){

        //security
        session_regenerate_id(); 
        
        //translate paremeters from json
         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);      


        //get csrf tocket and check if it's valid/ if not throw an error
        if(!CSRFToken::isValid($data->csrf)){
            http_response_code(403);
            echo "File removal did not pass security";
            die();
        }        

        //call for physical file removal
        $result = $this->deleteFile($data->trans_image);

        //if removed, then remove from database
        if($result == true){

            $rcHelper = new RecordsHelper();
            $imageResult = $rcHelper->transactionAddImage($data->id, null);

            echo json_encode($imageResult);
        }
        else echo json_encode($result);
    }

    /**
     * --------------------------------------------------------------------
     * Physically remove file from the system
     * --------------------------------------------------------------------
     */
    public function deleteFile($filePath) : bool
    {     
        //if file exist please remove
        if(file_exists($filePath)) {
            
            unlink($filePath);
            return true;
        }
        else return false;
    }

}