<?php

namespace FarmManagement\Controllers;

use FarmManagement\Helpers\FinancesHelper;
use FarmManagement\Libraries\CSRFToken;


class FinancesController extends BaseController
{
    public function index(){
               
        session_regenerate_id();

        echo $this->view->render('Finances\transactions\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

}