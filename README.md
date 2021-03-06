## Задача
[Документ с тестовым заданием](./Objective.docx)

## Запуск и установка
Все части приложения разделены на сервисы и помещены в Docker-контейнеры. Для разворачивания приложения на на хост системе должен быть установлен Docker (хоть Windows, хоть Linux). Чтобы все развернуть, достаточно набрать в консоле: ```docker-compose up -d```

Приложение будет доступно по адресу: http://localhost:8000

## Устройство
Содержимое всех контейнеров собирается из исходных кодов, находящихся в данном репозитарии.

### Контейнер sqlserver.
* Контейнер содержит в себе установленный SQL Server 2017.
* Пароль sa для БД ```MyStrong@Passw0rd```
* Сервер будет доступен на хосте по адресу localhost:14330
* Файлы данных SQL Server лежат в ```sql/data```.
* После старта, при отсутствии базы данных ```[TestData]```, будут выполнены скрипты из ```sql/scripts/sql```.
  * ```create.sql``` - создает базу данных
  * ```init.sql``` - содержит данные предоставленные в рамках ТЗ
  * ```step1.sql``` - содержит процедуру, созданную в рамках первого задания.
  * ```step2.sql``` - содержит таблицы и процедуры необходимые для второго задания.
  * ```step3.sql``` - содержит индексы, необходимые для оптимизации выолнения запросов.

### Контейнер alfaapi.
* Контейнер содержит собранное ```ASP.NET Core``` приложение, выполняюще роль API-сервера
* Исходный код API-сервера расположен в папке ```alfaapi```.

### Контейнер alfafront.
* Контейнер содержит образ ```nginx``` сервера.
* Во время сборки контейнера происходит билд ```nodejs``` приложения.
* Nginx раздает статику фронтэнда, а при отсутствии файла, запрос перенаправит в index.html. Таким образом, можно создать SPA со ссылками без якорей (#) и без SSR.
* Запросы начинающиеся со ```/api``` проксируются на API-сервер.
* Фронтэнд написан на ```Vue.js```.

## Комментарий, касаемо задания
Меня крайне обескуражила фраза в техническом задании:
> Реализовать систему распределения ролей

однако дальше:
> На стороне приложения можно только включать/выключать роли, получать текущие роли


Я совершенно не смог представить себе такую систему распределения ролей. Роли должны назначаться пользователям. Если есть пользователи, значит должна быть система авторизации. Совершенно не понятно, как пользователь может самому себе будет назначать эти роли.

Роль без пользователя я представить не смог, поэтому создал одного. Про авторизацию или страницу для заведения пользователей в ТЗ ничего не сказано, поэтому принял решение считать пользователя авторизованным, в API сервере ID пользователя захардкоден.


## Описание API
* [GET] /api/Role - Получить список доступных ролей
```json
[
	{
		"id": 1,
		"name": "Аналитик",
	},
	...
]
```

* [GET] /api/UserRoles - Получить список ролей пользователя
```json
[1,3,...]
```

* [PUT] /api/UserRoles - Установить роли для пользователя
```json
[2,3,...]
```

* [GET] /api/Report - Получить список возможных отчетов
```json
[
	{
		"id": 1,
		"name": "Популярные",
		"linkName": "popular"
	},
	...
]
```

* [GET] /api/GenerateReport/:id - Получить отчет с номером :id
```json
[
	{
		"id": 2,
		"name": "Товар 1",
		"cost": 255.0000,
		"buys": 6
	},
	...
]
```
