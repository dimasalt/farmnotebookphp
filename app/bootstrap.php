<?php
session_start();

session_regenerate_id(); //create new session id (for security purposes)

require 'vendor/autoload.php';

define('INC_ROOT', dirname(__DIR__));

$config_url = INC_ROOT . '/app/config.php';
$config = require_once($config_url);

define("CONFIG_URL", $config_url);
define('HOST_NAME', $_SERVER['HTTP_HOST']); //website name


$dispatcher = FastRoute\simpleDispatcher(function(FastRoute\RouteCollector $r) {
    //$r->addRoute('POST', '/readForm', 'Test\HomeController:readForm');
    include "routes.php";
});

// Fetch method and URI from somewhere
$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];

// Strip query string (?foo=bar) and decode URI
if (false !== $pos = strpos($uri, '?')) {
    $uri = substr($uri, 0, $pos);
}
$uri = rawurldecode($uri);

$routeInfo = $dispatcher->dispatch($httpMethod, $uri);
switch ($routeInfo[0]) {
    case FastRoute\Dispatcher::NOT_FOUND:
        // ... 404 Not Found
        echo "Page not found 404";
        break;
    case FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
        $allowedMethods = $routeInfo[1];
        // ... 405 Method Not Allowed
        break;
    case FastRoute\Dispatcher::FOUND:

        $handler = $routeInfo[1];
        $vars = $routeInfo[2];
        list($class, $method) = explode(":", $handler, 2);
        call_user_func_array(array(new $class, $method), $vars);
        break;
}
