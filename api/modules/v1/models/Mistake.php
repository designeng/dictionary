<?php

namespace api\modules\v1\models;

use yii\db\ActiveRecord;
use Yii;
use yii\web\Session;

class Mistake extends ActiveRecord
{
    public static function tableName()
    {   
        return 'mistake';
    }

    public static function primaryKey()
    {
        return ['id'];
    }

    public function rules()
    {
        return [
            [['word_id', 'value'], 'required']
        ];
    }
}