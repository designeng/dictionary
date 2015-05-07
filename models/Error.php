<?php

namespace app\models;

use yii\db\ActiveRecord;

class Error extends ActiveRecord
{
    public static function tableName()
    {
        return 'error';
    }

    public function getError()
    {
        
    }
}