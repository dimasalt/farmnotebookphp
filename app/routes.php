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
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/get/all', 'FarmManagement\Controllers\BookkeepingController:transactionsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records', 'FarmManagement\Controllers\BookkeepingController:index');

//finances categories
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/delete', 'FarmManagement\Controllers\RecordsTypeController:transactionCatsDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/get/all', 'FarmManagement\Controllers\RecordsTypeController:transactionCatsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/save', 'FarmManagement\Controllers\RecordsTypeController:transactionCatSave');
$r->addRoute(['GET'], '/bookkeeping/categories', 'FarmManagement\Controllers\RecordsTypeController:index');

// finances projects
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/updatestatus', 'FarmManagement\Controllers\FinancesPlanningController:projectUpdateStatus');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/update', 'FarmManagement\Controllers\FinancesPlanningController:updateOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/add', 'FarmManagement\Controllers\FinancesPlanningController:addNew');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/delete', 'FarmManagement\Controllers\FinancesPlanningController:delOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/get/all', 'FarmManagement\Controllers\FinancesPlanningController:getList');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects', 'FarmManagement\Controllers\FinancesPlanningController:projects');

// vehicle log book
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/odometer', 'FarmManagement\Controllers\VehicleLogBookController:getOdometer');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/add/odometer', 'FarmManagement\Controllers\VehicleLogBookController:odometerAddNew');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/del/odometer', 'FarmManagement\Controllers\VehicleLogBookController:odometerDelOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/all', 'FarmManagement\Controllers\VehicleLogBookController:bookLogsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook', 'FarmManagement\Controllers\VehicleLogBookController:index');

// upload pages
$r->addRoute('GET', '/upload/{name}/{item_type}/{item_id}', 'FarmManagement\Controllers\UploadController:index');
$r->addRoute('GET', '/upload', 'FarmManagement\Controllers\UploadController:index');



// login page
$r->addRoute('GET', '/login', 'FarmManagement\Controllers\LoginController:index');


// main home page
$r->addRoute('GET', '/', 'FarmManagement\Controllers\HomeController:index');