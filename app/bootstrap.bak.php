<?php
//declare(strict_types=1);

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Slim\App;

use FarmWorks\Libraries\Authentication;

session_start();

//set errors to display status
ini_set('display_startup_errors', '1');
ini_set('display_errors', '1');
error_reporting(-1);


//root folder of application
define('INC_ROOT', dirname(__DIR__)); //root folder
require INC_ROOT. '/vendor/autoload.php';


//[config url]
//$config_path = dirname("/srv") . '/configs/better-life-membership/config.php';
$config_url = INC_ROOT . '/app/config.php';
$config = require_once($config_url);

define("CONFIG_URL", $config_url);
define('HOST_NAME', $_SERVER['HTTP_HOST']); //website name

/***************************************
 * Checking user authentication
 * ************************************/
$auth = new Authentication();
$auth->Authenticate();
/***************************************/


//$configuration = [
//    'settings' => [
//        'displayErrorDetails' => true,
//        'mode' => 'development'
//        //'determineRouteBeforeAppMiddleware' => true
//    ],
//];
//
//$c = new \Slim\Container($configuration);


//Override the default Not Found Handler
//$c['notFoundHandler'] = function ($c) {
//    return function ($request, $response) use ($c) {
//
//        //we do it through controller because controller will also automatically add all
//        //other environment variables (such as user) that we need
//        $notFound = new \FarmWorks\Controllers\NotFoundController($c);
//        $view = $notFound->Index();
//
//        return $c['response']
//            ->withStatus(404)
//            ->withHeader('Content-Type', 'text/html')
//            ->write($view);
//
//    };
//};


$app = AppFactory::create();

$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

require INC_ROOT . '/app/routes.php';
$app->run();
