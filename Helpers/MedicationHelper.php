<?php

namespace FarmManagement\Helpers;

use FarmManagement\Libraries\DBConnection;
use MongoDB\Client as MongoDB;
use \MongoDB\BSON\Regex as Regex;



class MedicationHelper
{
    /*
    * get list of all available medication items
    */
    public function getList($search_term){      

        // $collection = (new MongoDB)->farmwork->medication; 

        // $cursor = $collection->find(['$or' => [
        //     ["name" => new Regex($search_term, "i")], 
        //     ["desc" => new Regex($search_term, "i")],
        //     ["instruction" => new Regex($search_term, "i")]
        // ]]);       
             

        // //$cursor = iterator_to_array($cursor);       

        // $result = [];
        // foreach($cursor as $item){           
        //     array_push($result, [               
        //         "_id" =>$item["_id"]->__toString(),
        //         "name" =>$item["name"], 
        //         "desc" => $item["desc"],
        //         "instruction"=> $item["instruction"],
        //         "img"=>$item["img"],
        //         "created_at" => date('h:i:s m/d/Y', (int)$item["created_at"]->__toString() /1000)
        //     ]);
        // }         



        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationGetAll(?)');
        $stmt->execute(array($search_term));
        //$stmt->execute();

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        // // for($i = 0; $i< count($result); $i++){
        // //     if(strlen($result[$i]["desc"]) > 100 )
        // //         $result[$i]['desc'] = substr($result[$i]['desc'], 0, 110) . '...';
        // // }

       

       return $result;
    }

    /*
    * gets a single medication item
    */
    public function getOne($id){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationGetOne(?)');
        $stmt->execute(array($id));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $result;
    }

    /*
    * removes medication item from database
    */
    public function deleteAction($id){

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationDeleteOne(?)');
        $stmt->execute(array($id));

        if($stmt->rowCount() > 0) return true;
        else return false;

    }

    /*
    * adds medication item
    */
    public function addAction($medication){
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call medicationAdd(?,?,?,?,?)');
        $stmt->execute(array(
            $medication->med_name, 
            $medication->med_desc, 
            $medication->med_instr, 
            $medication->med_price, 
            $medication->med_on_hand
        ));

        //fetch last insert id 
        //returns array with only one number in place [0]
        $id = $stmt->fetch(\PDO::FETCH_NUM)[0];

        //set result object to return to ajax
        $result = [
            'id' => $id,
            'result' => true
        ];

        return $result;       
    }
}