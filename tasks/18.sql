-- 1)	Сделать резервную копию учебной базы данных в обычном формате с именем dump_<ваша фамилия>
-- mysqldump -h 127.0.0.1 -P 3306 -v -u root -p torgash_kostin > /tmp/mysql/dump_kostin.sql

-- 2)	Сделать резервную копию учебной базы данных с именем dump_arh_<ваша фамилия> в архивном формате с подробным выводом информации на экран
-- mysqldump -h 127.0.0.1 -P 3306 -v -u root -p torgash_kostin | gzip > /tmp/dump_arh_kostin.sql.gz
-- gunzip /tmp/dump_arh_kostin.sql.gz

-- 3)	Создать резервную копию таблицы «Заказы» с именем dump_orders_<ваша фамилия>
-- mysqldump -h 127.0.0.1 -P 3306 -v -u root -p torgash_kostin orders > /tmp/dump_orders_kostin.sql

-- 4)	Сделать резервную копию прав доступа учебной базы данных
-- mysqldump -h 127.0.0.1 -P 3306 -v -u root -p mysql user > /tmp/mysql_user_kostin.sql

-- 5)	Сделать резервную копию учебной базы данных, игнорируя таблицу «Вид собственности», копию назвать dump_not_vids_<ваша фамилия>
-- mysqldump -h 127.0.0.1 -P 3306 -v -u root -p torgash_kostin --ignore-table=torgash_kostin.vids > /tmp/dump_not_vids_kostin.sql

-- 6)	Восстановить базу данных из резервной копии
-- mysql -h 127.0.0.1 -P 3306 -u root -p -e "CREATE DATABASE restored_db;"
-- mysql -h 127.0.0.1 -P 3306 -v -u root -p restored_db < /tmp/dump_kostin.sql