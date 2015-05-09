<?php

namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use Yii;

class Word extends ActiveRecord
{
    public static function tableName()
    {   
        return 'word';
    }

    public static function primaryKey()
    {
        return ['id'];
    }
}