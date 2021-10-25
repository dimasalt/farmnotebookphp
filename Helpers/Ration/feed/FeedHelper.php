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
        $stmt = $pdo->prepare('call feedGetAll()');
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

    /**
     * ----------------------------------------------------------
     * update feed item
     * ----------------------------------------------------------
     */
    public function feedUpdate($id, $feed_name, $feed_desc, $feed_cp, $feed_tdn, $feed_type, $feed_price, $feed_price_lb, $feed_usage) : bool {
        
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedUpdate(?,?,?,?,?,?,?,?,?)');
        $stmt->execute([
            $id, 
            $feed_name, 
            $feed_desc, 
            $feed_cp, 
            $feed_tdn, 
            $feed_type, 
            $feed_price, 
            $feed_price_lb, 
            $feed_usage, 
        ]);       

        if($stmt->rowCount() > 0) return true;
        else return false; 
    }
    /**
     * -----------------------------------------------------------
     * create feed item
     * -----------------------------------------------------------
     */
    public function feedCreate($feed_name, $feed_desc, $feed_cp, $feed_tdn, $feed_type, $feed_price, $feed_price_lb, $feed_usage) : bool {
        
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedCreate(?,?,?,?,?,?,?,?)');
        $stmt->execute([
            $feed_name, 
            $feed_desc, 
            $feed_cp, 
            $feed_tdn, 
            $feed_type, 
            $feed_price, 
            $feed_price_lb, 
            $feed_usage
        ]);       

        if($stmt->rowCount() > 0) return true;
        else return false; 
    }
}
 