<?php

namespace FarmManagement\Libraries;

/**
 * Class CSRFToken
 * @package FarmWorks\Libraries
 * Class respobsible for creation and validation of
 * csrf tokens for the input forms
 */
class CSRFToken
{
    private static $csrf_tocken = '';

    /*
     * -----------------------------------------------------
     * Sets a new csrf token and returns it for the form
     * -----------------------------------------------------
     */
    public static function getToken() : string
    {
        self::$csrf_tocken = bin2hex(random_bytes(32));
        $_SESSION['csrf_token'] = self::$csrf_tocken;

        return self::$csrf_tocken;
    }

    /*
     * ---------------------------------------------------------------
     * check if CSRF token received from the form is valid
     * ---------------------------------------------------------------
     */
    public static function isValid($token) : bool
    {
        if(isset($_SESSION['csrf_token']))
            if(hash_equals($_SESSION['csrf_token'], $token))
                return true;
            else return false;

        return false;
    }
}

/**********************************************************************************************************
 * Note for the future: Write csrf token stored and validated from database instead of php sessions
 * which are cookie based ???
 ***********************************************************************************************************/