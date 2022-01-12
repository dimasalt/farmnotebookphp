<?php

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;


class FeedRequirementHelper {

    /**
     * ---------------------------------------------------------
     * gets requirements for animals based on weight and other things
     * ---------------------------------------------------------
     */
    public function getFeedRequirements($adg, $start_weight, $end_weight) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call feedGetRequirements(?,?,?)');
        $stmt->execute([
            $adg,
            $start_weight,
            $end_weight
        ]);       

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);                    

        return $result;
    }
}