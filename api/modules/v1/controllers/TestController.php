<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use yii\base\Request;

class TestController extends Controller
{   

    public function actionIndex()
    {   
        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $session = Yii::$app->session;

        $words = $session['words'];
        if(!count($words)){
            return ["state"=> "QUIZ_END_WORDS"];
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

        $session['words'] = $words;

        $randomWord = [
            "id" => $randomWord["id"],
            "quizword" => $randomWord[$lang_keys[0]],
            "choice" => $additionalChoice,
            "state" => "QUIZ_QUESTION"
        ];

        $count = count($session['words']);

        if (!$count){
            unset(Yii::$app->session['words']);
        }

        return $randomWord;
    }
}


