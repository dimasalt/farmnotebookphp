<?php

// php -S localhost:8000
namespace FarmManagement\Controllers;

use FarmManagement\Libraries\Authentication;
use FarmManagement\Models\UserModel;
use Twig\Environment;

class BaseController
{
    protected ?Environment $view = null;
    protected ?UserModel $user = null;
    protected array $config = [];

    public function __construct() {
        $this->config = include CONFIG_URL;
        $this->user = $this->getUser();
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
            $this->view = new \Twig\Environment($loader, array('cache' => false));
        }

        //if user logged in add it to the
            if(!is_null($this->user))
                $this->view->addGlobal("user", $this->user);

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