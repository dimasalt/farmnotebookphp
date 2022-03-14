<?

namespace FarmWork\Helpers;

use FarmWork\Libraries\DBConnection;


class PageSettingsHelper
{
    public function getPageSettings($page_name) : array
    {
        
        $db = new DBConnection();
        $pdo = $db->getPDO();
        $stmt = $pdo->prepare('call pageSettingGet(?)');      
        $stmt->execute([
            $page_name
        ]);

        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }
}