<?php

///**************************************************
// *              DigitalOcean
// * ************************************************/
return [
    "db" => [
        "dsn" => 'mysql:host=127.0.0.1;dbname=farmwork;charset=utf8',
        "host" => "127.0.0.1",
        "database" => "farmwork",
        "username" => "root",
        "password" => ""
    ],
"mail" => [
    "host" => 'smtp.zoho.com',
    "port" => '465', //ssl port
    "ssl" => true,
    "tls" => false,
    "require_auth" => true,
    "username" => '',
    "password" => '',
    "from" => ''
],
    "upload_url" => 'uploads/',
    "website_url" => '',
    "app_token" => '51092c5b070f25d9c4eef87d08f3b86decad4570'
];

