<?php

//medication pages
$r->addRoute(['POST', 'GET'], '/medication/view/{id}', 'FarmManagement\Controllers\MedicationController:getOne');
$r->addRoute(['POST', 'GET'], '/medication/getList', 'FarmManagement\Controllers\MedicationController:getList');
$r->addRoute('GET', '/medication', 'FarmManagement\Controllers\MedicationController:index');
$r->addRoute('GET', '/medication/add', 'FarmManagement\Controllers\MedicationController:addIndex');
$r->addRoute(['GET', 'POST'], '/medication/add/action', 'FarmManagement\Controllers\MedicationController:addAction');
$r->addRoute(['GET', 'POST'], '/medication/update/action', 'FarmManagement\Controllers\MedicationController:updateAction');
$r->addRoute('GET', '/medication/update/{id}', 'FarmManagement\Controllers\MedicationController:update');
$r->addRoute(['GET', 'POST'] , '/medication/getOne', 'FarmManagement\Controllers\MedicationController:getOne');
$r->addRoute(['GET', 'POST'], '/medication/delete', 'FarmManagement\Controllers\MedicationController:deleteAction');



//contacts page
$r->addRoute(['GET', 'POST'], '/contacts/getList', 'FarmManagement\Controllers\ContactsController:getList');
$r->addRoute(['GET', 'POST'], '/contacts/delete', 'FarmManagement\Controllers\ContactsController:deleteContact');
$r->addRoute(['GET', 'POST'], '/contacts/update/action', 'FarmManagement\Controllers\ContactsController:updateAction');
$r->addRoute(['GET', 'POST'], '/contacts/update/{id}', 'FarmManagement\Controllers\ContactsController:update');
$r->addRoute(['GET', 'POST'], '/contacts/add/action', 'FarmManagement\Controllers\ContactsController:addAction');
$r->addRoute(['GET', 'POST'], '/contacts/add', 'FarmManagement\Controllers\ContactsController:add');
$r->addRoute('GET', '/contacts', 'FarmManagement\Controllers\ContactsController:index');
$r->addRoute(['GET', 'POST'], '/contacts/view/{id}', 'FarmManagement\Controllers\ContactsController:view');

//finances pages
$r->addRoute(['GET', 'POST'], '/finances/transactions/get/all', 'FarmManagement\Controllers\FinancesController:transactionsGetAll');
$r->addRoute(['GET', 'POST'], '/finances/transactions', 'FarmManagement\Controllers\FinancesController:index');

//finances categories
// $r->addRoute(['GET', 'POST'], '/finances/categories/update', 'FarmManagement\Controllers\FinancesController:transactionCatsUpdate');
$r->addRoute(['GET', 'POST'], '/finances/categories/delete', 'FarmManagement\Controllers\FinancesController:transactionCatsDelete');
// $r->addRoute(['GET', 'POST'], '/finances/categories/add', 'FarmManagement\Controllers\FinancesController:transactionCatsAdd');
$r->addRoute(['GET', 'POST'], '/finances/categories/get/all', 'FarmManagement\Controllers\FinancesController:transactionCatsGetAll');
//$r->addRoute(['GET', 'POST'], '/finances/categories/get/allsub', 'FarmManagement\Controllers\FinancesController:transactionSubCatsGetAll');
$r->addRoute(['GET', 'POST'], '/finances/categories/save', 'FarmManagement\Controllers\FinancesController:transactionCatSave');
$r->addRoute(['GET'], '/finances/categories', 'FarmManagement\Controllers\FinancesController:transactionCatsIndex');

// finances projects
$r->addRoute(['GET', 'POST'], '/finances/projects/updatestatus', 'FarmManagement\Controllers\FinancesPlanningController:projectUpdateStatus');
$r->addRoute(['GET', 'POST'], '/finances/projects/update', 'FarmManagement\Controllers\FinancesPlanningController:updateOne');
$r->addRoute(['GET', 'POST'], '/finances/projects/add', 'FarmManagement\Controllers\FinancesPlanningController:addNew');
$r->addRoute(['GET', 'POST'], '/finances/projects/delete', 'FarmManagement\Controllers\FinancesPlanningController:delOne');
$r->addRoute(['GET', 'POST'], '/finances/projects/get/all', 'FarmManagement\Controllers\FinancesPlanningController:getList');
$r->addRoute(['GET', 'POST'], '/finances/projects', 'FarmManagement\Controllers\FinancesPlanningController:projects');

// upload pages
$r->addRoute('GET', '/upload/{name}/{item_type}/{item_id}', 'FarmManagement\Controllers\UploadController:index');
$r->addRoute('GET', '/upload', 'FarmManagement\Controllers\UploadController:index');



// login page
$r->addRoute('GET', '/login', 'FarmManagement\Controllers\LoginController:index');


// main home page
$r->addRoute('GET', '/', 'FarmManagement\Controllers\HomeController:index');