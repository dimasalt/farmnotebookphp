<?php


namespace FarmManagement\Controllers;

use FarmManagement\Helpers\MedicationHelper;


class MedicationController extends BaseController
{
    public function index(){
//        $id = uniqid('', false);
//        $password = password_hash('northernfarm', PASSWORD_DEFAULT);
//        var_dump($password);
        echo $this->view->render('Medication\index.twig');
    }

    /*
     * --------------------------------------------------------
     *  Gets list of all available medication
     * ---------------------------------------------------------
     */
    public function getList(){

        $medHelper = new MedicationHelper();
        $medlist = $medHelper->getList();

        $medlist = json_encode($medlist);

        echo $medlist;
    }

}