-- 1. Покажите продавцов из одного города
CREATE VIEW v10_1 AS
SELECT a.snazv AS seller1, b.snazv AS seller2, a.city
FROM salespeople a
         JOIN salespeople b ON a.city = b.city AND a.id_s < b.id_s;
SELECT * FROM v10_1;

-- 2. Покажите заказчиков физ.лиц, которые одногодки
CREATE VIEW v10_2 AS
SELECT a.name AS customer1, b.name AS customer2, a.gr
FROM customers_fiz a
         JOIN customers_fiz b ON a.gr = b.gr AND a.id_cf < b.id_cf;
SELECT * FROM v10_2;

-- 3. Покажите год с самой высокой средней стоимостью заказа
CREATE VIEW v10_3 AS
SELECT YEAR(odate) AS year, AVG(amt + IFNULL(dostavka, 0)) AS avg_total
FROM orders
GROUP BY YEAR(odate)
ORDER BY avg_total DESC
LIMIT 1;
SELECT * FROM v10_3;

-- 4. Покажите заказчиков юр.лиц с одинаковым рейтингом
CREATE VIEW v10_4 AS
SELECT a.ynazv AS company1, b.ynazv AS company2, a.city, a.rating
FROM customers_yur a
         JOIN customers_yur b ON a.rating = b.rating AND a.id_cy < b.id_cy;
SELECT * FROM v10_4;

-- 5. Покажите заказчиков юр.лиц с рейтингом как у ООО Канцлер
CREATE VIEW v10_5 AS
SELECT ynazv, city
FROM customers_yur
WHERE rating = (SELECT rating FROM customers_yur WHERE ynazv = 'OOO Канцлер');
SELECT * FROM v10_5;

-- 6. Покажите дату и стоимость заказов у одинаковых заказчиков юр.лиц (???)
CREATE VIEW v10_6 AS
SELECT cy.ynazv, a.odate, a.amt
FROM orders a
         JOIN orders b ON a.id_cy = b.id_cy AND a.id_z < b.id_z
         JOIN customers_yur cy on cy.id_cy = a.id_cy;
SELECT * FROM v10_6;

-- 7. Покажите заказчиков юр.лиц, сделавших заказы у ИП Ветров и ООО Монтаж
CREATE VIEW v10_7 AS
SELECT cy.ynazv, s.snazv
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
         JOIN salespeople s ON o.id_s = s.id_s
WHERE s.snazv IN ('ИП Ветров', 'ООО Монтаж');
SELECT * FROM v10_7;