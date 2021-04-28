<?php

namespace FarmWork\Libraries;


class AuthenticationTokens
{
    /**
     * checks if current token exists in database. Returns true if exists and false if not
     */
    public function TokenCheck($token)
    {
        //get user specific information
        $user_agent = $_SERVER['HTTP_USER_AGENT'];
        $user_ip = $_SERVER['REMOTE_ADDR'];

        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Select id From user_logins Where token = ? and user_agent = ? and user_ip = ?');
        $stmt->execute(array($token, $user_agent, $user_ip));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        if($result == false) return false;
        else return true;
    }


    /**
     * add new token into logins page
     */
    public function AddNewToken($user_id, $token)
    {
        //get user specific information
        $user_agent = $_SERVER['HTTP_USER_AGENT'];
        $user_ip = $_SERVER['REMOTE_ADDR'];

        //get database connection
        $db = new DBConnection();
        $pdo = $db->getPDO();

        //remove all old tokens for specific user
        $stmt = $pdo->prepare('Delete from user_logins where user_id = ?');
        $stmt->execute(array($user_id));

        //add new token
        $stmt = $pdo->prepare('Insert into user_logins(user_id, token, user_agent, user_ip) values(?, ?, ?, ?)');
        $stmt->execute(array($user_id, $token, $user_agent, $user_ip));

        $result = $stmt->rowCount();
        if($result > 0) return true;
        else return false;
    }


    /**
     * remove specific token for specific user
     */
    public  function RemoveToken($token)
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Delete From user_logins Where token = ? ');
        $stmt->execute(array($token));

        $result = $stmt->rowCount();
        if($result > 0) return true;
        else return false;
    }


    /**
     * replace old token into new and updated one
     */
    public function ReplaceToken($old_token, $new_token)
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Update user_logins Set token = ?, updated_at = now() Where token = ?');
        $stmt->execute(array($new_token, $old_token));

        $result = $stmt->rowCount();
        if($result > 0) return true;
        else return false;
    }


    /**
     * a database maintenance
     * ------------------------------------------
     * remove any tokens from all the users if those tokens are older than 14 days
     */
    public  function RemoveOldTokens()
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Delete From user_logins Where updated_at < (NOW() - INTERVAL 14 DAY)');
        $stmt->execute();
    }
}


/*
 * --------------------------------------------------------------------
 *          Table to contain login token and information
 * --------------------------------------------------------------------
 * CREATE TABLE `user_logins` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` CHAR(16) NOT NULL COLLATE 'latin1_swedish_ci',
	`token` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`user_agent` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`user_ip` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`modified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `FK__user` (`user_id`),
	CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='contains user login information'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
 */