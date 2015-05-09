<?php
namespace api\modules\v1;

use Yii;
use yii\web\Session;
use yii\db\Query;
use api\modules\v1\models\Word;

class Bootstrap extends \yii\base\Module
{
    public $controllerNamespace = 'api\modules\v1\controllers';

    private $words = array();
    private $session = null;

    public function init() {
        parent::init();

        $session = Yii::$app->session;

        // init session variables
        if (!$session->has('words') && !$session->has('dictionary')){
            $this->words = Word::find()
                ->asArray()
                // DEBUG
                ->limit(4)
                ->all();

            // in dictionary var stored all quiz words
            // in words we store the words rest
            $session['words'] = $session['dictionary'] = $this->words;
        }

        if (!$session->has('mistakes_count')){
            $session["mistakes_count"] = 0;
        }

        if (!$session->has("user_score")){
            $session["user_score"] = 0;
        }
    }
}
