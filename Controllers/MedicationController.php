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


     /*
     * --------------------------------------------------------
     *  Gets one medication item
     * ---------------------------------------------------------
     */
    public function getOne($id){

        $medHelper = new MedicationHelper();
        $meditem = $medHelper->getOne($id);

        //$meditem = json_encode($meditem);      

        echo $this->view->render('Medication\view.twig', [
                                    'medication' => $meditem
                                ]);
    }

     /*
     * --------------------------------------------------------
     *  Gets list of all available medication
     * ---------------------------------------------------------
     */

    public function addIndex(){               
        echo $this->view->render('Medication\add.twig');
    }


     /*
     * --------------------------------------------------------
     *  Displays item that needs to be updated
     * ---------------------------------------------------------
     */
    public function update($id){
        echo $this->view->render('Medication\update.twig');
    }

   


}