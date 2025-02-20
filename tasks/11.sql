-- 1. Показать самые большие комиссионные продавцов в каждом городе
CREATE VIEW v11_1 AS
SELECT
            ROW_NUMBER() OVER (ORDER BY city) AS 'Номер уникальности',
        snazv AS 'Имя продавца',
        comm AS 'Комиссионные',
        city AS 'Город',
        MAX(comm) OVER (PARTITION BY city) AS 'Максимальная комиссия в каждом городе'
FROM salespeople;
SELECT * FROM v11_1;

-- 2. Показать суммарный накопительный итог всех заказов для каждого продавца
CREATE VIEW v11_2 AS
SELECT
    o.odate AS 'Дата оформления заказа',
        o.amt AS 'Стоимость заказа',
        s.snazv AS 'Имя продавца',
        SUM(o.amt) OVER (PARTITION BY s.id_s ORDER BY o.odate) AS 'Накопительная сумма стоимости заказов'
FROM orders o
         JOIN salespeople s ON o.id_s = s.id_s;
SELECT * FROM v11_2;

-- 3. Показать максимальную стоимость заказа для каждого заказчика физ.лица и заказ, стоимость которого предшествовала максимальному
CREATE VIEW v11_3 AS
SELECT
    cf.name AS 'Имя заказчика физ.лица',
        o.amt AS 'Стоимость заказа',
        MAX(o.amt) OVER (PARTITION BY cf.id_cf) AS 'Максимальная стоимость заказа для каждого заказчика физ.лица',
        LAG(o.amt) OVER (PARTITION BY cf.id_cf ORDER BY o.amt DESC) AS 'Стоимость заказа, предшествующая максимальной для данного Заказчика физ.лица'
FROM orders o
         JOIN customers_fiz cf ON o.id_cf = cf.id_cf;
SELECT * FROM v11_3;

-- 4. Показать номер юр.лица с максимальной суммарной стоимостью всех его заказов
CREATE VIEW v11_4 AS
SELECT
    cy.id_cy AS 'Номер юр.лица',
        SUM(o.amt) AS 'Суммарная стоимость заказов'
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
GROUP BY cy.id_cy
ORDER BY SUM(o.amt) DESC
LIMIT 1;
SELECT * FROM v11_4;

-- 4.1. Показать имя юр.лица, у которого оказалась эта максимальная суммарная стоимость заказов
CREATE VIEW v11_4_1 AS
SELECT
    cy.ynazv AS 'Имя юр.лица',
        SUM(o.amt) AS 'Максимальная суммарная стоимость заказов'
FROM orders o
         JOIN customers_yur cy ON o.id_cy = cy.id_cy
GROUP BY cy.id_cy
ORDER BY SUM(o.amt) DESC
LIMIT 1;
SELECT * FROM v11_4_1;

-- 4.2. Показать имя юр.лица, который на втором месте по максимальной суммарной стоимости заказов
CREATE VIEW v11_4_2 AS
WITH ranked_customers AS (
    SELECT
        cy.ynazv AS ynazv,
        SUM(o.amt) AS "sum",
        RANK() OVER (ORDER BY SUM(o.amt) DESC) AS "rank"
    FROM orders o
    JOIN customers_yur cy ON o.id_cy = cy.id_cy
    GROUP BY cy.id_cy
)
SELECT
    ynazv, sum, `rank`
FROM ranked_customers
WHERE `rank` = 2;
SELECT * FROM v11_4_2;