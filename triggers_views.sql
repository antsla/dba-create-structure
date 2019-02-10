USE `blog`;

-- Триггеры для обновления информации о постах --
delimiter $$
CREATE TRIGGER `update_post_views` AFTER INSERT ON `posts_views` FOR EACH ROW BEGIN
UPDATE `posts_info` SET views = views + 1 WHERE post_id = NEW.post_id;END;

CREATE TRIGGER `update_post_likes` AFTER INSERT ON `posts_likes` FOR EACH ROW BEGIN
UPDATE `posts_info` SET likes = likes + 1 WHERE post_id = NEW.post_id;END;

CREATE TRIGGER `delete_post_likes` AFTER DELETE ON `posts_likes` FOR EACH ROW BEGIN
UPDATE `posts_info` SET likes = likes - 1 WHERE post_id = OLD.post_id;END;

CREATE TRIGGER `update_post_repost` AFTER INSERT ON `posts`FOR EACH ROW BEGIN
IF (NEW.parent_id <> 0) THEN
UPDATE `posts_info` SET reposts = reposts + 1 WHERE post_id = NEW.parent_id;END IF;END;
$$
delimiter ;

-- Хранимые процедуры для выборки категорий постов и 5 случайных постов --
CREATE OR REPLACE VIEW select_all_categories AS
	SELECT c.id, c.url FROM categories AS c
	ORDER BY url;

SELECT * FROM select_all_categories;

CREATE OR REPLACE VIEW select_random_posts AS 
	SELECT p.id, p.title, p.url, p.image_preview, p.created_at, c.url AS category_url,
		s.title AS status_name, u.name AS author_name, pi.views AS views, pi.likes AS likes
	FROM posts AS p 
	INNER JOIN categories AS c ON c.id = p.category_id
	INNER JOIN statuses AS s ON s.id = p.status_id
	INNER JOIN users AS u ON u.id = p.author_id
	INNER JOIN posts_info AS pi ON pi.post_id = p.id
	WHERE p.deleted_at IS NULL
	ORDER BY RAND()
	LIMIT 5;

SELECT * FROM select_random_posts;