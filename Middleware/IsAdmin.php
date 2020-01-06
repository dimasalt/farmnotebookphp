<?php

namespace FarmWorks\Middleware;

use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Psr7\Response;
use Slim\App;

use FarmWorks\Libraries\Authentication;


/**
 * *************************************************************
 * Checks if user is Admin. If yes then continue to the page
 * if not redirect to the login page
 * ************************************************************
 */

class IsAdmin
{
    private $app;
    public function __construct(App $app)
    {
        $this->app = $app;
    }

    public function __invoke(Request $request, RequestHandler $handler) : Response
    {
        // ------------ BEFORE ACTION ---------------------
       //if no token send to login page
//        $response = $handler->handle($request);
//        $existingContent = (string) $response->getBody();

        if(isset($_SESSION['token']) && isset($_COOKIE['token'])){
            $auth = new Authentication();
            $user = $auth->getUserByToken($_SESSION['token']);
            if(!$auth->is_inRole($user['user_id'], 'admin')){
                header('Location: /login', true, 301);
                exit();

                /*
                 * another way is
                 * echo "<script>location.href='target-page.php';</script>";
                 */
            }
        }
        else {
            header('Location: /login', true, 301);
            exit();
        }

        $response = new Response();
        return $response;


        //$response->getBody()->write('BEFORE' . $existingContent);
//        return $response->withRedirect($this->router->pathFor('login'));
    }
}