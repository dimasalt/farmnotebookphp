<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\MedicationHelper;
use FarmWork\Libraries\CSRFToken;


class MedicationController extends BaseController
{
    public function index(){
        //        $id = uniqid('', false);
        //        $password = password_hash('northernfarm', PASSWORD_DEFAULT);
        //        var_dump($password);
        
        session_regenerate_id();       

        // $medHelper = new MedicationHelper();
        // $medlist = $medHelper->getList("");

        

        echo $this->view->render('Medication\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }


      /*
     * --------------------------------------------------------
     *  Displays item that needs to be updated
     * ---------------------------------------------------------
     */
    public function update($id){
        
        session_regenerate_id();

        // var_dump($id);
        // die();

        echo $this->view->render('Medication\update.twig', [
            'csrf' => CSRFToken::getToken(),
            'id' => $id
        ]);
    }

    /*
     * --------------------------------------------------------
     *  Gets list of all available medication
     * ---------------------------------------------------------
     */
    public function getList(){

         // Takes raw data from the request
         $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);  
         
        //get possible search term
        $search_term = $data->search_term;

        $medHelper = new MedicationHelper();
        $medlist = $medHelper->getList($search_term);       
        
        $medlist = json_encode($medlist);     
        //echo json_decode(json_encode(current($medlist)),true);        
       
        echo $medlist;
    }


     /*
     * --------------------------------------------------------
     *  Gets one medication item
     * ---------------------------------------------------------
     */
    public function getOne(){

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        $medHelper = new MedicationHelper();
        $meditem = $medHelper->getOne($data->id);
       
        $meditem = json_encode($meditem);      
        echo $meditem;
      
    }

     /*
     * --------------------------------------------------------
     *  Gets list of all available medication
     * ---------------------------------------------------------
     */
    public function addIndex(){ 
        
        session_regenerate_id();              
        
        echo $this->view->render('Medication\add.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }


    /**
    * -----------------------------------------------------------
    * Medication add item
    *------------------------------------------------------------
    */
    public function addAction(){
        
        session_regenerate_id();

         // Takes raw data from the request
         $json = file_get_contents('php://input');

         // Converts it into a PHP object
         $data = json_decode($json);
 
         //cast into object
         $data = (object)$data;

          //check if csrf token is valid
          if(CSRFToken::isValid($data->csrf)){
          
            $medHelper = new MedicationHelper();
            $result = $medHelper->addAction(
                $data->med_name, 
                $data->med_desc, 
                $data->med_instruction,
                $data->med_price,
                $data->med_on_hand
            );
    
            $result = json_encode($result);
            echo $result;
        }
        else return json_encode('false');
    }
   

    /*
     * --------------------------------------------------------
     *  updates medication item
     * ---------------------------------------------------------
     */
    public function updateAction(){
        
        session_regenerate_id();
        
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);         

        //check if csrf token is valid
        if(CSRFToken::isValid($data->csrf)){
          
            $medHelper = new MedicationHelper();
            $result = $medHelper->updateAction(
                $data->id, 
                $data->med_name, 
                $data->med_desc, 
                $data->med_instruction,
                $data->med_price,
                $data->on_hand_doses,
            );
    
            $result = json_encode($result);
            echo $result;
        }
        else {
            $result = json_encode(false);
            return $result;
        }   
    }


    /*
     * --------------------------------------------------------
     *  Removes selected medication item
     * ---------------------------------------------------------
     */
    public function deleteAction(){

        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);         

        $medHelper = new MedicationHelper();
        $result = $medHelper->deleteAction($data->id);

        $result = json_encode($result);
        echo $result;
    }

}