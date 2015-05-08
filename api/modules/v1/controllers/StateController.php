<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;

class StateController extends Controller
{   

    public function actionIndex()
    {   
        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $session = Yii::$app->session;

        $user_name = $session['user_name'];

        if (!$user_name){
            $state = ["state" => "INIT_USER_STATE", "user_name" => $user_name ];
        } else {
            $state = ["state" => "QUESTIONS_STATE", "user_name" => $user_name ];
        }
        
        return $state;
    }
}


