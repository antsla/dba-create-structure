-- Выборка всех постов --
SELECT p.id AS post_id, p.url AS post_url, c.url AS category_url, p.title, p.description, p.created_at
FROM posts AS p
LEFT JOIN categories AS c ON c.id = p.category_id

-- Выборка только тех пользователей, у которых есть хотя бы один пост --
SELECT u.* 
FROM users AS u 
INNER JOIN posts AS p ON p.author_id = u.id
GROUP BY u.id;

-- Выборка постов, которые не удалены --
SELECT id, url, title, description, created_at
FROM posts
WHERE deleted_at IS NULL;

-- Выборка постов определенных категорий --
SELECT id, url, title, description, created_at
FROM posts
WHERE category_id IN (1, 3);

-- Выборка постов, где лайков и репостов больше, чем 50 --
SELECT p.id, p.url, p.title, p.description, p.created_at, pi.views, pi.likes, pi.reposts
FROM posts AS p
LEFT JOIN posts_info AS pi ON pi.post_id = p.id
WHERE likes > 50 AND reposts > 50;

-- Выборка постов, которые просматривал пользователь с id = 3 --
SELECT p.id, p.url, p.title, p.description, p.created_at
FROM posts AS p
LEFT JOIN posts_views AS pv ON pv.post_id = p.id
WHERE pv.user_id = 3;
