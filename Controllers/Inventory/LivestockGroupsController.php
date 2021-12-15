<?php

namespace FarmWork\Controllers;

use FarmWork\Libraries\CSRFToken;
use FarmWork\Controllers\BaseController;
use FarmWork\Helpers\LivestockGroupHelper;


class LivestockGroupsController extends BaseController {


    public function getGroups()
    {               
          //call helper
          $helper = new LivestockGroupHelper();
          $result = $helper->getGroups();

          echo json_encode($result);
    }
}