<?php

namespace FarmManagement\Controllers;


use FarmManagement\Libraries\CSRFToken;


class FinancesController extends BaseController
{
    public function index(){
       
        
        session_regenerate_id();

        echo $this->view->render('Finances\main\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }

}