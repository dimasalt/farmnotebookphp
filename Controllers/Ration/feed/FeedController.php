<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\FeedHelper;
use FarmWork\Libraries\CSRFToken;


class FeedController extends BaseController
{
    // main page
    public function index()
    {
       session_regenerate_id();

       echo $this->view->render('Ration\feed\index.twig',
            [ 'csrf' => CSRFToken::getToken()]
        );    
    }

    /**
     * ------------------------------------------------
     * gets list of all available feeds 
     * ------------------------------------------------
     */
    public function getFeeds(){

        session_regenerate_id();

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //get results
        $helper = new FeedHelper();
        $items = $helper->getFeeds();
       
        //convert to json
        $items = json_encode($items);      
        echo $items;
    }

    /**
     * ------------------------------------------------
     * remove feed item from database
     * ------------------------------------------------
     */
    public function feedDelete(){
        session_regenerate_id();        

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        if(CSRFToken::isValid($data->csrf)){
            //get results
            $helper = new FeedHelper();
            $result = $helper->feedDelete($data->id);
        
            //convert to json
            $result = json_encode($result);
            
            echo $result;
        }
    }
}