<?php

namespace FarmWork\Controllers;

use FarmWork\Helpers\UploadHelper;
use FarmWork\Libraries\CSRFToken;

class UploadController extends BaseController {

    /**
     * Loads index upload page
     */
    public function index()
    {
        session_regenerate_id();

        echo $this->view->render('Upload\index.twig', [
            'csrf' => CSRFToken::getToken()
        ]);
    }
}