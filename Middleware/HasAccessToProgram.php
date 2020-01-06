<?php

namespace Membership\Middleware;

use Membership\Helpers;


//check if user has access to a specific product
class HasAccessToProgram
{
    private $router;
    public function __construct($router)
    {
        $this->router = $router;
    }

    public function __invoke($request, $response, $next)
    {
        // ------------ BEFORE ACTION ---------------------
        //get program id
        $route = $request->getAttribute('route');
        $program_id = $route->getArgument('program_id');

        
        //get program information
        $progHelper = new Helpers\ProgramHelper();
        $program_info = $progHelper->getProgramInfoById($program_id);

        //if program is free then allow access to anyone
        if($program_info['is_free'] == 1) {
            return $next($request, $response);
        }
        else if(isset($_SESSION['token']) && isset($_COOKIE['token'])) //if admin or has access to program
        {
            $achelper = new Helpers\LiveStockSheep();
            $user = $achelper->getUserByToken($_SESSION['token']);

            //if admin give an access
            if($achelper->is_inRole($user['user_id'], 'admin'))
                return $next($request, $response);

            //if program member give an access
            if($progHelper->is_UserInProgram($user['user_id'], $program_id))
                return $next($request, $response);

        }
        else return $response->withRedirect($this->router->pathFor('login'));
    }
}