<?php

namespace FarmManagement\Middleware;

/*
 * A class that checks if user has an access to specific
 *  route or path or page functionality
 */
class RouteAccess
{
    public array  $routes = [];

    public function __construct()
    {
        $this->routes = [
            ['route' => '/', 'access' => ['admin', 'user']],
            ['route' => '/contacts', 'access' => ['admin']],
            ['route' => '/contacts/view', 'access' => ['admin']],
            ['route' => '/contacts/update', 'access' => ['admin']],
            ['route' => '/contacts/add', 'access' => ['admin']],
        ];
    }

    public function checkAccess($user){

        $url_path = "$_SERVER[REQUEST_URI]";

        //if user not logged in redirect to the main page
//        if($user == null)
//            header('Location: /login');

        for($i = 0; $i < count($this->routes); $i++){ //access main array
            for($x = 0; $x < count($this->routes[$i]['access']); $x++){ //access sub array with member roles
                var_dump($this->routes[$i]['access'][$x]);



            }
        }

//        $url_path = "$_SERVER[REQUEST_URI]";
//
//        var_dump($url_path);
        

    }
}