# CREATE DATABASE Biblioteka;
USE Biblioteka;

CREATE TABLE Author (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(100) NOT NULL
);

CREATE TABLE Genre (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100) NOT NULL
);

CREATE TABLE Publisher (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) NOT NULL,
                           status ENUM('действующее', 'аннулированное') DEFAULT 'действующее'
);

CREATE TABLE Book (
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      title VARCHAR(100) NOT NULL,
                      author_id INT,
                      genre_id INT,
                      publisher_id INT,
                      FOREIGN KEY (author_id) REFERENCES Author(id) ON DELETE CASCADE ON UPDATE CASCADE,
                      FOREIGN KEY (genre_id) REFERENCES Genre(id) ON DELETE SET NULL,
                      FOREIGN KEY (publisher_id) REFERENCES Publisher(id) ON DELETE SET NULL
);

CREATE TABLE Reader (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        full_name VARCHAR(100) NOT NULL,
                        birth_date DATE NOT NULL
);

CREATE TABLE BookIssue (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           issue_date DATE NOT NULL,
                           return_date DATE,
                           book_id INT,
                           reader_id INT,
                           FOREIGN KEY (book_id) REFERENCES Book(id) ON DELETE SET NULL,
                           FOREIGN KEY (reader_id) REFERENCES Reader(id) ON DELETE CASCADE
);

INSERT INTO Author (name) VALUES
                              ('Л.Н. Толстой'),
                              ('Н.В. Гоголь'),
                              ('М.А. Булгаков'),
                              ('И.А. Бунин'),
                              ('А.П. Чехов');

INSERT INTO Genre (name) VALUES
                             ('Роман'),
                             ('Повесть'),
                             ('Поэма'),
                             ('Рассказ'),
                             ('Пьеса');

INSERT INTO Publisher (name) VALUES
                                 ('АСТ'),
                                 ('Эксмо'),
                                 ('Детская литература');

INSERT INTO Book (title, author_id, genre_id, publisher_id) VALUES
                                                                ('Война и мир', 1, 1, 1),
                                                                ('Анна Каренина', 1, 1, 1),
                                                                ('Вий', 2, 2, 2),
                                                                ('Мёртвые души', 2, 3, 2),
                                                                ('Мастер и Маргарита', 3, 1, 3),
                                                                ('Собачье сердце', 3, 2, 3),
                                                                ('Белая гвардия', 3, 1, 3),
                                                                ('Гражданин из Сан-Франциско', 4, 4, 1),
                                                                ('Жизнь Арсеньева', 4, 1, 1),
                                                                ('Палата №6', 5, 4, 2),
                                                                ('Дядя Ваня', 5, 5, 2),
                                                                    ('Фальшь', 5, 4, 2);

INSERT INTO Reader (full_name, birth_date) VALUES
                                               ('Иванов Иван Иванович', '1990-05-15'),
                                               ('Петров Петр Петрович', '1985-08-20'),
                                               ('Сидорова Мария Сергеевна', '2000-02-10');

INSERT INTO BookIssue (issue_date, return_date, book_id, reader_id) VALUES
                                                                        ('2023-10-01', '2023-10-15', 1, 1),
                                                                        ('2023-10-02', '2023-10-16', 2, 2),
                                                                        ('2023-10-03', NULL, 3, 3),
                                                                        ('2023-10-04', '2023-10-18', 4, 1),
                                                                        ('2023-10-05', NULL, 5, 2),
                                                                        ('2023-10-06', '2023-10-20', 6, 3),
                                                                        ('2023-10-07', NULL, 7, 1),
                                                                        ('2023-10-08', '2023-10-22', 8, 2),
                                                                        ('2023-10-09', NULL, 9, 3),
                                                                        ('2023-10-10', '2023-10-24', 10, 1),
                                                                        ('2023-10-11', NULL, 11, 2),
                                                                        ('2023-10-12', '2023-10-26', 12, 3),
                                                                        ('2023-10-13', NULL, 1, 1),
                                                                        ('2023-10-14', '2023-10-28', 2, 2),
                                                                        ('2023-10-15', NULL, 3, 3);

DELIMITER $$

CREATE TRIGGER update_publisher_status
BEFORE UPDATE ON Publisher
FOR EACH ROW
BEGIN
    IF NEW.status = 'аннулированное' AND OLD.status = 'действующее' THEN
        UPDATE Book SET publisher_id = NULL WHERE publisher_id = OLD.id;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER insert_status_house
    AFTER INSERT ON Publisher
    FOR EACH ROW
BEGIN
    IF NEW.status = 'аннулированное' THEN
        UPDATE Book SET publisher_id = NULL WHERE publisher_id = NEW.id;
    END IF;
END$$

DELIMITER ;

UPDATE Publisher SET status = 'аннулированное' WHERE id = 1;

SELECT * FROM Book WHERE publisher_id IS NULL;

INSERT INTO Publisher (name, status) VALUES ('New House', 'аннулированное');

SELECT * FROM Book WHERE Book.publisher_id IS NULL;