<?php
// inventory pages
$r->addRoute(['GET'], '/inventory/livestock', 'FarmWork\Controllers\LivestockController:index');
$r->addRoute(['GET', 'POST'], '/inventory/livestock/get/all', 'FarmWork\Controllers\LivestockController:getLiveStockInventory');

// inventory types
$r->addRoute(['GET', 'POST'], '/inventory/types/delete', 'FarmWork\Controllers\LivestockTypesController:livestockCatsDelete');
$r->addRoute(['GET', 'POST'], '/inventory/types/save', 'FarmWork\Controllers\LivestockTypesController:livestockCatSave');
$r->addRoute(['GET', 'POST'], '/inventory/types/get/all', 'FarmWork\Controllers\LivestockTypesController:getLiveStockTypes');
$r->addRoute(['GET'], '/inventory/types', 'FarmWork\Controllers\LivestockTypesController:index');


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
$r->addRoute(['GET', 'POST'], '/contacts/get/all', 'FarmWork\Controllers\ContactsController:contactsGetAll');
$r->addRoute(['GET', 'POST'], '/contacts/getVendors', 'FarmWork\Controllers\ContactsController:getVendorList');
$r->addRoute(['GET', 'POST'], '/contacts/delete', 'FarmWork\Controllers\ContactsController:deleteContact');
$r->addRoute(['GET', 'POST'], '/contacts/update', 'FarmWork\Controllers\ContactsController:contactUpdate');
$r->addRoute(['GET', 'POST'], '/contacts/add', 'FarmWork\Controllers\ContactsController:contactAdd');
$r->addRoute('GET', '/contacts', 'FarmWork\Controllers\ContactsController:index');

/**
 * ------------------------------------------------------------------
 * transaction records
 * -------------------------------------------------------------------
 */
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/get/totals', 'FarmWork\Controllers\RecordsController:transactionGetTotals');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/get/all', 'FarmWork\Controllers\RecordsController:transactionsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/del', 'FarmWork\Controllers\RecordsController:transactionDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/add', 'FarmWork\Controllers\RecordsController:transactionAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/edit', 'FarmWork\Controllers\RecordsController:transactionUpdate');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records', 'FarmWork\Controllers\RecordsController:index');

//transaction image upload
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/receipt/upload', 'FarmWork\Controllers\RecordsController:transactionReceiptUpload');
$r->addRoute(['GET', 'POST'], '/bookkeeping/records/receipt/remove', 'FarmWork\Controllers\RecordsController:transactionReceiptRemove');

/**
 * ------------------------------------------------------------------
 * transaction record items
 * -------------------------------------------------------------------
 */
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/get', 'FarmWork\Controllers\RecordsController:transactionltemsGet');
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/add', 'FarmWork\Controllers\RecordsController:transactionItemAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/record/item/del', 'FarmWork\Controllers\RecordsController:transactionItemDelete');


//Transactions reports
$r->addRoute(['GET'], '/bookkeeping/reports', 'FarmWork\Controllers\ReportsController:index');


//finances categories
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/delete', 'FarmWork\Controllers\RecordsTypeController:transactionCatsDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/get/all', 'FarmWork\Controllers\RecordsTypeController:transactionCatsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/categories/save', 'FarmWork\Controllers\RecordsTypeController:transactionCatSave');
$r->addRoute(['GET'], '/bookkeeping/categories', 'FarmWork\Controllers\RecordsTypeController:index');


//budget planning
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/update/status', 'FarmWork\Controllers\BudgetController:budgetUpdateStatus');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/update', 'FarmWork\Controllers\BudgetController:budgetUpdate');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/delete', 'FarmWork\Controllers\BudgetController:budgetDelete');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/add', 'FarmWork\Controllers\BudgetController:budgetCreateItem');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/get/all', 'FarmWork\Controllers\BudgetController:budgetGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget/get/getdropdownselections', 'FarmWork\Controllers\BudgetController:getDropDownSelections');
$r->addRoute(['GET', 'POST'], '/bookkeeping/budget', 'FarmWork\Controllers\BudgetController:index');


// finances planning //planning
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning/updatestatus', 'FarmWork\Controllers\FinancesPlanningController:projectUpdateStatus');
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning/update', 'FarmWork\Controllers\FinancesPlanningController:updateOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning/add', 'FarmWork\Controllers\FinancesPlanningController:addNew');
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning/delete', 'FarmWork\Controllers\FinancesPlanningController:delOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning/get/all', 'FarmWork\Controllers\FinancesPlanningController:getList');
$r->addRoute(['GET', 'POST'], '/bookkeeping/planning', 'FarmWork\Controllers\FinancesPlanningController:index');

// vehicle log book
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/odometer', 'FarmWork\Controllers\VehicleLogBookController:getOdometer');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/addoredit/odometer', 'FarmWork\Controllers\VehicleLogBookController:odometerAddOrEdit');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/del/odometer', 'FarmWork\Controllers\VehicleLogBookController:odometerDelOne');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/get/all', 'FarmWork\Controllers\VehicleLogBookController:bookLogsGetAll');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/add/booklog', 'FarmWork\Controllers\VehicleLogBookController:booklogItemAdd');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook/del/booklog', 'FarmWork\Controllers\VehicleLogBookController:booklogItemDel');
$r->addRoute(['GET', 'POST'], '/bookkeeping/vehiclelogbook', 'FarmWork\Controllers\VehicleLogBookController:index');

// Ration
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator/FeedRequirementsAdg', 'FarmWork\Controllers\RationCalculatorController:FeedRequirementsAdg');
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator/FeedRequirements[/{start_weight}[/{end_weight}]]', 'FarmWork\Controllers\RationCalculatorController:FeedRequirements');
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator/getFeedRequirements', 'FarmWork\Controllers\RationCalculatorController:getFeedRequirements');
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator/setDefaultFeed', 'FarmWork\Controllers\RationCalculatorController:setFeedAsDefault');
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator/getfeeds', 'FarmWork\Controllers\RationCalculatorController:getFeeds');
$r->addRoute(['GET', 'POST'], '/ration/ration_calculator', 'FarmWork\Controllers\RationCalculatorController:index');

// feeds
$r->addRoute(['GET', 'POST'], '/ration/feeds/create', 'FarmWork\Controllers\FeedController:feedCreate');
$r->addRoute(['GET', 'POST'], '/ration/feeds/update', 'FarmWork\Controllers\FeedController:feedUpdate');
$r->addRoute(['GET', 'POST'], '/ration/feeds/delete', 'FarmWork\Controllers\FeedController:feedDelete');
$r->addRoute(['GET', 'POST'], '/ration/feeds/get/all', 'FarmWork\Controllers\FeedController:getFeeds');
$r->addRoute(['GET', 'POST'], '/ration/feeds', 'FarmWork\Controllers\FeedController:index');

// login page
$r->addRoute('GET', '/login', 'FarmWork\Controllers\LoginController:index');


// main home page
$r->addRoute('GET', '/', 'FarmWork\Controllers\HomeController:index');