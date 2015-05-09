##One-Page Application "Dictionary Quiz"
================================

##Установка приложения
-------------
1. Скачайте репозиторий
~~~
git clone https://github.com/designeng/dictionary.git
~~~
2. Скопируйте проект в соответствующую директорию на сервере.
3. Проверьте, соответствует ли сервер необходимым требованиям для работы yii-фреймворка, запустив скрипт (здесь и ниже предполагается, что приложение установлено в директорию dictionary на localhost, с номером порта по умолчанию 80)
~~~
http://127.0.0.1/dictionary/requirements.php
~~~

3. Создайте базу данных, обеспечивающую работу приложения.
4. Для создания таблиц и заполнения их fake-данными запустите скрипт sql/init.sql на созданной базе данных.

Откройте страницу в браузере
~~~
http://127.0.0.1/dictionary/web/#/quiz
~~~





Работа one-page приложения протестирована в браузерах Chrome (v42), Safari (v7.0), Firefox (v37)


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
