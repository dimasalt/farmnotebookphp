<?php

// php -S localhost:8000
namespace FarmWork\Controllers;

use FarmWork\Libraries\Authentication;
use FarmWork\Middleware\RouteAccess;
use FarmWork\Models\UserModel;
use Twig\Environment;

class BaseController
{
    protected ?Environment $view = null;
    protected ?UserModel $user = null;
    protected array $config = [];

    public function __construct() {
        //security check
//        $actual_link = "$_SERVER[REQUEST_URI]";
//        if(strpos($actual_link, "/contacts") !== false){
//            header("Location: /login");
//            die();
//        }

//        $this->user = $this->getUser();
//        $rAccess = new RouteAccess();
//        $rAccess->checkAccess($this->user);

        $this->config = include CONFIG_URL;

        //$this->user = $this->getUser();
        $this->view = $this->getView();
    }


    /**
     *     * -------------------------------------------------------------
     *  get view
     * ------------------------------------------------------------*/
    protected function getView()
    {
        if(is_null($this->view))
        {
            $loader = new \Twig\Loader\FilesystemLoader(INC_ROOT . '/Views');    
            //$loader = new \Twig\Loader\FilesystemLoader(__DIR__ .  '/../Views');    
            $this->view = new \Twig\Environment($loader, array('cache' => false/*, 'debug' => true*/));

            //for debug only
            //$this->view->addExtension(new \Twig\Extension\DebugExtension());
        }

        //if user logged in add it to the
            if(!is_null($this->user))
                $this->view->addGlobal("user", $this->user);

            $this->view->addGlobal("page", "$_SERVER[REQUEST_URI]");

        //return view
        return $this->view;
    }


    /**
     * -------------------------------------------------------------------------
     *  gets current user details
     *  //to check if user logged in, just check if it's null or not
     * -------------------------------------------------------------------------*/
    protected function getUser()
    {
        //if user logged in add it to the
        if(isset($_SESSION["token"]) && !empty($_SESSION["token"]))
        {
            $this->user = new UserModel();

            //get user details
            $acLib = new Authentication();
            $user_details = $acLib->getUserByToken($_SESSION["token"]);

            if($user_details != false)
            {
                $this->user->user_id = $user_details["user_id"];
                $this->user->user_email = $user_details["email"];
                $this->user->roles = $acLib->getUserRoles($this->user->user_id);                
            }
        }
        else
        {
            $this->user = null;
        }
    }
}