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
        $stmt = $pdo->prepare('call financialPlanningGetAll()');
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
        $stmt = $pdo->prepare('call financialPlanningDelOne(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

     /*
    * Adds one item to the project list
    */
    public function addNew($planning_name, $planning_amount, $planning_amount_actual, $is_start, $created_at) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call financialPlanningAdd(?,?,?,?,?)');
        $stmt->execute(array($planning_name, $planning_amount, $planning_amount_actual, $is_start, $created_at));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

     /*
    * updates one item from the project list
    */
    public function updateOne($project_id, $planning_name, $planning_amount, $planning_amount_actual, $created_at) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call financialPlanningUpdateOne(?,?,?,?,?)');
        $stmt->execute(array($project_id, $planning_name, $planning_amount, $planning_amount_actual, $created_at));

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
        $stmt = $pdo->prepare('call financialPlanningUpdateStatus(?,?)');
        $stmt->execute(array($project_id, $is_done));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

}