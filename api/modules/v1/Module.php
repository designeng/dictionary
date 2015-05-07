<?php
namespace api\modules\v1;

use Yii;
use yii\web\Session;
use yii\db\Query;
use api\modules\v1\models\Russian;
use api\modules\v1\models\English;
use api\modules\v1\models\Word;
// use app\models\English;

class Module extends \yii\base\Module
{
    public $controllerNamespace = 'api\modules\v1\controllers';

    private $russian = array();
    private $english = array();
    private $words = array();

    public function init()
    {   
        parent::init();

        // $session = new Session;
        // $session->open();

        // $countQuery = (new Query())->select('COUNT(*)')->from('word');
        // Yii::$app->session['quiz_questions_count'] = $countQuery->all()[0]["COUNT(*)"]; 

        // $this->russian = Russian::find()
        //     ->asArray()
        //     ->all();
        // $this->english = English::find()
        //     ->asArray()
        //     ->all();

        // $this->words = Word::find()
        //     ->asArray()
        //     ->all();

        // Yii::$app->session['russian'] = $this->russian;
        // Yii::$app->session['english'] = $this->english;
        // Yii::$app->session['words'] = $this->words;

        // var_dump($session);
    }
}
