<?php

namespace Membership\Middleware;

/**
 * *********************************************************
 * Checks if user is logged in
 * *********************************************************
 */


class LoggedIn
{
    
    private $router;
    public function __construct($router)
    {
        $this->router = $router;
    }

    public function __invoke($request, $response, $next)
    {
        // ------------ BEFORE ACTION ---------------------
        //if page is only for authorized users and our member
        //is not logged in then redirect to login page
        if(isset($_SESSION["token"]) || isset($_COOKIE['token']))
        {
            $response = $next($request, $response);
            return $response;
        }
        else return $response->withRedirect($this->router->pathFor('home'));
    }
}
