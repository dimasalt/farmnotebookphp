<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\MedicationHelper;
use FarmManagement\Libraries\CSRFToken;


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

        //check if token is valid and name not empty and update the contact
        if(CSRFToken::isValid($data->csrf)){
            
            $medHelper = new MedicationHelper();
            $result = $medHelper->addAction($data);

            echo json_encode($result);
        }
        else echo json_encode("false");
    }
   

    /*
     * --------------------------------------------------------
     *  updates medication item
     * ---------------------------------------------------------
     */
    public function updateAction(){
        
        session_regenerate_id();

        echo $this->view->render('Medication\update.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
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