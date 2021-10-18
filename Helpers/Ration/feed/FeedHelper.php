<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class FeedHelper {
 
       /**
     * ------------------------------------------------
     * gets list of all available feeds 
     * ------------------------------------------------
     */
    public function getFeeds(): array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedsGetAll()');
        $stmt->execute();       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }

    /**
     * ----------------------------------------------------
     * remove feed item
     * ----------------------------------------------------
     */
    public function feedDelete($id){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedDeleteOne(?)');
        $stmt->execute([$id]);       

        if($stmt->rowCount() > 0) return true;
        else return false;                
    }
}
 