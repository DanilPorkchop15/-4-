CREATE DATABASE Practika;
SHOW DATABASES;
USE Practika;

-- Создание таблиц

CREATE TABLE forums (
                        id_forum INT(5) NOT NULL AUTO_INCREMENT,
                        name CHAR(38),
                        pos FLOAT(4,2),
                        hide INT(3),
                        PRIMARY KEY (id_forum)
);

CREATE TABLE Salespeople (
                             snum INT NOT NULL UNIQUE,
                             sname CHAR(10) NOT NULL UNIQUE,
                             city CHAR(10) DEFAULT 'New York',
                             comm DECIMAL(4,2) CHECK (comm < 1),
                             PRIMARY KEY (snum)
);

CREATE TABLE Customers (
                           cnum INT NOT NULL,
                           cname CHAR(10),
                           city CHAR(10),
                           snum INT NOT NULL,
                           PRIMARY KEY (cnum),
                           FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

CREATE TABLE Staff (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(255) NOT NULL,
                       position VARCHAR(30),
                       birthday DATE NOT NULL,
                       has_child BOOLEAN DEFAULT 0 NOT NULL,
                       phone VARCHAR(20) UNIQUE NOT NULL,
                       CONSTRAINT staff_chk_birthday CHECK (birthday > '1900-01-01'),
                       CONSTRAINT staff_chk_phone CHECK (phone REGEXP '[+]?[0-9]{1,3} ?\\(?[0-9]{3}\\)? ?[0-9]{2}[0-9 -]+[0-9]{2}')
    );

SHOW TABLES;
DESCRIBE forums;

-- Вставка данных

INSERT INTO Salespeople (snum, sname, city, comm) VALUES
                                                      (1001, 'John', 'New York', 0.15),
                                                      (1002, 'Anna', 'London', 0.12),
                                                      (1003, 'Mike', 'San Jose', 0.10);

INSERT INTO Customers (cnum, cname, city, snum) VALUES
                                                    (2001, 'Alice', 'New York', 1001),
                                                    (2002, 'Bob', 'London', 1002),
                                                    (2003, 'Charlie', 'San Jose', 1003);

INSERT INTO Staff (name, position, birthday, has_child, phone) VALUES
                                                                   ('Ivan', 'Manager', '1985-05-15', 1, '+7 (999) 123-45-67'),
                                                                   ('Maria', 'Developer', '1990-08-20', 0, '+7 (999) 987-65-43');



-- Выборка данных

SELECT * FROM Salespeople;
SELECT * FROM Customers;
SELECT * FROM Staff;

-- Вставка - другие варианты

CREATE TABLE Londonstaff (
                             snum INT PRIMARY KEY,
                             sname VARCHAR(50) NOT NULL,
                             city VARCHAR(50) NOT NULL,
                             comm DECIMAL(4,2)
);

CREATE TABLE Daytotals (
                           date DATE PRIMARY KEY,
                           total DECIMAL(10,2)
);

CREATE TABLE SJpeople (
                          snum INT PRIMARY KEY,
                          sname VARCHAR(50) NOT NULL,
                          city VARCHAR(50) NOT NULL,
                          comm DECIMAL(4,2)
);



CREATE TABLE Orders (
                        onum INT PRIMARY KEY,
                        amt DECIMAL(10,2),
                        odate DATE,
                        snum INT,
                        FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);

INSERT INTO Orders (onum, amt, odate, snum) VALUES
                                                (3001, 100.50, '2023-10-01', 1001),
                                                (3002, 200.75, '2023-10-01', 1002),
                                                (3003, 150.00, '2023-10-02', 1003),
                                                (3004, 300.25, '2023-10-02', 1004);



INSERT INTO Londonstaff
SELECT * FROM Salespeople
WHERE city = 'London';

INSERT INTO Daytotals (date, total)
SELECT odate, SUM(amt)
FROM Orders
GROUP BY odate;

INSERT INTO SJpeople
SELECT * FROM Salespeople
WHERE snum = ANY (
    SELECT snum
    FROM Customers
    WHERE city = 'San Jose'
);

SELECT * FROM Londonstaff;
SELECT * FROM Daytotals;
SELECT * FROM SJpeople;

-- DROP DATABASE Practika;