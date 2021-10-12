<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;

class RationCalculatorHelper {
 
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
     * set feed as default
     * ----------------------------------------------------
     */
    public function setFeedAsDefault($id, $is_default = 0): bool
    {

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedSetDefault(?,?)');
        $stmt->execute([
            $id,
            $is_default
        ]);       

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /**
     * ---------------------------------------------------------
     * gets requirements for animals based on weight and other things
     * ---------------------------------------------------------
     */
    public function getFeedRequirements() : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedGetRequirements()');
        $stmt->execute();       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }
}
