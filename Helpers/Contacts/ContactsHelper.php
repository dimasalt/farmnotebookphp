<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class ContactsHelper
{
    public function contactsGetAll($data) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactsGetAll(?, ?, ?, ?, ?)');
        $stmt->execute([
            $data->search_term,
            $data->contact_type,
            $data->contact_order_by,
            $data->current_page,
            $data->limit
        ]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }
    
    /**
     * ---------------------------------------------------------
     * Get list of Vendors
     * ---------------------------------------------------------
     */
    public function getVendorList() : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactVendorsGetAll()');
        $stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }


    /*
   * ---------------------------------------------------------
   * add new contact
   * ---------------------------------------------------------
   */
    public function contactAdd($contact) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call contactAdd(?,?,?,?,?,?)');
        $stmt->execute(array(
            $contact->name,
            $contact->address,        
            $contact->phone,
            $contact->email,
            $contact->note,
            $contact->contact_type
        ));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }


    /*
    * ---------------------------------------------------------
    * update contact from database
    * ---------------------------------------------------------
    */
    public function contactUpdate($contact) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        //$pdo->setAttribute( \PDO::ATTR_ERRMODE, \PDO::ERRMODE_WARNING );
        $stmt = $pdo->prepare('call contactUpdate(?,?,?,?,?,?,?)');
        $stmt->execute(array(
            $contact->id,
            $contact->name,
            $contact->address,         
            $contact->phone,
            $contact->email,
            $contact->note,
            $contact->contact_type
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