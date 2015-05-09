<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use api\modules\v1\models\User;

class UserController extends Controller
{   
    public static function saveCurrentUserResult(){
        $session = Yii::$app->session;
        $user = new User();
        $user->name = $session["user_name"];
        $user->score = $session["user_score"];
        $user->save();
    }
}


