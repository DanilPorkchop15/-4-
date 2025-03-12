-- Создание базы данных
# CREATE DATABASE torgash_kostin;
USE torgash_kostin;

-- Таблица 1: Вид собственности (vids)
CREATE TABLE vids (
                      id_vs INT PRIMARY KEY AUTO_INCREMENT,
                      abr VARCHAR(10) NOT NULL,
                      name VARCHAR(100) NOT NULL
);

-- Вставка данных в таблицу vids
INSERT INTO vids (id_vs, abr, name) VALUES
                                        (1, 'ИП', 'Индивидуальный предприниматель'),
                                        (2, 'ООО', 'Общество с ограниченной ответственностью'),
                                        (3, 'ПАО', 'Публичное акционерное общество'),
                                        (4, 'НАО', 'Непубличное акционерное общество'),
                                        (5, 'ПК', 'Производственный кооператив');

-- Таблица 2: Продавцы (salespeople)
CREATE TABLE salespeople (
                             id_s INT PRIMARY KEY AUTO_INCREMENT,
                             snazv VARCHAR(100) NOT NULL,
                             city VARCHAR(50) NOT NULL,
                             tel VARCHAR(20) NOT NULL,
                             naprav VARCHAR(50) NOT NULL,
                             comm DECIMAL(4,2) CHECK (comm >= 0.10 AND comm <= 0.20),
                             id_vs INT,
                             FOREIGN KEY (id_vs) REFERENCES vids(id_vs)
);

-- Вставка данных в таблицу salespeople
INSERT INTO salespeople (id_s, snazv, city, tel, naprav, comm, id_vs) VALUES
                                                                          (1, 'ИП Ветров', 'Казань', '8-900-375-15-65', 'кондитерские изделия', 0.12, 1),
                                                                          (2, 'ООО Монтаж', 'Нижний Новгород', '+7 (831) 224-16-16', 'трикотажная продукция', 0.13, 2),
                                                                          (3, 'ООО СтройМаркт', 'Казань', '+7 (432) 115-66-66', 'кондитерские изделия', 0.11, 2),
                                                                          (4, 'ИП Костин', 'Новочеркасск', '8-938-715-63-28', 'кондитерские изделия', 0.15, 1),
                                                                          (5, 'ИП Семёнов', 'Ростов-на-Дону', '8-960-368-58-96', 'строй.материалы', 0.10, 1);


-- Таблица 3: Скидки (skid)
CREATE TABLE skid (
                      id_sk INT PRIMARY KEY AUTO_INCREMENT,
                      skid INT NOT NULL,
                      uslovie VARCHAR(100) NOT NULL
);

-- Вставка данных в таблицу skid
INSERT INTO skid (id_sk, skid, uslovie) VALUES
                                            (1, 10, 'Общая стоимость заказов больше 1500 руб'),
                                            (2, 15, 'Общая стоимость заказов больше 3000 руб'),
                                            (3, 20, 'Общая стоимость заказов больше 5000 руб');


-- Таблица 4: Заказчики физ.лица (customers_fiz)
CREATE TABLE customers_fiz (https://lichess.org/wngfLs59
                               id_cf INT PRIMARY KEY AUTO_INCREMENT,
                               name VARCHAR(100) NOT NULL,
                               city VARCHAR(50) NOT NULL,
                               pol CHAR(1) CHECK (pol IN ('м', 'ж')) NOT NULL,
                               gr DATE NOT NULL,
                               skidka INT DEFAULT NULL,
    FOREIGN KEY (skidka) REFERENCES skid(id_sk)
);

-- Триггер для проверки возраста заказчика
DELIMITER $$

CREATE TRIGGER check_age_before_insert BEFORE INSERT ON customers_fiz
    FOR EACH ROW
BEGIN
    IF DATEDIFF(CURDATE(), NEW.gr) / 365 < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Заказчик должен быть старше 18 лет';
    END IF;
END$$

CREATE TRIGGER check_age_before_update BEFORE UPDATE ON customers_fiz
    FOR EACH ROW
BEGIN
    IF DATEDIFF(CURDATE(), NEW.gr) / 365 < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Заказчик должен быть старше 18 лет';
    END IF;
END$$

DELIMITER ;
-- Вставка данных в таблицу customers_fiz
INSERT INTO customers_fiz (id_cf, name, city, pol, gr) VALUES
                                                           (1, 'Астахов И.И.', 'Казань', 'м', '1997-01-02'),
                                                           (2, 'Зверев С.Н.', 'Калуга', 'м', '1987-09-12'),
                                                           (3, 'Янкин В.И.', 'Нижний Новгород', 'м', '1997-05-13'),
                                                           (4, 'Борн А.В.', 'Брянск', 'м', '1990-04-18'),
                                                           (5, 'Гришина П.П.', 'Казань', 'ж', '1991-07-21'),
                                                           (6, 'Свиридова А.Г.', 'Нижний Новгород', 'ж', '2004-08-25'),
                                                           (7, 'Паршин Р.Р.', 'Калуга', 'м', '1997-08-28');

-- Таблица 5: Заказчики юр.лица (customers_yur)
CREATE TABLE customers_yur (
                               id_cy INT PRIMARY KEY AUTO_INCREMENT,
                               ynazv VARCHAR(100) NOT NULL,
                               city VARCHAR(50) NOT NULL,
                               rating INT DEFAULT 100 CHECK (rating >= 100 AND rating <= 500),
                               id_vs INT DEFAULT 2,
                               FOREIGN KEY (id_vs) REFERENCES vids(id_vs)
);

-- Вставка данных в таблицу customers_yur
INSERT INTO customers_yur (id_cy, ynazv, city, rating, id_vs) VALUES
                                                                  (1, 'OOO Алые паруса', 'Липецк', 100, 2),
                                                                  (2, 'OOO Южный ветер', 'Ростов-на-Дону', 200, 2),
                                                                  (3, 'OOO СтройИнвест', 'Самара', 200, 2),
                                                                  (4, 'ПАО Курочка', 'Белгород', 300, 3),
                                                                  (5, 'ПАО Нива', 'Липецк', 100, 3),
                                                                  (6, 'НАО Атлант', 'Самара', 300, 4),
                                                                  (7, 'OOO Канцлер', 'Ростов-на-Дону', 100, 2);

-- Таблица 6: Заказы (orders)
CREATE TABLE orders (
                        id_z INT PRIMARY KEY,
                        amt DECIMAL(10,2) NOT NULL,
                        dostavka DECIMAL(10,2),
                        odate DATE NOT NULL,
                        id_s INT NOT NULL,
                        id_cf INT,
                        id_cy INT,
                        FOREIGN KEY (id_s) REFERENCES salespeople(id_s),
                        FOREIGN KEY (id_cf) REFERENCES customers_fiz(id_cf),
                        FOREIGN KEY (id_cy) REFERENCES customers_yur(id_cy),
                        CHECK (amt <= 11000 OR dostavka IS NULL)
);

-- Вставка данных в таблицу orders
INSERT INTO orders (id_z, amt, dostavka, odate, id_s, id_cf, id_cy) VALUES
                                                                        (1, 18.69, 80, '2023-03-10', 1, 3, NULL),
                                                                        (2, 767.19, 50, '2023-03-10', 1, 1, NULL),
                                                                        (3, 1900.10, 150, '2023-03-10', 4, 7, NULL),
                                                                        (4, 5160.45, 200, '2023-03-10', 2, NULL, 1),
                                                                        (5, 1098.16, 100, '2023-03-10', 5, 5, NULL),
                                                                        (6, 1713.23, 100, '2023-04-10', 3, 2, NULL),
                                                                        (7, 75.75, 80, '2023-04-10', 2, 4, NULL),
                                                                        (8, 4723.00, 180, '2023-05-10', 1, NULL, 2),
                                                                        (9, 1309.95, 100, '2023-06-10', 2, 4, NULL),
                                                                        (10, 9891.88, 400, '2023-06-10', 1, NULL, 3),
                                                                        (11, 12135.18, NULL, '2023-09-15', 1, NULL, 7),
                                                                        (12, 3700, 150, '2023-10-02', 2, NULL, 4),
                                                                        (13, 588.58, 100, '2023-10-12', 1, 1, NULL),
                                                                        (14, 2750, 150, '2023-10-25', 3, 4, NULL),
                                                                        (15, 3488.25, 250, '2023-11-01', 2, NULL, 5),
                                                                        (16, 1960.23, 120, '2023-11-15', 4, 6, NULL),
                                                                        (17, 15800, NULL, '2023-12-20', 5, NULL, 6),
                                                                        (18, 17250.20, NULL, '2024-01-10', 5, NULL, 7),
                                                                        (19, 23600.50, NULL, '2024-01-12', 4, NULL, 2),
                                                                        (20, 1150, 80, '2024-01-15', 3, 6, NULL),
                                                                        (21, 2200, 80, '2024-01-15', 3, 6, NULL);
