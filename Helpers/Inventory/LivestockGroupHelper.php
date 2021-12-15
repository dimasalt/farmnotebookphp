<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries;


class LivestockGroupHelper {


    public function getGroups(): array
    {
          //get db
          $db = new Libraries\DBConnection();
          $pdo = $db->getPDO();
  
          //gets livestock groups
          $stmt  = $pdo->prepare('call livestockGroupGetAll()');
          $stmt->execute();
  
          $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);      
  
          return $result;       
    }
}