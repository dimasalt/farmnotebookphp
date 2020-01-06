<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;

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