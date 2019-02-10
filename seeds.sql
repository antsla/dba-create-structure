INSERT IGNORE INTO `users` (name, mail) VALUES ('user_1', 'user_1@fake.com'), 
('user_2', 'user_2@fake.com'),
('user_3', 'user_3@fake.com'),
('user_4', 'user_4@fake.com'),
('user_5', 'user_5@fake.com');

SET @locale_ru_id = 1;
SET @locale_en_id = 2;
INSERT IGNORE INTO `locales` (id, name) VALUES (@locale_ru_id, 'ru'),
(@locale_en_id, 'en');

SET @status_draft_id = 1;
SET @status_moderate_id = 2;
SET @status_ready_id = 3;
INSERT IGNORE INTO `statuses` (id, title) VALUES (@status_draft_id, 'draft'),
(@status_moderate_id, 'moderate'),
(@status_ready_id, 'ready');

SET @category_programming_id = 1;
SET @category_design_id = 2;
SET @category_marketing_id = 3;
SET @category_modeling_id = 4;
INSERT IGNORE INTO `categories` (id, url) VALUES (@category_programming_id, 'programming'), 
(@category_design_id, 'design'), 
(@category_marketing_id, 'marketing'), 
(@category_modeling_id, 'modeling');

INSERT IGNORE INTO `categories_locales` (category_id, locale_id, title) VALUES (@category_programming_id, @locale_ru_id, 'Programmiroyanie'),
(@category_programming_id, @locale_en_id, 'Programming'),
(@category_design_id, @locale_ru_id, 'Disain'),
(@category_design_id, @locale_en_id, 'Design'),
(@category_marketing_id, @locale_ru_id, 'Marketing'),
(@category_marketing_id, @locale_en_id, 'Marketing'),
(@category_modeling_id, @locale_ru_id, 'Modelirovaniye'),
(@category_modeling_id, @locale_en_id, 'Modeling');

START TRANSACTION;
INSERT IGNORE INTO `posts` (category_id, status_id, locale_id, url, author_id, title, description, image)
VALUES (@category_programming_id, @status_ready_id, @locale_ru_id, 'first-post', (SELECT id FROM users ORDER BY RAND() LIMIT 1), 'first-post', 'description of first post', 'first-post.jpg');
SET @post_1_id = LAST_INSERT_ID();
INSERT IGNORE INTO `posts_info` (post_id) VALUES (@post_1_id);
COMMIT;

START TRANSACTION;
INSERT IGNORE INTO `posts` (category_id, status_id, locale_id, url, author_id, title, description, image)
VALUES (@category_programming_id, @status_ready_id, @locale_ru_id, 'second-post', (SELECT id FROM users ORDER BY RAND() LIMIT 1), 'second-post', 'description of second post', 'first-second.jpg');
SET @post_2_id = LAST_INSERT_ID();
INSERT IGNORE INTO `posts_info` (post_id) VALUES (@post_2_id);
COMMIT;

START TRANSACTION;
INSERT IGNORE INTO `posts` (category_id, status_id, locale_id, url, author_id, title, description, image)
VALUES (@category_programming_id, @status_ready_id, @locale_ru_id, 'third-post', (SELECT id FROM users ORDER BY RAND() LIMIT 1), 'third-post', 'description of third post', 'third-post.jpg');
SET @post_3_id = LAST_INSERT_ID();
INSERT IGNORE INTO `posts_info` (post_id) VALUES (@post_3_id);
COMMIT;

START TRANSACTION;
INSERT IGNORE INTO `posts` (category_id, status_id, locale_id, url, author_id, parent_id, title, description, image)
VALUES (@category_programming_id, @status_ready_id, @locale_ru_id, 'fourth-post', (SELECT id FROM users ORDER BY RAND() LIMIT 1), @post_3_id, 'fourth-post', 'description of fourth post', 'fourth-post.jpg');
SET @post_4_id = LAST_INSERT_ID();
INSERT IGNORE INTO `posts_info` (post_id) VALUES (@post_4_id);
COMMIT;

INSERT IGNORE INTO `posts_views` (post_id, user_id) VALUES (@post_1_id, (SELECT id FROM users ORDER BY RAND() LIMIT 1));
INSERT IGNORE INTO `posts_views` (post_id, user_id) VALUES (@post_2_id, (SELECT id FROM users ORDER BY RAND() LIMIT 1));
INSERT IGNORE INTO `posts_views` (post_id, user_id) VALUES (@post_3_id, (SELECT id FROM users ORDER BY RAND() LIMIT 1));

INSERT IGNORE INTO `posts_likes` (post_id, user_id) SELECT @post_1_id, id FROM users;
INSERT IGNORE INTO `posts_likes` (post_id, user_id) SELECT @post_3_id, id FROM users LIMIT 3;