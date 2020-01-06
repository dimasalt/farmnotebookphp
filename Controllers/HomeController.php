<?php

namespace FarmManagement\Controllers;


class HomeController extends BaseController
{
    // main page
    public function index()
    {
        //$uid1 = uniqid();
        echo $this->view->render('Home/index.twig');
        //echo $this->view->render('LiveStock/index.twig');
    }
}