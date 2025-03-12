CREATE DATABASE BlogDB;
USE BlogDB;

CREATE TABLE Users
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    username      VARCHAR(50) UNIQUE               NOT NULL,
    email         VARCHAR(100) UNIQUE              NOT NULL,
    password_hash VARCHAR(255)                     NOT NULL,
    role          ENUM ('user', 'author', 'admin') NOT NULL
);

CREATE TABLE Categories
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Posts
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    user_id     INT          NOT NULL,
    category_id INT          NOT NULL,
    title       VARCHAR(255) NOT NULL,
    content     TEXT         NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Comments
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    post_id    INT  NOT NULL,
    user_id    INT  NOT NULL,
    content    TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Likes
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    post_id    INT NOT NULL,
    user_id    INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Users (username, email, password_hash, role) VALUES
                                                             ('alex_ivanov', 'alex@example.com', 'hash1', 'admin'),
                                                             ('maria_petrova', 'maria@example.com', 'hash2', 'author'),
                                                             ('sergey_smirnov', 'sergey@example.com', 'hash3', 'user'),
                                                             ('olga_kuznetsova', 'olga@example.com', 'hash4', 'user'),
                                                             ('dmitry_fedorov', 'dmitry@example.com', 'hash5', 'author'),
                                                             ('anna_volkova', 'anna@example.com', 'hash6', 'user'),
                                                             ('pavel_morozov', 'pavel@example.com', 'hash7', 'user'),
                                                             ('ekaterina_sokolova', 'ekaterina@example.com', 'hash8', 'author'),
                                                             ('ivan_kozlov', 'ivan@example.com', 'hash9', 'user'),
                                                             ('natalia_orlova', 'natalia@example.com', 'hash10', 'user'),
                                                             ('vladimir_borisov', 'vladimir@example.com', 'hash11', 'author'),
                                                             ('tatyana_ivanova', 'tatyana@example.com', 'hash12', 'user'),
                                                             ('andrey_pavlov', 'andrey@example.com', 'hash13', 'user'),
                                                             ('elena_nikolaeva', 'elena@example.com', 'hash14', 'author'),
                                                             ('mikhail_egorov', 'mikhail@example.com', 'hash15', 'user'),
                                                             ('irina_vasilieva', 'irina@example.com', 'hash16', 'user');

INSERT INTO Categories (name) VALUES
                                  ('Технологии'),
                                  ('Наука'),
                                  ('Искусство'),
                                  ('Спорт'),
                                  ('Путешествия'),
                                  ('Кулинария'),
                                  ('Здоровье'),
                                  ('Финансы'),
                                  ('Образование'),
                                  ('Мода'),
                                  ('Автомобили'),
                                  ('Кино'),
                                  ('Музыка'),
                                  ('Книги'),
                                  ('Игры'),
                                  ('Дизайн')
('');

INSERT INTO Posts (user_id, category_id, title, content) VALUES
                                                             (2, 1, 'Новые тренды в IT', 'Современные технологии развиваются с невероятной скоростью...'),
                                                             (5, 2, 'Открытие новой планеты', 'Ученые обнаружили планету, похожую на Землю...'),
                                                             (8, 3, 'Искусство в цифровую эпоху', 'Как технологии меняют искусство...'),
                                                             (2, 4, 'Лучшие марафоны 2023', 'Обзор самых популярных марафонов этого года...'),
                                                             (5, 5, 'Топ-10 мест для путешествий', 'Куда поехать в этом году...'),
                                                             (8, 6, 'Рецепт идеального пирога', 'Пошаговый рецепт вкусного пирога...'),
                                                             (2, 7, 'Как сохранить здоровье', 'Советы по здоровому образу жизни...'),
                                                             (5, 8, 'Инвестиции в 2023 году', 'Куда вложить деньги...'),
                                                             (8, 9, 'Онлайн-образование: плюсы и минусы', 'Почему онлайн-курсы набирают популярность...'),
                                                             (2, 10, 'Модные тренды весны', 'Что будет в тренде этой весной...'),
                                                             (5, 11, 'Электромобили: будущее уже здесь', 'Почему электромобили становятся популярными...'),
                                                             (8, 12, 'Лучшие фильмы 2023 года', 'Обзор самых ожидаемых фильмов...'),
                                                             (2, 13, 'Новые альбомы 2023', 'Какие музыкальные альбомы стоит послушать...'),
                                                             (5, 14, 'Книги для саморазвития', 'Топ-5 книг, которые изменят вашу жизнь...'),
                                                             (8, 15, 'Игровая индустрия в 2023 году', 'Какие игры выйдут в этом году...'),
                                                             (2, 16, 'Дизайн интерьера: новые тренды', 'Как оформить квартиру в современном стиле...');

INSERT INTO Comments (post_id, user_id, content) VALUES
                                                     (1, 3, 'Отличная статья, спасибо!'),
                                                     (1, 4, 'Очень интересно, жду продолжения.'),
                                                     (2, 5, 'Удивительное открытие!'),
                                                     (2, 6, 'Как думаете, есть ли там жизнь?'),
                                                     (3, 7, 'Искусство всегда вдохновляет.'),
                                                     (3, 8, 'Цифровое искусство — это будущее.'),
                                                     (4, 9, 'Хочу пробежать марафон в этом году!'),
                                                     (4, 10, 'Спасибо за подборку.'),
                                                     (5, 11, 'Мечтаю побывать в этих местах.'),
                                                     (5, 12, 'Отличные рекомендации!'),
                                                     (6, 13, 'Пирог получился просто идеальным!'),
                                                     (6, 14, 'Спасибо за рецепт.'),
                                                     (7, 15, 'Советы очень полезные.'),
                                                     (7, 16, 'Здоровье — это главное!'),
                                                     (8, 3, 'Интересные идеи для инвестиций.'),
                                                     (8, 4, 'Спасибо за информацию.');

INSERT INTO Likes (post_id, user_id) VALUES
                                         (1, 3),
                                         (1, 4),
                                         (2, 5),
                                         (2, 6),
                                         (3, 7),
                                         (3, 8),
                                         (4, 9),
                                         (4, 10),
                                         (5, 11),
                                         (5, 12),
                                         (6, 13),
                                         (6, 14),
                                         (7, 15),
                                         (7, 16),
                                         (8, 3),
                                         (8, 4);

# 4. Вывод результатов

select * from Users;
select * from Categories;
select * from Posts;
select * from Comments;
select * from Likes;

SELECT
    p.id AS post_id,
    p.title,
    COUNT(DISTINCT l.id) AS likes_count,
    COUNT(DISTINCT c.id) AS comments_count,
    COUNT(DISTINCT l.id) + COUNT(DISTINCT c.id) AS rating
FROM Posts p
         LEFT JOIN Likes l ON p.id = l.post_id
         LEFT JOIN Comments c ON p.id = c.post_id
GROUP BY p.id
ORDER BY rating DESC;

SELECT
    p.title,
    p.content,
    u.username AS author
FROM Posts p
         JOIN Users u ON p.user_id = u.id
WHERE p.title LIKE '%технологии%' OR p.content LIKE '%технологии%';

SELECT
    u.username,
    COUNT(p.id) AS posts_count
FROM Users u
         JOIN Posts p ON u.id = p.user_id
WHERE u.role = 'author'
GROUP BY u.id
ORDER BY posts_count DESC
LIMIT 5;

SELECT
    c.name AS category,
    COUNT(DISTINCT p.id) AS posts_count,
    COUNT(DISTINCT c2.id) AS comments_count
FROM Categories c
         LEFT JOIN Posts p ON c.id = p.category_id
         LEFT JOIN Comments c2 ON p.id = c2.post_id
GROUP BY c.id;

SELECT
    p.title,
    p.content,
    c.name AS category
FROM Posts p
         JOIN Categories c ON p.category_id = c.id
WHERE c.id IN (
    SELECT p2.category_id
    FROM Likes l
             JOIN Posts p2 ON l.post_id = p2.id
    WHERE l.user_id = (SELECT id FROM Users WHERE username = 'sergey_smirnov')
    GROUP BY p2.category_id
    ORDER BY COUNT(*) DESC
)
LIMIT 5;

SELECT
    p.title,
    p.created_at
FROM Posts p
WHERE p.created_at < NOW() - INTERVAL 1 YEAR;

SELECT
    u.username
FROM Users u
         LEFT JOIN Comments c ON u.id = c.user_id
WHERE c.id IS NULL;

SELECT
    u.username,
    AVG(likes_count) AS avg_likes_per_post
FROM Users u
         JOIN (
    SELECT
        p.user_id,
        COUNT(l.id) AS likes_count
    FROM Posts p
             LEFT JOIN Likes l ON p.id = l.post_id
    GROUP BY p.id
) AS post_likes ON u.id = post_likes.user_id
GROUP BY u.id;

SELECT
    p.title,
    COUNT(l.id) AS likes_count
FROM Posts p
         JOIN Likes l ON p.id = l.post_id
WHERE l.created_at >= NOW() - INTERVAL 1 MONTH
GROUP BY p.id
ORDER BY likes_count DESC
LIMIT 5;

SELECT DISTINCT
    u.username,
    p.title AS post_title,
    c.content AS new_comment
FROM Users u
         JOIN Posts p ON u.id = p.user_id
         JOIN Comments c ON p.id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 1 DAY;


# 5 триггеров

# 1. Ограничение количества лайков от одного пользователя на один пост
# Описание:
# Запрещает добавление повторного лайка от одного пользователя к одному посту. Это предотвращает манипуляции с рейтингом постов.
DELIMITER $$
CREATE TRIGGER prevent_duplicate_likes
    BEFORE INSERT ON Likes
    FOR EACH ROW
BEGIN
    DECLARE like_count INT;
    SELECT COUNT(*) INTO like_count
    FROM Likes
    WHERE post_id = NEW.post_id AND user_id = NEW.user_id;
    IF like_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Нельзя поставить больше одного лайка на один пост.';
    END IF;
END$$
DELIMITER ;

INSERT INTO Likes (post_id, user_id) VALUES (1, 3);

# 2. Триггер, который при обновлении поста проверяет, что пользователь, который обновляет пост, является его автором
DELIMITER $$
CREATE TRIGGER tr_check_author
    BEFORE UPDATE ON Posts
    FOR EACH ROW
BEGIN
    IF NEW.user_id != (SELECT user_id FROM Posts WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вы не имеете права редактировать этот пост.';
    END IF;
END $$
DELIMITER ;

-- Создание поста (автор - user_id = 2)
INSERT INTO Posts (user_id, category_id, title, content)
VALUES (2, 1, 'Новые тренды в IT', 'Современные технологии развиваются...');

-- Попытка редактирования другим пользователем (нарушение)
UPDATE Posts
SET content = 'Измененный текст', user_id = 4
WHERE id = 1;

# 3. Описание:
# Перед добавлением нового поста проверяется его содержимое (content) на наличие запрещенных слов или фраз (например, спам, оскорбления, неприемлемый контент). Если такие слова обнаружены, пост не добавляется, и выводится сообщение об ошибке. Это помогает поддерживать качество контента и предотвращать публикацию нежелательных материалов.
DELIMITER $$
CREATE TRIGGER check_post_content
    BEFORE INSERT ON Posts
    FOR EACH ROW
BEGIN
    IF NEW.content LIKE '%спам%' OR
       NEW.content LIKE '%оскорбление%' OR
       NEW.content LIKE '%неприемлемо%' OR
       NEW.content LIKE '%запрещено%' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Пост содержит запрещенные слова и не может быть добавлен.';
    END IF;
END$$
DELIMITER ;

-- Попытка добавления поста с запрещенным словом (нарушение)
INSERT INTO Posts (user_id, category_id, title, content)
VALUES (2, 1, 'Рекламный пост', 'Это спам! Купите наш продукт!');

# 4. Триггер: Проверка контента комментария на наличие запрещенных слов перед добавлением
# Описание:
# Перед добавлением нового комментария проверяется его содержимое на наличие запрещенных слов (например, спам, оскорбления или нежелательные фразы). Если такие слова обнаружены, комментарий не добавляется, и выводится сообщение об ошибке. Это помогает поддерживать чистоту контента и предотвращать злоупотребления.
DELIMITER $$
CREATE TRIGGER check_comment_content
    BEFORE INSERT ON Comments
    FOR EACH ROW
BEGIN
    IF NEW.content LIKE '%спам%' OR
       NEW.content LIKE '%оскорбление%' OR
       NEW.content LIKE '%неприемлемо%' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Комментарий содержит запрещенные слова и не может быть добавлен.';
    END IF;
END $$
DELIMITER ;

-- Попытка добавления комментария с запрещенным словом (нарушение)
INSERT INTO Comments (post_id, user_id, content)
VALUES (1, 3, 'Это оскорбление автора поста!');

# 5. Триггер, который при обновлении комментария проверяет, что пользователь, который обновляет комментарий, является его автором
DELIMITER $$
CREATE TRIGGER tr_check_comment_author
    BEFORE UPDATE ON Comments
    FOR EACH ROW
BEGIN
    IF NEW.user_id != (SELECT user_id FROM Comments WHERE id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вы не имеете права редактировать этот комментарий.';
    END IF;
END $$
DELIMITER ;

-- Создание комментария (автор - user_id = 3)
INSERT INTO Comments (post_id, user_id, content)
VALUES (1, 3, 'Отличная статья!');

-- Попытка редактирования другим пользователем (нарушение)
UPDATE Comments
SET content = 'Измененный текст', user_id = 5
WHERE id = 1;
# 5 процедур

# 1. Процедура, которая возвращает список постов, на которые пользователь поставил лайк
DELIMITER //
CREATE PROCEDURE get_liked_posts(IN user_id INT)
BEGIN
    SELECT p.id, p.title
    FROM Posts p
             JOIN Likes l ON p.id = l.post_id
    WHERE l.user_id = user_id;
END//
DELIMITER ;

# 2. Процедура, которая возвращает список комментариев, которые пользователь оставил
DELIMITER //
CREATE PROCEDURE get_comments_by_user(IN user_id INT)
BEGIN
    SELECT c.id, c.content, c.created_at
    FROM Comments c
    WHERE c.user_id = user_id;
END//
DELIMITER ;

# 3. Процедура, которая возвращает список постов, которые пользователь создал
DELIMITER //
CREATE PROCEDURE get_posts_by_user(IN user_id INT)
BEGIN
    SELECT p.id, p.title, p.content, p.created_at
    FROM Posts p
    WHERE p.user_id = user_id;
END//
DELIMITER ;

# 4. Процедура, которая возвращает список пользователей, которые оставили комментарии к посту
DELIMITER //
CREATE PROCEDURE get_users_by_post(IN post_id INT)
BEGIN
    SELECT u.id, u.username
    FROM Users u
             JOIN Comments c ON u.id = c.user_id
    WHERE c.post_id = post_id;
END//
DELIMITER ;

# 5. Процедура, которая возвращает список категорий, в которых есть посты
DELIMITER //
CREATE PROCEDURE get_categories_with_posts()
BEGIN
    SELECT DISTINCT c.id, c.name
    FROM Categories c
             JOIN Posts p ON c.id = p.category_id;
END//
DELIMITER ;

# запросы, которые могли бы продемонстрировать работу триггеров и процедур

CALL get_liked_posts(3);
CALL get_comments_by_user(3);
CALL get_posts_by_user(2);
CALL get_users_by_post(1);
CALL get_categories_with_posts();