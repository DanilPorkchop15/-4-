CREATE TABLE imported_from_excel
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(100) CHARACTER SET utf8mb4,
    age       INT,
    salary    DECIMAL(10, 2),
    hire_date DATE,
    notes     TEXT
) CHARACTER SET utf8mb4;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE '/var/lib/mysql-files/data.csv'
    INTO TABLE imported_from_excel
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (name, age, salary, hire_date, notes);

CREATE TABLE imported_from_txt
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(100) CHARACTER SET utf8mb4,
    quantity      INT,
    price         DECIMAL(10, 2),
    purchase_date DATE,
    description   TEXT
) CHARACTER SET utf8mb4;

LOAD DATA INFILE '/var/lib/mysql-files/data.txt'
    INTO TABLE imported_from_txt
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY '\t'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES
    (product_name, quantity, price, purchase_date, description);

SELECT *
INTO OUTFILE '/var/lib/mysql-files/orders.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
FROM orders;

SELECT *
INTO OUTFILE '/var/lib/mysql-files/customers_yur.txt'
    FIELDS TERMINATED BY '\t'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
FROM customers_yur;

SELECT * FROM imported_from_excel;
SELECT * FROM imported_from_txt;