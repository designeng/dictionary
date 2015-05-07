<?php
namespace api\modules\v1;

use Yii;
use yii\web\Session;
use yii\db\Query;

class Module extends \yii\base\Module
{
    public $controllerNamespace = 'api\modules\v1\controllers';

    private $russian = array();
    private $english = array();
    private $words = array();

    public function init()
    {   
        parent::init();
    }
}
