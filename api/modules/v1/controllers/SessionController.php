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
        Yii::$app->session->destroy();
        Yii::$app->session->close();
        return array();
    }
}