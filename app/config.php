<?php

///**************************************************
// *              DigitalOcean
// * ************************************************/
return [
    "db" => [
        "dsn" => 'mysql:host=127.0.0.1;dbname=livestockmanagement;charset=utf8',
        "host" => "127.0.0.1",
        "database" => "livestockmanagement",
        "username" => "root",
        "password" => "root"
    ],
"mail" => [
    "host" => 'smtp.zoho.com',
    "port" => '465', //ssl port
    "ssl" => true,
    "tls" => false,
    "require_auth" => true,
    "username" => 'dmitri@better-life-tips.com',
    "password" => 'Q74V(;7P8;F6xEk',
    "from" => 'dmitri@better-life-tips.com'
],

    "website_url" => 'membership.dev',
    "app_token" => '51092c5b070f25d9c4eef87d08f3b86decad4570'
];

