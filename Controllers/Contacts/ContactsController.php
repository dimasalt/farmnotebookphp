<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\ContactsHelper;
use FarmWork\Libraries\CSRFToken;


class ContactsController extends BaseController
{
    /* -----------------------------------------------------
     * main page
     * -----------------------------------------------------
     */
    public function index(){

        //security
        session_regenerate_id();

        echo $this->view->render('/Contacts/index.twig',[
            'csrf' => CSRFToken::getToken()
        ]);
    }

    /* -------------------------------------------------
     *  Gets list of all contacts
     * --------------------------------------------------
     */
    public function contactsGetAll(){

        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);       


       $contHelper = new ContactsHelper();
       $result = $contHelper->contactsGetAll($data);

       $result = json_encode($result);

       echo $result;
   }
    /*
    * --------------------------------------------------
    * contact add functionality
    * --------------------------------------------------
    */
    public function contactAdd(){
        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //cast into object
        //$data = (object)$contact;

        //check if token is valid and name not empty and update the contact
        if(CSRFToken::isValid($data->csrf)){
            if(!empty($data->name)){ //check if name is not empty
                $cntHelper = new ContactsHelper();
                $result = $cntHelper->contactAdd($data);

                echo json_encode($result);
            }
            else echo json_encode(false);
   
        }
        else echo json_encode(false);
    }


    public function contactUpdate(){
        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);       

        //cast into object
        //$contact = (object)$contact;

        //check if token is valid and name not empty and update the contact
        if(CSRFToken::isValid($data->csrf)){
            if(!empty($data->name)){ //check if name is not empty
                
                $cntHelper = new ContactsHelper();
                $result = $cntHelper->contactUpdate($data);

                echo json_encode($result);
            }
            else echo json_encode(false);
        }
        else echo json_encode(false);
    }

    /*
     * ------------------------------------------------------
     * Deletes Selected contact
     * ------------------------------------------------------
     */
    public function deleteContact(){
        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        $contHelper = new ContactsHelper();
        $result = $contHelper->deleteContact($data->id);

        $result = json_encode($result);

        echo $result;
    }

    /**
     * -------------------------------------------------------------------
     * Get Vendor List
     * -------------------------------------------------------------------
     */
    public function getVendorList(){

        $contHelper = new ContactsHelper();
        $contlist = $contHelper->getVendorList();

        $contlist = json_encode($contlist);

        echo $contlist;
    }
}