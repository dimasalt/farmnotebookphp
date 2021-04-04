<?php

namespace FarmManagement\Controllers;

use \MongoDB\Client as MongoDB;


class HomeController extends BaseController
{
    // main page
    public function index()
    {
        //$collection = (new MongoDB)->farm->vehicle_booklog;

        //db.vehicle_booklog.find( { vehicle_desc: /Silverado/i  } )
        //$test = $collection->findOne(array( "year_start_odometer" => 175153 ));
        // $test = $collection->findOne( [ "vehicle_desc" => new \MongoDB\BSON\Regex("silverado", "i") ]);

        // foreach ($test as $document) {
        //     var_dump($test);
        // }
        // var_dump($test);
        // die();



        //$uid1 = uniqid();
        echo $this->view->render('Home/index.twig');
        //echo $this->view->render('LiveStock/index.twig');
    }
}