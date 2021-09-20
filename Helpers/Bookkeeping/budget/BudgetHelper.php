<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class BudgetHelper
{
    /**
    * ---------------------------------------------------------------
    * get list of all budget items
    * ---------------------------------------------------------------
    */
    public function budgetGetAll(): array
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call budgetGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      

       return $result;
    }


      /*
    * Adds one item to the project list
    */
    public function budgetCreateItem($budget_name, $budget_amount, $budget_amount_actual,$is_done, $is_start, $budget_date) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call budgetCreate(?,?,?,?,?,?)');
        $stmt->execute(array($budget_name, $budget_amount, $budget_amount_actual, $is_done, $is_start, $budget_date));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /*
    * removes one item from the project list
    */
    public function budgetDelete($id):bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call budgetDelete(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /*
    * updates one item from the project list
    */
    public function budgetUpdate($id, $budget_name, $budget_amount, $budget_amount_actual, $budget_date) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call budgetUpdate(?,?,?,?,?)');
        $stmt->execute(array($id, $budget_name, $budget_amount, $budget_amount_actual, $budget_date));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /*
    * updates status of a budget item
    */
    public function budgetUpdateStatus($id, $is_done) : bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call budgetUpdateStatus(?,?)');
        $stmt->execute(array($id, $is_done));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
}