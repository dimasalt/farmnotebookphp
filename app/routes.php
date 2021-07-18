<?php
// inventory pages
$r->addRoute(['GET'], '/inventory/livestock', 'FarmWork\Controllers\LivestockController:index');
$r->addRoute(['GET', 'POST'], '/inventory/livestock/getall', 'FarmWork\Controllers\LivestockController:getLiveStockInventory');


//medication pages
$r->addRoute(['POST', 'GET'], '/medication/view/{id}', 'FarmWork\Controllers\MedicationController:getOne');
$r->addRoute(['POST', 'GET'], '/medication/getList', 'FarmWork\Controllers\MedicationController:getList');
$r->addRoute('GET', '/medication', 'FarmWork\Controllers\MedicationController:index');
$r->addRoute('GET', '/medication/add', 'FarmWork\Controllers\MedicationController:addIndex');
$r->addRoute(['GET', 'POST'], '/medication/add/action', 'FarmWork\Controllers\MedicationController:addAction');
$r->addRoute(['GET', 'POST'], '/medication/update/action', 'FarmWork\Controllers\MedicationController:updateAction');
$r->addRoute('GET', '/medication/update/{id}', 'FarmWork\Controllers\MedicationController:update');
$r->addRoute(['GET', 'POST'] , '/medication/getOne', 'FarmWork\Controllers\MedicationController:getOne');
$r->addRoute(['GET', 'POST'], '/medication/delete', 'FarmWork\Controllers\MedicationController:deleteAction');


//contacts page
$r->addRoute(['GET', 'POST'], '/contacts/getList', 'FarmWork\Controllers\ContactsController:getList');
$r->addRoute(['GET', 'POST'], '/contacts/getVendors', 'FarmWork\Controllers\ContactsController:getVendorList');
$r->addRoute(['GET', 'POST'], '/contacts/delete', 'FarmWork\Controllers\ContactsController:deleteContact');
$r->addRoute(['GET', 'POST'], '/contacts/update/action', 'FarmWork\Controllers\ContactsController:updateAction');
$r->addRoute(['GET', 'POST'], '/contacts/update/{id}', 'FarmWork\Controllers\ContactsController:update');
$r->addRoute(['GET', 'POST'], '/contacts/add/action', 'FarmWork\Controllers\ContactsController:addAction');
$r->addRoute(['GET', 'POST'], '/contacts/add', 'FarmWork\Controllers\ContactsController:add');
$r->addRoute('GET', '/contacts', 'FarmWork\Controllers\ContactsController:index');
$r->addRoute(['GET', 'POST'], '/contacts/view/{id}', 'FarmWork\Controllers\ContactsController:view');

/**
 * ------------------------------------------------------------------
 * transaction records
 * -------------------------------------------------------------------
 */
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/get/all', 'FarmWork\Controllers\RecordsController:transactionsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/del', 'FarmWork\Controllers\RecordsController:transactionDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/add', 'FarmWork\Controllers\RecordsController:transactionAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/edit', 'FarmWork\Controllers\RecordsController:transactionUpdate');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records', 'FarmWork\Controllers\RecordsController:index');

/**
 * ------------------------------------------------------------------
 * transaction record items
 * -------------------------------------------------------------------
 */
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/get', 'FarmWork\Controllers\RecordsController:transactionltemsGet');
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/add', 'FarmWork\Controllers\RecordsController:transactionItemAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/del', 'FarmWork\Controllers\RecordsController:transactionItemDelete');


//finances categories
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/delete', 'FarmWork\Controllers\RecordsTypeController:transactionCatsDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/get/all', 'FarmWork\Controllers\RecordsTypeController:transactionCatsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/save', 'FarmWork\Controllers\RecordsTypeController:transactionCatSave');
$r->addRoute(['GET'], '/bookkeeping/categories', 'FarmWork\Controllers\RecordsTypeController:index');

// finances projects
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/updatestatus', 'FarmWork\Controllers\FinancesPlanningController:projectUpdateStatus');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/update', 'FarmWork\Controllers\FinancesPlanningController:updateOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/add', 'FarmWork\Controllers\FinancesPlanningController:addNew');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/delete', 'FarmWork\Controllers\FinancesPlanningController:delOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects/get/all', 'FarmWork\Controllers\FinancesPlanningController:getList');
$r->addRoute(['GET', 'POST'], '/bookkeeping/projects', 'FarmWork\Controllers\FinancesPlanningController:projects');

// vehicle log book
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/odometer', 'FarmWork\Controllers\VehicleLogBookController:getOdometer');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/addoredit/odometer', 'FarmWork\Controllers\VehicleLogBookController:odometerAddOrEdit');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/del/odometer', 'FarmWork\Controllers\VehicleLogBookController:odometerDelOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/all', 'FarmWork\Controllers\VehicleLogBookController:bookLogsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/add/booklog', 'FarmWork\Controllers\VehicleLogBookController:booklogItemAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/del/booklog', 'FarmWork\Controllers\VehicleLogBookController:booklogItemDel');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook', 'FarmWork\Controllers\VehicleLogBookController:index');


// login page
$r->addRoute('GET', '/login', 'FarmWork\Controllers\LoginController:index');


// main home page
$r->addRoute('GET', '/', 'FarmWork\Controllers\HomeController:index');