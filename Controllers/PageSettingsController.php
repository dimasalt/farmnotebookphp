<?php

namespace FarmWork\Controllers; 

use FarmWork\Helpers\PageSettingsHelper;
use FarmWork\Libraries\CSRFToken;

/**
 * -----------------------------------------------
 * Gets and sets page settings 
 * -----------------------------------------------
 */

class PageSettings extends BaseController {


    /**
     * -------------------------------------------
     * Gets setting value for specific page
     * example: $page_name = 'Accounting Records'
     * -------------------------------------------
     */
    public function getPageSettings($page_name) {
        
        //get setting for specific page
        $helper = new PageSettingsHelper();
        $result = $helper->getPageSettings($page_name); //Accounting Records

        $result = json_encode($result);
        echo $result;
    }


    /**
     * -------------------------------------------
     * saving value for specific page 
     * -------------------------------------------
     */
    public function savePageSettings($page_name, $setting_name, $setting_value) {
        
    }

}