<?php

namespace app\controllers;

use Yii;
use yii\web\Session;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;
use app\models\LoginForm;
use app\models\ContactForm;

use app\models\Russian;
use app\models\English;

class SiteController extends Controller
{   

    public $russian = array();
    public $english = array();

    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    public function actionIndex()
    {
        return $this->render('index');
    }

    public function actionLogin()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            return $this->goBack();
        } else {
            return $this->render('login', [
                'model' => $model,
            ]);
        }
    }

    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    public function actionContact()
    {
        $model = new ContactForm();
        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        } else {
            return $this->render('contact', [
                'model' => $model,
            ]);
        }
    }

    public function actionAbout()
    {   
        var_dump($this->english);

        return $this->render('about');
    }

    public function init()
    {   
    }

    public function actionQuiz()
    {
        echo "actionQuiz";
        echo "<br>";

        $session = new Session;
        $session->open();

        $this->russian = Russian::find()
            ->asArray()
            ->all();
        $this->english = English::find()
            ->asArray()
            ->all();

        Yii::$app->session['russian'] = $this->russian;
        Yii::$app->session['english'] = $this->english;

        var_dump(Yii::$app->session);

        echo(Yii::$app->session['russian'][0]["id"]);
        echo "<br>";
        echo(Yii::$app->session['english'][0]["id"]);

        foreach (Yii::$app->session as $key => $value) {
            var_dump($value);
        }
    }
}
