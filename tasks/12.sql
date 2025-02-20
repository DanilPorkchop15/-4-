-- Задание 1:
-- Создайте процедуру «Pr1» с характеристиками «LANGUAGE sql DETERMINISTIC SQL SECURITY definer COMMENT 'First'», 
-- которая выведет на экран надпись «Моя первая процедура».

DELIMITER //
CREATE PROCEDURE Pr1()
    LANGUAGE SQL
    DETERMINISTIC
    SQL SECURITY DEFINER
    COMMENT 'First'
BEGIN
    SELECT 'Моя первая процедура';
END //
DELIMITER ;

CALL Pr1();

-- Задание 2:
-- Создайте и продемонстрируйте процедуру «show_all», которая поочередно выведет всю информацию из всех таблиц вашей базы данных.

DELIMITER //
CREATE PROCEDURE show_all()
BEGIN
    -- Вывод данных из таблицы vids
    SELECT * FROM vids;

    SELECT * FROM salespeople;

    SELECT * FROM skid;

    SELECT * FROM customers_fiz;

    SELECT * FROM customers_yur;

    SELECT * FROM orders;
END //
DELIMITER ;

CALL show_all();

-- Задание 3:
-- Создайте и продемонстрируйте процедуру «Pr2», которая выведет в столбце с названием «Нужные заказы» число заказов, 
-- где заказчик физ.лицо из Казани мужского пола.

DELIMITER //
CREATE PROCEDURE Pr2()
BEGIN
    SELECT COUNT(*) AS 'Нужные заказы'
    FROM torgash_kostin.orders
    WHERE id_cf IN (SELECT id_cf FROM torgash_kostin.customers_fiz WHERE city = 'Казань' AND pol = 'м');
END //
DELIMITER ;

CALL Pr2();

-- Задание 4:
-- Создайте и продемонстрируйте процедуру «Pr3» c входным целым числом «num1» и выходным вещественным числом «num2», 
-- которое примет значение экспоненты «num1».

DELIMITER //
CREATE PROCEDURE Pr3(IN num1 INT, OUT num2 DOUBLE)
BEGIN
    SET num2 = EXP(num1);
END //
DELIMITER ;

CALL Pr3(3, @num2);
SELECT @num2;

-- Задание 5:
-- Создайте и продемонстрируйте процедуру «Pr4», которая принимает строку и создает целочисленную переменную «Х». 
-- Если входная строка это «North», то «Х» присваивается значение 1, иначе 0, а затем «Х» выводится на экран.

DELIMITER //
CREATE PROCEDURE Pr4(IN input_str VARCHAR(255), OUT X INT)
BEGIN
    IF input_str = 'North' THEN
        SET X = 1;
    ELSE
        SET X = 0;
    END IF;
    SELECT X;
END //
DELIMITER ;

CALL Pr4('North', @X);
SELECT @X;

-- Задание 6:
-- Создайте и продемонстрируйте процедуру «Pr5», которая принимает целое число n, и поочередно выводит на экран 
-- все кратные 2 либо 3 числа от 1 до n.

DELIMITER //
CREATE PROCEDURE Pr5(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= n
        DO
            IF i % 2 = 0 OR i % 3 = 0 THEN
                SELECT i;
            END IF;
            SET i = i + 1;
        END WHILE;
END //
DELIMITER ;

CALL Pr5(20);

-- Задание 7:
-- Создайте и продемонстрируйте процедуру «Pr6» c выходным числом sum_amt и курсором, который пройдет по всем суммам заказов > 999 
-- и запишет их общую сумму в sum_amt.

DELIMITER //
CREATE PROCEDURE Pr6(OUT sum_amt DECIMAL(10, 2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE current_amt DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT amt FROM orders WHERE amt > 999;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET sum_amt = 0;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO current_amt;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SET sum_amt = sum_amt + current_amt;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

CALL Pr6(@total_sum);
SELECT @total_sum AS 'Общая сумма заказов > 999';