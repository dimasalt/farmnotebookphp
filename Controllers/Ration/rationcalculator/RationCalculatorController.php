<?php

namespace FarmWork\Controllers;

use \MongoDB\Client as MongoDB;


class RationCalculatorController extends BaseController
{
    // main page
    public function index()
    {
       session_regenerate_id();

       echo $this->view->render('Ration\rationcalculator\index.twig');    
    }
}