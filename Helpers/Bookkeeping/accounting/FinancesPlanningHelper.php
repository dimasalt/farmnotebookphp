<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class FinancesPlanningHelper
{
    /*
    * get list of all available project items
    */
    public function getList(){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      

       return $result;
    }

     /*
    * removes one item from the project list
    */
    public function delOne($id):bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectDelOne(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

     /*
    * Adds one item to the project list
    */
    public function addNew($project_name, $project_price, $project_price_actual, $is_start, $created_at) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectAdd(?,?,?,?,?)');
        $stmt->execute(array($project_name, $project_price, $project_price_actual, $is_start, $created_at));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

     /*
    * updates one item from the project list
    */
    public function updateOne($project_id, $project_name, $project_price, $project_price_actual, $created_at) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectUpdateOne(?,?,?,?,?)');
        $stmt->execute(array($project_id, $project_name, $project_price, $project_price_actual, $created_at));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
    

    /*
    * updates one item from the project list
    */
    public function projectUpdateStatus($project_id, $is_done) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call projectUpdateStatus(?,?)');
        $stmt->execute(array($project_id, $is_done));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

}