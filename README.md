##One-Page Application "Dictionary Quiz"

##Установка приложения

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
5. Измените пароль для установки соединения с mysql-сервером в `config/db.php` (пароль по умолчанию root). 
6. В разработке проекта использовалась база данных с названием `dictionary`, в случае необходимости измените название базы данных в `config/db.php` в параметре `dsn`. 
7. Адрес хоста сервера mysql может быть изменен в случае необходимости в том же параметре `dsn`:
```php
return [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=localhost;dbname=dictionary',
    'username' => 'root',
    'password' => 'root',
    'charset' => 'utf8',
];
```
8. Для установки зависимостей клиентской части приложения нужно выполнить команду `bower install` в директории `client`. Для этого должна предварительно быть установлена `nodejs` и загрузчик пакетов для клиентской разработки `bower` (соответствующие инструкции на сайтах [nodejs](https://nodejs.org/) и [bower.io](http://bower.io/).
9. Измените baseUrl для в конфигурации requirejs на соответствующий параметрам установки:
```js
baseUrl: "/yii/dictionary/client/app/js"
```
Для этого можно работать с файлом `client/app/coffee/requireConfig.coffee` в режиме разработки. Должны быть установлены зависимости для grunt-задач и `grunt-cli` (соответствующие инструкции [здесь](http://gruntjs.com/getting-started) )
```
npm install
```
После чего 


Откройте страницу в браузере
~~~
http://127.0.0.1/dictionary/web/#/quiz
~~~
Браузер будет перенаправлен на "страницу" `http://127.0.0.1/dictionary/web/#/user`, с формой для регистрации пользователя, проходящего тест. После успешной регистрации на "странице" `http://127.0.0.1/dictionary/web/#/questions` начнется тест на знание словарных соответствий с со случайным выбором русского или английского слова из набора пар слов, внесенных в таблицу word. После прохождения теста результат будет выведен на "странице" `http://127.0.0.1/dictionary/web/#/result`. Система следит за состоянием приложения, в случае отсутствия регистрации пользователя страница `http://127.0.0.1/dictionary/web/#/questions` недоступна, происходит редирект на страницу с формой регистрации пользователя.

Будет предложено четыре варианта перевода, один из которых является правильным. После трех ошибок или после завершения 






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
