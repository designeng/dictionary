<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use yii\base\Request;
use api\modules\v1\models\Mistake;
use api\modules\v1\models\User;
use api\modules\v1\controllers\UserController;

class AnswerController extends Controller
{

    private function updateResponse($response, $array){
        return array_merge($response, $array);
    }

    public function actionCreate()
    {   
        $session = Yii::$app->session;
        $mistakes_count = $session["mistakes_count"];
        $user_score = $session["user_score"];
        $point = 0;

        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $data = Yii::$app->request->post();
        
        $answer_lang = "ERROR";

        $value = $data['value'];
        $value = trim($value);

        if (preg_match('/[^A-Za-z]/', $value )){
            $origin_lang = "ru";
            $answer_lang = "en";
        } else if (preg_match('/[^А-Я,а-я]/', $value )){
            $origin_lang = "en";
            $answer_lang = "ru";
        }

        if ($answer_lang == "ERROR"){
            $response = ["error" => "NOT_VALID_ANSWER_VALUE", "your_answer" => $value];
            return $response;
        } else {
            $response = [];
            $current_word = $session["current_word"];

            if ($current_word[$origin_lang] != $value){
                $mistake = new Mistake();
                $mistake->word_id = $current_word["id"];
                $mistake->lang = $origin_lang;
                $mistake->value = $value;
                $mistake->save();

                $mistakes_count++;
                $session["mistakes_count"] = $mistakes_count;

                // quiz is over, if {3} mistakes occured
                if ($mistakes_count == 3){
                    UserController::saveCurrentUserResult();
                    $response = $this->updateResponse($response, ["state" => "QUIZ_END_WITH_MISTAKES"]);
                }
            } else {
                $point = 1;
                ++$user_score;
                $session["user_score"] = $user_score;
            }

            $response =  $this->updateResponse($response, ["point" => $point, "user_score" => $user_score, "mistakes_count" => $mistakes_count]);
            return $response;
        }
    }
}


