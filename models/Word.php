<?php

namespace app\models;
use yii\db\ActiveRecord;

/**
 * Word Model
 * @author Denis Savenok <denissavenok@gmail.com>
 */
class Word extends ActiveRecord
{
    public static function tableName()
    {
        return 'russian';
    }

    public static function primaryKey()
    {
        return ['id'];
    }

    public function rules()
    {
        return [
            [['value', 'translation'], 'required']
        ];
    }
}