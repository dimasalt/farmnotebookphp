<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class ContactsHelper
{
    public function GetList() : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactsGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }

    /*
     * ---------------------------------------------------------
     * Gets one contact from database
     * ---------------------------------------------------------
     */
    public function GetOne($contact_id) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactGetOne(?)');
        $stmt->execute(array($contact_id));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $result;
    }

    /*
   * ---------------------------------------------------------
   * add new contact
   * ---------------------------------------------------------
   */
    public function addAction($contact) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactAdd(?,?,?,?,?,?,?,?,?)');
        $stmt->execute(array(
            $contact->contact_name,
            $contact->address,
            $contact->city,
            $contact->postal,
            $contact->country,
            $contact->province,
            $contact->phone,
            $contact->email,
            $contact->note
        ));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }


    /*
    * ---------------------------------------------------------
    * update contact from database
    * ---------------------------------------------------------
    */
    public function updateAction($contact) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        //$pdo->setAttribute( \PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING );
        $stmt = $pdo->prepare('call contactUpdate(?,?,?,?,?,?,?,?,?,?)');
        $stmt->execute(array(
            $contact->id,
            $contact->contact_name,
            $contact->address,
            $contact->city,
            $contact->postal,
            $contact->country,
            $contact->province,
            $contact->phone,
            $contact->email,
            $contact->note
        ));        

        //return $stmt->errorCode();

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
    /*
     * ---------------------------------------------------------
     * removes contact from the list
     * ---------------------------------------------------------
     */
    public function deleteContact($contact_id): bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactDeleteOne(?)');
        $stmt->execute(array($contact_id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }
}