<?php

return [
    'id' => 'app-api',
    'basePath' => dirname(__DIR__),    
    'bootstrap' => [
        'log',
        'bootstrap'
    ],
    'modules' => [
        'v1' => [
            'basePath' => '@app/modules/v1',
            'class' => 'api\modules\v1\Module'
        ],
        'bootstrap' => [
            'basePath' => '@app/modules/v1',
            'class' => 'api\modules\v1\Bootstrap'
        ]
    ],
    'components' => [
        'session' => [
            'timeout' => 300
        ],
        'user' => [
            'identityClass' => 'common\models\User',
            'enableAutoLogin' => false,
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'request' => [
            'parsers' => [
                'application/json' => 'yii\web\JsonParser',
            ]
        ],
        'urlManager' => [
            'enablePrettyUrl' => true,
            'enableStrictParsing' => true,
            'showScriptName' => false,
            'rules' => [
                [
                    'class' => 'yii\rest\UrlRule', 
                    'controller' => 'v1/word',
                    'tokens' => [
                        '{id}' => '<id:\\w+>'
                    ]
                ],
                [
                    'class' => 'yii\rest\UrlRule', 
                    'controller' => 'v1/step',
                    'tokens' => [
                        '{id}' => '<id:\\w+>'
                    ]
                ],
                [
                    'class' => 'yii\rest\UrlRule', 
                    'controller' => 'v1/answer',
                    'tokens' => [
                        '{id}' => '<id:\\w+>'
                    ]
                ],
                [
                    'class' => 'yii\rest\UrlRule', 
                    'controller' => 'v1/state',
                    'tokens' => [
                        '{id}' => '<id:\\w+>'
                    ]
                ],
                [
                    'class' => 'yii\rest\UrlRule', 
                    'controller' => 'v1/session',
                    'tokens' => [
                        '{id}' => '<id:\\w+>'
                    ]
                ],
                'POST <controller:\w+>s' => '<controller>/create',
            ],        
        ]
    ]
];



