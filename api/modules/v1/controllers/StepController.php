<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use yii\base\Request;
use api\modules\v1\controllers\UserController;

class StepController extends Controller
{   

    public function actionIndex()
    {   
        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $session = Yii::$app->session;

        // prevent service call for not registred user (player)
        if(!$session['user_name']){
            return $response = [];
        }

        $words = $session['words'];

        if(!count($words)){
            UserController::saveCurrentUserResult();
            return $response = [
                "state"=> "QUIZ_END_WORDS", 
                "user_score" => $session["user_score"]
            ];
        }

        $dictionary = $session['dictionary'];

        shuffle($words);
        $randomWord = array_shift($words);
        $session['current_word'] = $randomWord;

        $lang_keys = ["en", "ru"];
        shuffle($lang_keys);

        $dictionary = array_filter($dictionary, function($item) use ($randomWord){
            if ($item["id"] != $randomWord["id"]){
                return true;
            } else {
                return false;
            }
        });

        shuffle($dictionary);

        $additionalChoice = array_slice($dictionary, 0, 3);
        $additionalChoice = array_map(function($item) use ($lang_keys){
            return $item[$lang_keys[1]];
        }, $additionalChoice);

        array_push($additionalChoice, $randomWord[$lang_keys[1]]);

        shuffle($additionalChoice);

        $session['words'] = $words;

        $response = [
            "quizword" => $randomWord[$lang_keys[0]],
            "choice" => $additionalChoice,
            "state" => "QUIZ_QUESTION"
        ];

        $count = count($session['words']);

        if (!$count){
            unset(Yii::$app->session['words']);
        }

        return $response;
    }
}


