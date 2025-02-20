-- 1. Уникальные значения в столбце названия продавца
ALTER TABLE salespeople ADD CONSTRAINT unique_snazv UNIQUE (snazv);
-- 2. Добавление столбца `data_reg` с автоматической датой регистрации
ALTER TABLE salespeople ADD COLUMN data_reg DATE DEFAULT (CURRENT_DATE);

-- 3. Добавление столбца `vozrast` в таблицу `customers_fiz`
ALTER TABLE customers_fiz ADD COLUMN vozrast INT;

-- 4. Триггер для проверки возраста заказчика
DELIMITER $$

CREATE TRIGGER check_age_65_before_insert
BEFORE INSERT ON customers_fiz
FOR EACH ROW
BEGIN
    SET NEW.vozrast = TIMESTAMPDIFF(YEAR, NEW.gr, CURDATE());
    IF NEW.vozrast > 65 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Заказчик пенсионного возраста';
    END IF;
END$$

DELIMITER ;


# INSERT INTO customers_fiz (id_cf, name, city, pol, gr) VALUES (21, 'vev', 'veve', 'м', '1921-11-11');

-- 5. Добавление столбца `status` в таблицу `customers_yur`
ALTER TABLE customers_yur ADD COLUMN status VARCHAR(10) DEFAULT 'низкий';

-- 6. Триггер для автоматического определения статуса
DELIMITER $$

CREATE TRIGGER set_status_before_insert
BEFORE INSERT ON customers_yur
FOR EACH ROW
BEGIN
    IF NEW.rating BETWEEN 100 AND 200 THEN
        SET NEW.status = 'низкий';
    ELSEIF NEW.rating BETWEEN 201 AND 400 THEN
        SET NEW.status = 'средний';
    ELSEIF NEW.rating BETWEEN 401 AND 500 THEN
        SET NEW.status = 'высокий';
    END IF;
END$$

DELIMITER ;

# INSERT INTO customers_yur (id_cy, ynazv, city, rating) VALUES (21, 'veve', 'veve', 250);

-- 7. Возврат прежних названий таблиц и столбцов
# ALTER TABLE salespeople DROP CONSTRAINT unique_snazv;
# ALTER TABLE salespeople DROP COLUMN data_reg;
# ALTER TABLE customers_fiz DROP COLUMN vozrast;
# DROP TRIGGER IF EXISTS check_age_65_before_insert;
# ALTER TABLE customers_yur DROP COLUMN status;
# DROP TRIGGER IF EXISTS set_status_before_insert;