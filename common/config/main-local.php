<?php
return [
    'components' => [
        'db' => [
            'class' => 'yii\db\Connection',
            'dsn' => 'mysql:host=localhost;dbname=dictionary',
            'username' => 'root',
            'password' => 'root',
            'charset' => 'utf8',
        ]
    ],
];
