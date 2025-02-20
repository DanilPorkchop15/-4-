-- Практическая работа №13
-- Создание триггеров для таблицы в MySQL

-- Задание 1:
-- Отредактировать связи между таблицами Продавцы – Заказы, Заказчики_физ.лица – Заказы и Заказчики_юр.лица – Заказы.
-- Сделать, чтобы удаление и обновление данных проходило каскадно.

ALTER TABLE orders
    DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders
    DROP FOREIGN KEY orders_ibfk_2;
ALTER TABLE orders
    DROP FOREIGN KEY orders_ibfk_3;

ALTER TABLE orders
    ADD CONSTRAINT fk_salespeople
        FOREIGN KEY (id_s) REFERENCES salespeople (id_s)
            ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders
    ADD CONSTRAINT fk_customers_fiz
        FOREIGN KEY (id_cf) REFERENCES customers_fiz (id_cf)
            ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders
    ADD CONSTRAINT fk_customers_yur
        FOREIGN KEY (id_cy) REFERENCES customers_yur (id_cy)
            ON DELETE CASCADE ON UPDATE CASCADE;


-- Задание 2:
-- Написать триггер на внесение в базу данных нового Заказчика физ.лица, которому автоматически будет присваиваться Заказ,
-- который будет обслуживать Продавец ИП Ветров.

DELIMITER //
CREATE TRIGGER after_customers_fiz_insert
    AFTER INSERT
    ON customers_fiz
    FOR EACH ROW
BEGIN
    DECLARE seller_id INT;

    SELECT id_s
    INTO seller_id
    FROM salespeople
    WHERE snazv = 'ИП Ветров';

    INSERT INTO orders (id_z, amt, dostavka, odate, id_s, id_cf, id_cy)
    VALUES (NEW.id_cf + 1000, 500.00, 50.00, CURDATE(), seller_id, NEW.id_cf, NULL);
END //
DELIMITER ;


-- Задание 3:
-- Создать триггер на удаление продавца, который предварительно перепишет его заказы на продавца ИП Семёнов.

-- Добавление нового продавца ИП Петров
INSERT INTO salespeople (id_s, snazv, city, tel, naprav, comm, id_vs)
VALUES (6, 'ИП Петров', 'Азов', '8-900-600-60-60', 'строй.материалы', 0.10, 1);

-- Оформление заказа 4022 на ИП Петров
INSERT INTO orders (id_z, amt, dostavka, odate, id_s, id_cf, id_cy)
VALUES (4022, 1000.00, 100.00, CURDATE(), 6, 4, NULL);

-- Триггер на удаление продавца
DELIMITER //
CREATE TRIGGER before_salespeople_delete
    BEFORE DELETE
    ON salespeople
    FOR EACH ROW
BEGIN
    DECLARE new_seller_id INT;

    SELECT id_s
    INTO new_seller_id
    FROM salespeople
    WHERE snazv = 'ИП Семёнов';

    UPDATE orders
    SET id_s = new_seller_id
    WHERE id_s = OLD.id_s;
END //
DELIMITER ;

-- Удаление продавца ИП Петров
DELETE
FROM salespeople
WHERE id_s = 6;


-- Задание 4:
-- Создать триггер на изменение стоимости заказа в таблице Заказы таким образом, что при изменении комиссионных у продавца,
-- стоимость заказа должна пересчитываться автоматически.

DELIMITER //
CREATE TRIGGER after_salespeople_update
    AFTER UPDATE
    ON salespeople
    FOR EACH ROW
BEGIN
    UPDATE orders
    SET amt = amt * (1 + NEW.comm - OLD.comm)
    WHERE id_s = NEW.id_s;
END //
DELIMITER ;


-- Задание 5:
-- Выполнить задания из практической работы 5.1, 5.2 – если вы их ранее не сделали.

-- Задание 5.1:
-- Добавьте столбец `vozrast` в таблицу `customers_fiz` и триггер для автоматического расчета возраста при вставке или обновлении.

ALTER TABLE customers_fiz
    ADD COLUMN vozrast INT;

DELIMITER //
CREATE TRIGGER calculate_age
    BEFORE INSERT
    ON customers_fiz
    FOR EACH ROW
BEGIN
    SET NEW.vozrast = TIMESTAMPDIFF(YEAR, NEW.gr, CURDATE());
END //
DELIMITER ;


-- Задание 5.2:
-- Добавьте столбец `status` в таблицу `customers_yur` и триггер для автоматического определения статуса на основе рейтинга.

ALTER TABLE customers_yur
    ADD COLUMN status VARCHAR(10) DEFAULT 'низкий';

DELIMITER //
CREATE TRIGGER set_status
    BEFORE INSERT
    ON customers_yur
    FOR EACH ROW
BEGIN
    IF NEW.rating BETWEEN 100 AND 200 THEN
        SET NEW.status = 'низкий';
    ELSEIF NEW.rating BETWEEN 201 AND 400 THEN
        SET NEW.status = 'средний';
    ELSEIF NEW.rating BETWEEN 401 AND 500 THEN
        SET NEW.status = 'высокий';
    END IF;
END //
DELIMITER ;