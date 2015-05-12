<?php
namespace api\modules\v1;

use Yii;
use yii\web\Session;
use yii\db\Query;

class Module extends \yii\base\Module
{
    public $controllerNamespace = 'api\modules\v1\controllers';

    public function init()
    {   
        parent::init();
    }
}
