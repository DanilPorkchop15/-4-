-- 1. Покажите, сколько продавцов в каждом городе
CREATE VIEW v7_2_1 AS
SELECT city, COUNT(*) AS count_salespeople
FROM salespeople
GROUP BY city;

SELECT * FROM v7_2_1;

-- 2. Покажите самого молодого мужчину и женщину физ.лицо
CREATE VIEW v7_2_2 AS
SELECT pol, MIN(gr) AS youngest_birthdate, name
FROM customers_fiz
GROUP BY pol;

SELECT * FROM v7_2_2;

-- 3. Покажите самый дорогой заказ каждого юр.лица
CREATE VIEW v7_2_3 AS
SELECT orders.id_cy, customers_yur.ynazv, MAX(orders.amt) AS max_order_amount
FROM orders
         JOIN customers_yur ON orders.id_cy = customers_yur.id_cy
GROUP BY orders.id_cy, customers_yur.ynazv;

SELECT * FROM v7_2_3;

-- 4. Покажите количество физ.лиц и юр.лиц, оформивших заказы в каждый день
CREATE VIEW v7_2_4 AS
SELECT odate,
       COUNT(DISTINCT id_cf) AS 'Количество физ.лиц',
        COUNT(DISTINCT id_cy) AS 'Количество юр.лиц'
FROM orders
GROUP BY odate
ORDER BY 'Количество физ.лиц', 'Количество юр.лиц';

SELECT * FROM v7_2_4;

-- 5. Покажите общую стоимость заказов за каждый день
CREATE VIEW v7_2_5 AS
SELECT odate, SUM(amt) AS total_amount
FROM orders
GROUP BY odate;

SELECT * FROM v7_2_5;

-- 6. Покажите число физ.лиц и юр.лиц, оформивших заказы в каждый день
CREATE VIEW v7_2_6 AS
SELECT odate,
       COUNT(DISTINCT id_cf) AS 'Число физ.лиц',
        COUNT(DISTINCT id_cy) AS 'Число юр.лиц'
FROM orders
GROUP BY odate
ORDER BY 'Число физ.лиц', 'Число юр.лиц';

SELECT * FROM v7_2_6;