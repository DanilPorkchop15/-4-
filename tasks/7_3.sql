-- 1. Покажите, сколько юр.лиц по каждому виду статуса
CREATE VIEW v7_3_1 AS
SELECT status, COUNT(*) AS count_yur
FROM customers_yur
GROUP BY status;
SELECT * FROM v7_3_1;

-- 2. Покажите физ.лица, у которых скидка ниже средней
CREATE VIEW v7_3_2 AS
SELECT * FROM customers_fiz
WHERE skidka IN (SELECT id_sk FROM skid WHERE skid < (SELECT AVG(skid) FROM skid));
SELECT * FROM v7_3_2;

-- 3. Покажите заказы, оформленные самой молодой компанией-продавцом
CREATE VIEW v7_3_3 AS
SELECT o.*, s.snazv, s.data_reg
FROM orders o
         JOIN salespeople s ON o.id_s = s.id_s
WHERE s.data_reg = (SELECT MAX(salespeople.data_reg) FROM salespeople);
SELECT * FROM v7_3_3;

-- 4. Покажите имя физ.лица, название продавца и сумму их сделки
CREATE VIEW v7_3_4 AS
SELECT cf.name AS fiz_name, s.snazv AS seller_name, o.amt, cf.city
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf
         JOIN salespeople s ON o.id_s = s.id_s
WHERE cf.city = s.city;
SELECT * FROM v7_3_4;

-- 5. Покажите стоимость заказа и его дату оформления для физ.лиц, родившихся после 2000 г.
CREATE VIEW v7_3_5 AS
SELECT o.amt, o.odate, cf.name, cf.gr
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf
WHERE cf.gr > '2000-01-01';
SELECT * FROM v7_3_5;

-- 6. Покажите стоимость заказа и его дату оформления для юр.лиц с рейтингом выше среднего
CREATE VIEW v7_3_6 AS
SELECT o.amt, o.odate, cy.ynazv, cy.rating
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
WHERE cy.rating > (SELECT AVG(rating) FROM customers_yur);
SELECT * FROM v7_3_6;

-- 7. Покажите общую стоимость всех заказов для каждого физ.лица и юр.лица
CREATE VIEW v7_3_7_fiz AS
SELECT cf.name AS fiz_name, NULL AS yur_name, SUM(o.amt) AS total_amount
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf
GROUP BY cf.id_cf;

CREATE VIEW v7_3_7_yur AS
SELECT NULL AS fiz_name, cy.ynazv AS yur_name, SUM(o.amt) AS total_amount
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
GROUP BY cy.id_cy;

-- Для просмотра результатов
SELECT * FROM v7_3_7_fiz
UNION ALL
SELECT * FROM v7_3_7_yur;

-- 8. Покажите самый дорогой заказ для каждого физ.лица и юр.лица
CREATE VIEW v7_3_8_fiz AS
SELECT cf.name AS fiz_name, NULL AS yur_name, MAX(o.amt) AS max_order
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf
GROUP BY cf.id_cf;

CREATE VIEW v7_3_8_yur AS
SELECT NULL AS fiz_name, cy.ynazv AS yur_name, MAX(o.amt) AS max_order
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
GROUP BY cy.id_cy;

-- Для просмотра результатов
SELECT * FROM v7_3_8_fiz
UNION ALL
SELECT * FROM v7_3_8_yur;

-- 9. Покажите продавцов, с каким видом собственности больше всего участвовали в заказах
CREATE VIEW v7_3_9 AS
SELECT s.snazv, v.name AS vid_sobstvennosti, COUNT(*) AS order_count
FROM orders o
         JOIN salespeople s ON o.id_s = s.id_s
         JOIN vids v ON s.id_vs = v.id_vs
GROUP BY s.id_s, v.name
ORDER BY order_count DESC
LIMIT 1;
SELECT * FROM v7_3_9;

-- 10. Покажите общую сумму всех заказов для каждого продавца, у которого эта сумма больше, чем сумма наибольшего заказа
CREATE VIEW v7_3_10 AS
SELECT s.snazv, SUM(o.amt) AS total_amount
FROM orders o
         JOIN salespeople s ON o.id_s = s.id_s
GROUP BY s.id_s
HAVING total_amount > (SELECT MAX(amt) FROM orders);
SELECT * FROM v7_3_10;