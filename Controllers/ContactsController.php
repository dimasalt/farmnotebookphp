<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\ContactsHelper;

class ContactsController extends BaseController
{
    /* -----------------------------------------------------
     * main page
     * -----------------------------------------------------
     */
    public function index(){

        echo $this->view->render('Contacts/index.twig');
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


}