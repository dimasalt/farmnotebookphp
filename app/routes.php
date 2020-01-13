<?php

//medication pages
$r->addRoute(['POST', 'GET'], '/medication/getList', 'FarmManagement\Controllers\MedicationController:getList');
$r->addRoute('GET', '/medication', 'FarmManagement\Controllers\MedicationController:index');

//contacts page
$r->addRoute(['GET', 'POST'], '/contacts/getList', 'FarmManagement\Controllers\ContactsController:getList');
$r->addRoute(['GET', 'POST'], '/contacts/delete', 'FarmManagement\Controllers\ContactsController:deleteContact');
$r->addRoute(['GET', 'POST'], '/contacts/update/action', 'FarmManagement\Controllers\ContactsController:updateAction');
$r->addRoute(['GET', 'POST'], '/contacts/update/{id}', 'FarmManagement\Controllers\ContactsController:update');
$r->addRoute(['GET', 'POST'], '/contacts/add/action', 'FarmManagement\Controllers\ContactsController:addAction');
$r->addRoute(['GET', 'POST'], '/contacts/add', 'FarmManagement\Controllers\ContactsController:add');
$r->addRoute('GET', '/contacts', 'FarmManagement\Controllers\ContactsController:index');

// main home page
$r->addRoute('GET', '/', 'FarmManagement\Controllers\HomeController:index');