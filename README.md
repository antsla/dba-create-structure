Поднять сервис db_va можно командой:

`docker-compose up db_va`

Для подключения к БД используйте команду:

`docker-compose exec db_va mysql -u root blog`

Опиисание проекта:

schema.jpeg - схема база данных.
description.md - описание всей базы данных (таблицы, индексы, комментарии).

Скрипты:

init.sql - скрипт инициализации базы данных.
triggers_views.sql - создание триггеров и представлений.
procedures.sql - создание хранимых процедур.
seeds.sql - файл для сидирования базы данных.

selects.sql - простейшие выборки из базы данных.