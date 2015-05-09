<?php

namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use Yii;

class User extends ActiveRecord
{
    public static function tableName()
    {   
        return 'user';
    }

    public static function primaryKey()
    {
        return ['id'];
    }
}