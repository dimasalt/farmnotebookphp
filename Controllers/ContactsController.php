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
        echo $this->view->render('/Contacts/index.twig');
    }

    /*
    * --------------------------------------------------
    * displays add page
    * --------------------------------------------------
    */
    public function add(){
        //security
        session_regenerate_id();

        //display the view
        echo $this->view->render('Contacts/add.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
        
    }

    /*
    *---------------------------------------------------------
    *   View contact information
    *----------------------------------------------------------
    */
   public function view($id){
        $contHelper = new ContactsHelper();
        $contact = $contHelper->GetOne($id);

        //display the view
        echo $this->view->render('Contacts/view.twig', [           
            'contact' => $contact
        ]);
   }


    /*
    * --------------------------------------------------
    * contact add functionality
    * --------------------------------------------------
    */
    public function addAction(){
        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $contact = json_decode($json);

        //cast into object
        $contact = (object)$contact;

        //check if token is valid and name not empty and update the contact
        if(CSRFToken::isValid($contact->csrf)){
            if(!empty($contact->contact_name)){ //check if name is not empty
                $cntHelper = new ContactsHelper();
                $result = $cntHelper->addAction($contact);

                echo json_encode($result);
            }
            else echo json_encode(false);
   
        }
        else echo json_encode(false);
    }

    /*
     * --------------------------------------------------
     * displays update page
     * --------------------------------------------------
     */
    public function update($id){
        //security
        session_regenerate_id();

        $contHelper = new ContactsHelper();
        $contact = $contHelper->GetOne($id);
      
        //display the view
        echo $this->view->render('Contacts/update.twig', [
            'csrf' => CSRFToken::getToken(),
            'contact' => $contact
        ]);
    }


    public function updateAction(){
        //security
        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $contact = json_decode($json);       

        //cast into object
        $contact = (object)$contact;

        //check if token is valid and name not empty and update the contact
        if(CSRFToken::isValid($contact->csrf)){
            if(!empty($contact->contact_name)){ //check if name is not empty
                $cntHelper = new ContactsHelper();
                $result = $cntHelper->updateAction($contact);

                echo json_encode($result);
            }
            else echo json_encode(false);
        }
        else echo json_encode(false);
    }

    /* -------------------------------------------------
     *  Gets list of all contacts
     * --------------------------------------------------
     */
    public function getList(){
        $contHelper = new ContactsHelper();
        $contlist = $contHelper->GetList();

        $contlist = json_encode($contlist);

        echo $contlist;
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