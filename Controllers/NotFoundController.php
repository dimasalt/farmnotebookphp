<?php

namespace FarmManagement\Controllers;


class NotFoundController extends BaseController
{
    public function Index() : void
    {
        echo $this->view->render('NotFound/index.twig');
    }
}