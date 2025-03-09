-- Создание пользователя "admin" с паролем "admin"
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

-- Создание пользователя "oper" с паролем "oper"
CREATE USER 'oper'@'localhost' IDENTIFIED BY 'oper';

-- Создание пользователя "guest" без пароля
CREATE USER 'guest'@'localhost';



-- Предоставление всех прав на все таблицы
GRANT ALL PRIVILEGES ON torgash_kostin.* TO 'admin'@'localhost';

-- Обновление привилегий
FLUSH PRIVILEGES;



-- Предоставление прав на SELECT для указанных таблиц
GRANT SELECT ON torgash_kostin.salespeople TO 'guest'@'localhost';
GRANT SELECT ON torgash_kostin.customers_fiz TO 'guest'@'localhost';
GRANT SELECT ON torgash_kostin.customers_yur TO 'guest'@'localhost';
GRANT SELECT ON torgash_kostin.orders TO 'guest'@'localhost';

-- Обновление привилегий
FLUSH PRIVILEGES;




-- Только просмотр таблиц `vids` и `skid`
GRANT SELECT ON torgash_kostin.vids TO 'oper'@'localhost';
GRANT SELECT ON torgash_kostin.skid TO 'oper'@'localhost';

-- Просмотр и внесение данных в таблицы `salespeople`, `customers_fiz`, `customers_yur`, `orders`
GRANT SELECT, INSERT ON torgash_kostin.salespeople TO 'oper'@'localhost';
GRANT SELECT, INSERT ON torgash_kostin.customers_fiz TO 'oper'@'localhost';
GRANT SELECT, INSERT ON torgash_kostin.customers_yur TO 'oper'@'localhost';
GRANT SELECT, INSERT ON torgash_kostin.orders TO 'oper'@'localhost';

-- Обновление привилегий
FLUSH PRIVILEGES;



-- Просмотр прав администратора
SHOW GRANTS FOR 'admin'@'localhost';

-- Просмотр прав гостя
SHOW GRANTS FOR 'guest'@'localhost';

-- Просмотр прав оператора
SHOW GRANTS FOR 'oper'@'localhost';




-- Удаление администратора
DROP USER 'admin'@'localhost';

-- Удаление оператора
DROP USER 'oper'@'localhost';

-- Удаление гостя
DROP USER 'guest'@'localhost';


