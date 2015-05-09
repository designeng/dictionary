<?php

namespace api\modules\v1\controllers;

use Yii;
use yii\rest\Controller;
use yii\base\Request;
use api\modules\v1\models\Mistake;

class SessionController extends Controller
{
    public function actionIndex()
    {   
        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $params = Yii::$app->request->get();
        $session = Yii::$app->session;
        $response = [];

        // add user score to response
        if($params && $params["score"]){
            $response = array_merge($response, ["user_score" => $session["user_score"]]);
        }

        // destroy session on default
        $session->destroy();
        $session->close();

        return $response;
    }

    public function actionCreate()
    {   
        $session = Yii::$app->session;

        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $data = Yii::$app->request->post();

        $username = $session["user_name"] = trim($data['username']);

        return ["registrationState" => "SUCCESS", "registeredUser" => $username];
    }
}