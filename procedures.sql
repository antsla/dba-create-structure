delimiter $$
-- Выборка всех подписчиков для заданного пользователя --
DROP PROCEDURE IF EXISTS select_all_subscribers;
CREATE PROCEDURE select_all_subscribers(IN user_id INT)
BEGIN
	SELECT u.name, u.mail FROM users_subscribers AS us
		INNER JOIN users AS u ON u.id = us.subscriber_id
		WHERE u.deleted_at IS NULL;
END;

-- Выборка всех комментариев для заданного поста с пагинацией --
DROP PROCEDURE IF EXISTS select_all_comments;
CREATE PROCEDURE select_all_comments(IN post_id INT, IN c_limit INT, IN c_offset INT)
BEGIN
	SELECT c.id, c.description, c.created_at, u.name FROM comments AS c
		INNER JOIN users AS u ON u.id = c.author_id
		INNER JOIN posts AS p ON p.id = c.post_id
		WHERE p.id = post_id
			AND p.deleted_at IS NULL 
			AND u.deleted_at IS NULL 
			AND c.deleted_at IS NULL
		LIMIT c_offset, c_limit;
END;
$$
delimiter ;
