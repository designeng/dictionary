<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use yii\base\Request;
use api\modules\v1\models\Mistake;

class AnswerController extends Controller
{
    public function actionIndex()
    {   

        // var_dump(Yii::$app->request->get('var'));
        // echo "<br><br>";

        $session = Yii::$app->session;

        // $words = $session['words'];

        // shuffle($words);

        // $randomWord = array_shift($words);

        // $session['words'] = $words;

        // $count = count($session['words']);

        // if (!$count){
        //     unset(Yii::$app->session['words']);
        // }

        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        
        $mistakes = array();

        return $mistakes;
    }

    private function addPoint($response, $point, $word, $mistakes_count){
        return array_merge($response, ["point" => $point, "current_word" => $word, "mistakes" => $mistakes_count]);
    }

    public function actionCreate()
    {   
        $session = Yii::$app->session;
        $mistakes_count = $session["mistakes_count"];

        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $data = Yii::$app->request->post();
        
        $answer_lang = "ERROR";

        $value = $data['value'];
        $value = trim($value[0]);

        if (!preg_match('/[^A-Za-z]/', $value )){
            $origin_lang = "ru";
            $answer_lang = "en";
        } else if (!preg_match('/[^А-Я,а-я]/', $value )){
            $origin_lang = "en";
            $answer_lang = "ru";
        }

        if ($answer_lang == "ERROR"){
            $response = ["errors" => "NOT VALID ANSWER VALUE"];
            return $response;
        } else {
            $response = ["origin_lang" => $origin_lang];
            $current_word = $session["current_word"];

            if ($current_word[$origin_lang] != $value){
                $mistake = new Mistake();
                $mistake->word_id = $current_word["id"];
                $mistake->lang = $origin_lang;
                $mistake->value = $value;
                $mistake->save();

                $mistakes_count++;
                $session["mistakes_count"] = $mistakes_count;

                $response =  $this->addPoint($response, 0, $current_word, $mistakes_count);

                // quiz is over, if {3} mistakes occured
                if ($mistakes_count >= 3){
                    $session->close();
                }
            } else {
                $response =  $this->addPoint($response, 1, $current_word, $mistakes_count);
            }
            
            return $response;
        }
    }
}


