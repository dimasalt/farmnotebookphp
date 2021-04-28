<?php

namespace FarmWork\Controllers;

use FarmWork\Libraries\CSRFToken;


class LoginController extends BaseController
{
    /*
     * ---------------------------------------------------
     *  Displays the login page and passes CSRF token for the
     *  login form
     * ----------------------------------------------------
     */
    public function index() : void
    {
        $csrf_token = CSRFToken::getToken();
        echo $this->view->render('Login/index.twig', ['csrf_token' => $csrf_token]);
    }


    /*
     * ---------------------------------------
     *  Performs an actual user login
     * ---------------------------------------
     */
    public function login(): void
    {

    }
}