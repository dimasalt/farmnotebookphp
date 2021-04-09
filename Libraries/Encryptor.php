<?php

namespace FarmManagement\Libraries;

// Good video on PHP encryption
// https://www.youtube.com/watch?v=KCJFl5wMyGg&nohtml5=False -> (outdated)
//--------------------------------------------------------------


/*--------------------------------------------------------
  Based on: https://packagist.org/packages/hieblmedia/simple-php-encrypter-decrypter -> (check for updated version)
----------------------------------------------------------*/
class Encryptor
{
    private $secureKey;

    public function __construct()
    {
        //$config = include INC_ROOT . '/app/config.php';
        $config = include CONFIG_URL;
        $this->secureKey = $config["app_token"];

        //encrypt secure key
        $this->secureKey =  hash('sha256', $this->secureKey, true);
        //$this->secureKey = pack('H*', $this->secureKey);
    }
    

    public function encrypt($value)
    {
        if ($value === '' || !is_scalar($value)) {
            return false;
        }

        $text = $value;
        $ivSize = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB);
        $iv = mcrypt_create_iv($ivSize, MCRYPT_RAND);
        $cryptText = mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $this->secureKey, $text, MCRYPT_MODE_ECB, $iv);

        return trim($this->safeBase64Encode($cryptText));
    }


    public function decrypt($value)
    {
        if ($value === '' || !is_scalar($value)) {
            return false;
        }

        $cryptText = $this->safeBase64Decode($value);
        $ivSize = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB);
        $iv = mcrypt_create_iv($ivSize, MCRYPT_RAND);
        $decryptText = mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $this->secureKey, $cryptText, MCRYPT_MODE_ECB, $iv);

        return trim($decryptText);
    }



    public function safeBase64Encode($string)
    {
        $data = base64_encode($string);
        $data = str_replace(array('+', '/', '='), array('-', '_', ''), $data);
        return $data;
    }


    public function safeBase64Decode($string)
    {
        $data = str_replace(array('-', '_'), array('+', '/'), $string);
        $mod4 = strlen($data) % 4;
        if ($mod4) {
            $data .= substr('====', $mod4);
        }
        return base64_decode($data);
    }
}