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

      /**
     * ----------------------------------------------------------
     * update feed item
     * ----------------------------------------------------------
     */
    public function feedUpdate(){

        session_regenerate_id();        

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //get feed item
        $feed_item = $data->feed_item;

        if(CSRFToken::isValid($data->csrf)){
            //get results
            $helper = new FeedHelper();
            $result = $helper->feedUpdate($feed_item->id, $feed_item->feed_name, $feed_item->feed_desc, $feed_item->feed_cp, $feed_item->feed_tdn, $feed_item->feed_type, 
                                            $feed_item->feed_price, $feed_item->feed_price_lb, $feed_item->feed_usage);
        
            //convert to json
            $result = json_encode($result);

            echo $result;
        }
    }

     /**
     * -----------------------------------------------------------
     * create feed item
     * -----------------------------------------------------------
     */
    public function feedCreate(){
     
        session_regenerate_id();        

        // Takes raw data from the request
        $json = file_get_contents('php://input');

        // Converts it into a PHP object
        $data = json_decode($json);

        //get feed item
        $feed_item = $data->feed_item;

        if(CSRFToken::isValid($data->csrf)){
            //get results
            $helper = new FeedHelper();
            $result = $helper->feedCreate($feed_item->feed_name, $feed_item->feed_desc, $feed_item->feed_cp, $feed_item->feed_tdn, $feed_item->feed_type, 
                                            $feed_item->feed_price, $feed_item->feed_price_lb, $feed_item->feed_usage);
        
            //convert to json
            $result = json_encode($result);

            echo $result;
        }
    }
}