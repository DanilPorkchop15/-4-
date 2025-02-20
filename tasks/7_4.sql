-- 1. Вывести стоимость и дату заказа, отсортированные по временам года
CREATE VIEW v7_4_1 AS
SELECT amt,
       odate,
       CASE
           WHEN MONTH(odate) IN (12, 1, 2) THEN 'Зима'
           WHEN MONTH(odate) IN (3, 4, 5) THEN 'Весна'
           WHEN MONTH(odate) IN (6, 7, 8) THEN 'Лето'
           WHEN MONTH(odate) IN (9, 10, 11) THEN 'Осень'
           END AS season
FROM orders
ORDER BY season;
SELECT *
FROM v7_4_1;

-- 2. Показать имена физ.лица и название юр.лица, которые оформили больше одного заказа
CREATE VIEW v7_4_2 AS
SELECT IF(cf.id_cf IS NOT NULL, cf.name, NULL)  AS fiz_name,
       IF(cy.id_cy IS NOT NULL, cy.ynazv, NULL) AS yur_name,
       COUNT(*)                                 AS order_count
FROM orders o
         LEFT JOIN customers_fiz cf ON o.id_cf = cf.id_cf
         LEFT JOIN customers_yur cy ON o.id_cy = cy.id_cy
GROUP BY cf.id_cf, cy.id_cy
HAVING order_count > 1
ORDER BY fiz_name, yur_name;
SELECT *
FROM v7_4_2;

-- 3. Показать продавцов, у которых комиссионные выше, чем у продавцов из Казани
CREATE VIEW v7_4_3 AS
SELECT s1.snazv, s1.comm
FROM salespeople s1
WHERE s1.comm > ALL (SELECT s2.comm
                     FROM salespeople s2
                     WHERE s2.city = 'Казань');
SELECT *
FROM v7_4_3;

-- 4. Показать номера и стоимость заказов, которые дороже общей стоимости заказов за 10.03.2023
CREATE VIEW v7_4_4 AS
SELECT id_z, amt
FROM orders
WHERE amt > (SELECT SUM(amt)
             FROM orders
             WHERE odate = '2023-03-10');
SELECT *
FROM v7_4_4;

-- 5. Показать город юр.лиц с максимальным суммарным рейтингом
CREATE VIEW v7_4_5 AS
SELECT city, SUM(rating) AS total_rating
FROM customers_yur
GROUP BY city
ORDER BY total_rating DESC
LIMIT 1;
SELECT *
FROM v7_4_5;

-- 6. Показать заказы юр.лиц из города с максимальным суммарным рейтингом
CREATE VIEW v7_4_6 AS
SELECT o.id_z, o.amt, cy.city
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
WHERE cy.city = (SELECT city
                 FROM customers_yur
                 GROUP BY city
                 ORDER BY SUM(rating) DESC
                 LIMIT 1);
SELECT *
FROM v7_4_6;

-- 7. Показать название юр.лица и общую стоимость его заказов из города с максимальным суммарным рейтингом
CREATE VIEW v7_4_7 AS
SELECT cy.ynazv, SUM(o.amt) AS total_amount, cy.city
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
WHERE cy.city = (SELECT city
                 FROM customers_yur
                 GROUP BY city
                 ORDER BY SUM(rating) DESC
                 LIMIT 1)
GROUP BY cy.id_cy;
SELECT *
FROM v7_4_7;

-- 8. Показать продавца с самой большой суммарной стоимостью заказов
CREATE VIEW v7_4_8 AS
SELECT s.snazv, SUM(o.amt) AS total_amount
FROM orders o
         JOIN salespeople s ON o.id_s = s.id_s
GROUP BY s.id_s
ORDER BY total_amount DESC
LIMIT 1;
SELECT *
FROM v7_4_8;

-- 9. Показать общую стоимость заказов в каждом городе физ.лиц, если она выше средней
CREATE VIEW v7_4_9 AS
SELECT cf.city, SUM(o.amt) AS total_amount
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf
GROUP BY cf.city
HAVING total_amount > (SELECT AVG(amt) FROM orders);
SELECT *
FROM v7_4_9;