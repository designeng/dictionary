##One-Page Application "Dictionary Quiz"
================================

##Установка приложения
-------------




Допустим, приложение установлено в директорию dictionary в htdocs сервера Apache (номер порта по умолчанию 80). Откройте страницу в браузере
~~~
http://127.0.0.1:[номер-порта]/dictionary/web/#/quiz
~~~





Now you should be able to access the application through the following URL, assuming `basic` is the directory
directly under the Web root.

~~~
http://localhost/basic/web/
~~~


CONFIGURATION
-------------

### Database

Edit the file `config/db.php` with real data, for example:

```php
return [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=localhost;dbname=yii2basic',
    'username' => 'root',
    'password' => '1234',
    'charset' => 'utf8',
];
```

**NOTE:** Yii won't create the database for you, this has to be done manually before you can access it.

Also check and edit the other files in the `config/` directory to customize your application.
