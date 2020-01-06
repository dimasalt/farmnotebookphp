<?php

namespace Membership\Middleware;

/**
 * *************************************************************
 * Checks if API call allowed to access application API
 * function. Checks received API with API key in config file
 * *************************************************************** 
 */

class HasAccessToAPI
{
    public function __invoke($request, $response, $next){
        
        //api receied by application
        $route = $request->getAttribute('route');
        $app_token = $route->getArgument('app_token');
        

        //api key that we need from application
        //$config = include INC_ROOT . '/app/config.php';
        $config = require_once CONFIG_URL;
        
        //if everything good then continue
        //otherwise quick the application
        if($app_token == $config['app_token'])
            return $next($request, $response);

        //if checks are failed then quit the program execution
        die('not good');
    }

}