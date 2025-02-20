-- 1. Покажите из каких городов физ.лица
CREATE VIEW v7_1_1 AS
SELECT DISTINCT city FROM customers_fiz;
SELECT * FROM v7_1_1;

-- 2. Покажите юр.лиц, которые зарегистрированы в Липецке
CREATE VIEW v7_1_2 AS
SELECT * FROM customers_yur WHERE city = 'Липецк';
SELECT * FROM v7_1_2;

-- 3. Покажите физ.лиц, не старше 30 лет
CREATE VIEW v7_1_3 AS
SELECT * FROM customers_fiz WHERE TIMESTAMPDIFF(YEAR, gr, CURDATE()) <= 30;
SELECT * FROM v7_1_3;

-- 4. Покажите юр.лиц с рейтингом 100 и 200
CREATE VIEW v7_1_4 AS
SELECT * FROM customers_yur WHERE rating IN (100, 200);
SELECT * FROM v7_1_4;

-- 5. Покажите заказы, оформленные осенью со стоимостью больше 3000
CREATE VIEW v7_1_5 AS
SELECT * FROM orders
WHERE (MONTH(odate) IN (9, 10, 11)) AND amt > 3000;
SELECT * FROM v7_1_5;

-- 6. Покажите физ.лиц с фамилиями из первой половины алфавита
CREATE VIEW v7_1_6 AS
SELECT * FROM customers_fiz
WHERE name REGEXP '^[А-М]';
SELECT * FROM v7_1_6;

-- 7. Покажите виды собственности, в полном названии которых фигурирует слово «общество»
CREATE VIEW v7_1_7 AS
SELECT * FROM vids
WHERE name LIKE '%общество%';
SELECT * FROM v7_1_7;

-- 8. Покажите заказы, у которых бесплатная доставка
CREATE VIEW v7_1_8 AS
SELECT * FROM orders
WHERE dostavka = 0 OR dostavka IS NULL;
SELECT * FROM v7_1_8;

-- 9. Покажите количество юр.лиц из Ростова-на-Дону
CREATE VIEW v7_1_9 AS
SELECT COUNT(*) AS count_yur_rostov
FROM customers_yur
WHERE city = 'Ростов-на-Дону';
SELECT * FROM v7_1_9;

-- 10. Покажите, на какую сумму были оформлены все заказы зимой
CREATE VIEW v7_1_10 AS
SELECT SUM(amt) AS total_winter_orders
FROM orders
WHERE MONTH(odate) IN (12, 1, 2);
SELECT * FROM v7_1_10;

-- 11. Покажите среднюю стоимость доставки летом
CREATE VIEW v7_1_11 AS
SELECT AVG(dostavka) AS avg_dostavka_summer
FROM orders
WHERE MONTH(odate) IN (6, 7, 8);
SELECT * FROM v7_1_11;

-- 12. Покажите самого молодого заказчика физ.лица из Казани
CREATE VIEW v7_1_12 AS
SELECT * FROM customers_fiz
WHERE city = 'Казань'
ORDER BY gr DESC
LIMIT 1;
SELECT * FROM v7_1_12;

-- 13. Покажите итоговую стоимость заказа с учётом доставки весной, при распространении 5% скидки в это время года
CREATE VIEW v7_1_13 AS
SELECT id_z, amt, dostavka,
       (amt + IFNULL(dostavka, 0)) * 0.95 AS 'Итоговая стоимость заказа'
FROM orders
WHERE MONTH(odate) IN (3, 4, 5);
SELECT * FROM v7_1_13;

-- 14. Покажите, какой будет стоимость заказа при акции «10% скидка при оформлении заказа свыше 20000»
CREATE VIEW v7_1_14 AS
SELECT id_z, amt,
       IF(amt > 20000, amt * 0.9, amt) AS 'Стоимость заказа с 10% скидкой'
FROM orders;
SELECT * FROM v7_1_14;

-- 15. Покажите сколько видов собственности, в полном названии которых фигурирует слово «общество»
CREATE VIEW v7_1_15 AS
SELECT COUNT(*) AS count_vids_obshestvo
FROM vids
WHERE name LIKE '%общество%';
SELECT * FROM v7_1_15;

-- 16. Покажите самый дорогой заказ каждого юр.лица
CREATE VIEW v7_1_16 AS
SELECT orders.id_cy, customers_yur.ynazv, MAX(orders.amt) AS max_order_amount
FROM orders
         JOIN customers_yur ON orders.id_cy = customers_yur.id_cy
GROUP BY orders.id_cy, customers_yur.ynazv;
SELECT * FROM v7_1_16;
