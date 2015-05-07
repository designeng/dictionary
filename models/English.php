<?php

namespace app\models;
use yii\db\ActiveRecord;

/**
 * Word Model
 * @author Denis Savenok <denissavenok@gmail.com>
 */
class English extends ActiveRecord
{
    public static function tableName()
    {
        return 'english';
    }

    public static function primaryKey()
    {
        return ['id'];
    }

    public function rules()
    {
        return [
            [['value'], 'required']
        ];
    }
}