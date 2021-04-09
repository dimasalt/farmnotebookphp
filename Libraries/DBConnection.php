<?php

namespace FarmManagement\Libraries;

use \PDO;

class DBConnection
{
    protected $db;

    //setting up PDO database connection
    public function getPDO()
    {
        //if db is not initiated yet
        if(is_null($this->db)){
            $options = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');

            try {
//                $config = include INC_ROOT . '/app/config.php';
                $config = include CONFIG_URL;

                $this->db = new PDO(
                    $config['db']['dsn'],
                    $config['db']['username'],
                    $config['db']['password'],
                $options);

                $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $ex) {
                die("Failed to connect to the database");
                //: " . $ex->getMessage());
            }
        }

        return $this->db;
    }
}