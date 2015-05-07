<?php

namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use Yii;
use yii\web\Session;

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

    // public function rules()
    // {
    //     return [
    //         [['english', 'russian'], 'required']
    //     ];
    // }
}