<?php
namespace app\controllers;

use Yii;
use app\models\Quiz;
use yii\web\Controller;
use yii\web\NotFoundHttpException;

class QuizController extends Controller
{
    public function actionView($id)
    {
        $model = Quiz::findOne($id);
        if ($model === null) {
            throw new NotFoundHttpException;
        }

        return $this->render('view', [
            'model' => $model,
        ]);
    }

    public function actionCreate()
    {
        $data = Yii::$app->request->post();

        $id = explode(":", $data['id']);
        $value = explode(":", $data['value']);

        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $mistakes = array();
        array_push($mistakes, $value);
        array_push($mistakes, $id);
        return $mistakes;
    }
}