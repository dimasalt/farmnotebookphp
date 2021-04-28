<?php

namespace FarmWork\Libraries;

/**
 * -------------------------------------------------------------------------------------------
 * Remember me functionality
 * Authenticates returning user as long as all three token, user agent and user ip do match.
 * In case if match is not found we just going to remove token all together and unset cookie
 * ------------------------------------------------------------------------------------------
 */
class Authentication
{
    private $token;
    public function Authenticate() : void
    {
        if(isset($_COOKIE["token"]) && !empty($_COOKIE["token"]))
        {
            $this->token = new AuthenticationTokens();

            $current_token = $_COOKIE["token"];
            //if token is valid and user agent and user ip do match
            if($this->token->TokenCheck($current_token))
            {
                $new_token = bin2hex(random_bytes(32)); //random string
                $this->token->ReplaceToken($current_token, $new_token);

                //change token in session as well
                $_SESSION["token"] = $new_token;
                $_COOKIE["token"] = $new_token;
                setcookie("token", $new_token, time() + 60*60*24*14, "/", HOST_NAME); //set cookie for 14 days
            }
            else {
                //if token did not match we are removing token and cookie
                $this->token->RemoveOldTokens();
                unset($_COOKIE['token']);
                setcookie("token", "", 1, "/", HOST_NAME);
            }
        }
    }

    /**
     * ----------------------------------------------
     *  check if user already exists
     * ---------------------------------------------*/
    public function CheckIfUserExists($email) : bool
    {
        //get db
        $db = new DBConnection();
        $pdo = $db->getPDO();

        //check if user already exists
        $stmt =   $stmt  = $pdo->prepare('Select email from users where email = ?');
        $stmt->execute(array($email));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        //if user found return true else return false
        if($result == false) return false;
        else return true;
    }


    /**
     * -----------------------------------------------------
     * registering new user and setting roles for him
     * -----------------------------------------------------*/
    public function CreateNewUser($email, $password, $role, $fname, $lname) : bool
    {
        $user_added = false;
        $role_created = false;

        //get db
        $db = new DBConnection();
        $pdo = $db->getPDO();

        $guid = uniqid('', true);

        //add new user
        $stmt = $pdo->prepare('Insert into users(user_id, email, password, is_active) values(?, ?, ?, 1)');
        $stmt->execute(array($guid, $email, $password));

        if($stmt->rowCount() > 0) $user_added = true;

        //add extended details and add user to role
        if($user_added) {
            $this->addNewUserDetails($guid, $fname, $lname);
            $role_created = $this->addUserToRole($guid, $role);
        }


        if($user_added && $role_created)
            return true;
        else return false;
    }

    /**
     * ---------------------------------------------------------
     * Remove user
     * ----------------------------------------------------------
     */
    public function removeUser($user_id) : bool
    {
        //get db
        $db = new DBConnection();
        $pdo = $db->getPDO();

        $stmt = $pdo->prepare('Delete FROM users WHERE user_id = ?');
        $stmt->execute(array($user_id));

        if($stmt->rowCount() > 0) return true;
        else return false;
    }

    /**
     * ----------------------------------------------------------
     * Add new user details
     * ----------------------------------------------------------*/
    public function addNewUserDetails($user_id, $fname, $lname) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Insert into user_details(user_id, first_name, last_name ) values(?, ?, ?)');
        $stmt->execute(array($user_id, $fname, $lname));

        $result_details =  $stmt->rowCount();

        if($result_details > 0) return true;
        else return false;
    }


    /**
     * ---------------------------------------------------------
     * Update user profile (fname, lname, avatar_url
     * ---------------------------------------------------------*/
    public function UpdateUserDetails($user_id, $fname, $lname, $avatar_url) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Update user_details Set first_name = ?, last_name = ?, avatar_url = ?, updated_at = now() Where user_id = ?');
        $stmt->execute(
            array(
                empty($fname) ? null : $fname,
                empty($lname) ? null : $lname,
                empty($avatar_url) ? null : $avatar_url,
                $user_id
            )
        );

        $result = $stmt->rowCount();

        if($result > 0) return true;
        else return false;
    }

    /**
     * ---------------------------------------------------------------
     * updates existing user password
     * ---------------------------------------------------------------*/
    public function ChangeUserPassword($user_id, $password) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Update users Set password = ?, updated_at = now() Where user_id = ?');
        $stmt->execute(array($password, $user_id));

        $result = $stmt->rowCount();
        if($result > 0) return true;
        else return false;
    }

    /**
     * ------------------------------------------------
     *  gets users by their email
     * -----------------------------------------------*/
    public function getUserByEmail($email) : array
    {
        try {
            $db = new DBConnection();
            $pdo = $db->getPDO();
            $stmt  = $pdo->prepare('Select user_id, email, password, is_active from users where email = ?');
            $stmt->execute(array($email));

            $row = $stmt->fetch(\PDO::FETCH_ASSOC);

            return $row;
        }
        catch (PDOException $ex) {
            die("Failed to connect to the database");//: " . $ex->getMessage());
        }
    }

    /**
     * --------------------------------------------
     *  gets users by their id
     * -------------------------------------------*/
    public function getUserByID($user_id) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('Select user_id, email, password, is_active from users where user_id = ?');
        $stmt->execute(array($user_id));

        $row = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $row;
    }

    /**
     * ----------------------------------------------------
     *  gets users by their login token
     * ---------------------------------------------------*/
    public function getUserByToken($token) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('SELECT users.user_id, users.email 
                              FROM users 
                                LEFT JOIN user_logins ON (users.user_id = user_logins.user_id)          
                              WHERE user_logins.token = ?');
        $stmt->execute(array($token));

        $row = $stmt->fetch(\PDO::FETCH_ASSOC);

        return $row;
    }


    /**
     * ------------------------------------------------------------------
     *           Add user to role
     * -----------------------------------------------------------------*/
    public function addUserToRole($user_id, $role) : bool
    {
        $added_to_role = false;

        $db = new DBConnection();
        $pdo = $db->getPDO();

        $stmt =   $stmt  = $pdo->prepare('Select role_id, role from roles where role = ?');
        $stmt->execute(array($role));

        $row = $stmt->fetch(\PDO::FETCH_ASSOC);

        if($row != false) //if role been found
        {
            $stmt = $pdo->prepare('Insert into users_to_role(user_id, role_id) values(?, ?)');
            $stmt->execute(array($user_id, $row["role_id"]));

            if($stmt->rowCount() > 0) $added_to_role = true;
        }

        return $added_to_role;

    }

    /**
     * ----------------------------------------------
     *  get user roles by user id
     * ---------------------------------------------*/
    public function getUserRoles($user_id) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('SELECT roles.role
                                 FROM users 
                                     LEFT JOIN users_to_role ON (users.user_id = users_to_role.user_id)
                                     LEFT JOIN roles ON (users_to_role.role_id = roles.role_id)
                                 WHERE users.user_id = ?');
        $stmt->execute(array($user_id));

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        //var_dump($result);

        $roles = [];
        foreach ($result as $item)
            $roles[] = $item['role'];

        return $roles;
    }


    /**
     * ------------------------------------------------
     *  check if user is in specific role
     * -----------------------------------------------*/
    public function is_inRole($user_id, $role) : bool
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('SELECT 
                                  roles.role, 
                                  users_to_role.user_id
                              FROM roles 
                                  LEFT JOIN users_to_role ON (users_to_role.role_id = roles.role_id)       
                              WHERE users_to_role.user_id = ? and roles.role = ?');
        $stmt->execute(array($user_id, $role));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);

        if($result == false) return false;
        else return true;

    }


    /**
     * --------------------------------------------------------
     *  get user profile (all the details including
     *  first name, last name, avatar url etc...)
     * -------------------------------------------------------*/
    public function getUserProfile($user_id) : array
    {
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('SELECT 
                                  users.user_id, 
                                  users.email, 
                                  user_details.first_name, 
                                  user_details.last_name, 
                                  user_details.avatar_url
                                FROM users 
                                  LEFT JOIN user_details ON (user_details.user_id = users.user_id)       
                                WHERE users.user_id = ? and users.is_active = 1');
        $stmt->execute(array($user_id));

        $result = $stmt->fetch(\PDO::FETCH_ASSOC);
        return $result;
    }

}

/*
 * -----------------------------------------------
 *          Database user related tables
 * -----------------------------------------------
 * CREATE TABLE `user` (
	`id` VARCHAR(16) NOT NULL,
	`username` VARCHAR(15) NOT NULL,
	`password` VARCHAR(36) NOT NULL,
	`is_active` TINYINT(4) NOT NULL DEFAULT '1',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COMMENT='cattle management members.'
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

----------------------------------------------------------
CREATE TABLE `user_role` (
	`id` CHAR(16) NOT NULL,
	`role` VARCHAR(10) NOT NULL,
	`role_desc` VARCHAR(150) NULL DEFAULT NULL,
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
)
COMMENT='member roles in the cattle management system.'
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;
-------------------------------------------------------------
CREATE TABLE `user_to_role` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`user_id` VARCHAR(16) NOT NULL,
	`user_role` CHAR(16) NOT NULL DEFAULT '',
	`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `FK_user_to_role_user` (`user_id`),
	INDEX `FK_user_to_role_user_role` (`user_role`),
	CONSTRAINT `FK_user_to_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `FK_user_to_role_user_role` FOREIGN KEY (`user_role`) REFERENCES `user_role` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Cattle Management system users and their role connections'
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


 */