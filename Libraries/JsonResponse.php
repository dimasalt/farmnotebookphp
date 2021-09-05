<?

/**
 * -------------------------------------------------------------------------------------------
 *          Class to return json response with response code 
 * -------------------------------------------------------------------------------------------
 */

namespace FarmWork\Libraries;

class JsonReponse 
{
    public static function response($code = 200, $message = null)
    {
        // remove any string that could create an invalid JSON 
        // such as PHP Notice, Warning, logs...
        ob_clean();

        // clear the old headers
        header_remove();
        
        // set the actual code
        http_response_code($code);
        
        // set the header to make sure cache is forced
        //header("Cache-Control: no-transform,public,max-age=300,s-maxage=900");
        
        // treat this as json
        header("Content-type: application/json; charset=utf-8");

        $status = array(
            200 => '200 OK',
            400 => '400 Bad Request',
            401 => '401 Unauthorized',
            402 => '402 Payment Required',
            403 => '403 Forbidden',
            404 => '404 Not Found',
            405 => '405 Method Not Allowed',
            406 => '406 Not Acceptable',
            412 => '412 Precondition Failed',
            422 => '422 Unprocessable Entity',
            500 => '500 Internal Server Error'
            );
        
        // ok, validation error, or failure
        header('Status: '.$status[$code]);
        
        // return the encoded json
        return json_encode(array(
            'status' => $code < 300, // success or not?
            'message' => $message
            ));
        
        // making sure nothing is added
        exit();
    }
}

// // if you are doing ajax with application-json headers
// if (empty($_POST)) {
//     $_POST = json_decode(file_get_contents("php://input"), true) ? : [];
// }

// // usage
// echo json_response(200, 'working'); // {"status":true,"message":"working"}

// // array usage
// echo json_response(200, array(
//   'data' => array(1,2,3)
//   ));
// // {"status":true,"message":{"data":[1,2,3]}}

// // usage with error
// echo json_response(500, 'Server Error! Please Try Again!'); // {"status":false,"message":"Server Error! Please Try Again!"}
// }

