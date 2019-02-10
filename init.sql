CREATE DATABASE IF NOT EXISTS `blog`;

USE `blog`;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `mail` VARCHAR(255) NOT NULL,
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE INDEX `un_name` (`name` ASC),
  UNIQUE INDEX `un_mail` (`mail` ASC)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `users_subscribers` (
	`user_id` INT NOT NULL,
  	`subscriber_id` INT NOT NULL,
  	UNIQUE INDEX `un_user_id_subscriber_id` (`user_id` ASC, `subscriber_id` ASC),
	CONSTRAINT `fk_us_user_id`
		FOREIGN KEY (`user_id`)
		REFERENCES `users` (`id`),
	CONSTRAINT `fk_us_subscriber_id`
		FOREIGN KEY (`subscriber_id`)
		REFERENCES `users` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `locales` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` CHAR(2) NOT NULL,
	UNIQUE INDEX `un_name` (`name` ASC)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `categories` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`url` VARCHAR(45) NOT NULL,
	UNIQUE INDEX `un_url` (`url` ASC)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `categories_locales` (
	`category_id` INT NOT NULL,
	`locale_id` INT NULL,
	`title` VARCHAR(45) NOT NULL,
	UNIQUE INDEX `un_category_id_locale_id` (`category_id` ASC, `locale_id` ASC),
	CONSTRAINT `fk_cl_category_id`
		FOREIGN KEY (`category_id`)
		REFERENCES `categories` (`id`),
	CONSTRAINT `fk_cl_locale_id`
		FOREIGN KEY (`locale_id`)
		REFERENCES `locales` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `statuses` (
	`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`title` VARCHAR(45) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `posts` (
	`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`category_id` INT NOT NULL,
	`status_id` INT NOT NULL,
	`locale_id` INT NOT NULL,
	`url` VARCHAR(255) NOT NULL,
	`author_id` INT NOT NULL,
	`parent_id` INT NOT NULL DEFAULT 0,
	`title` VARCHAR(255) NOT NULL,
	`description` TEXT NOT NULL,
	`image` CHAR(30) NULL,
	`image_preview` CHAR(30) NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
	`deleted_at` TIMESTAMP NULL DEFAULT NULL,
	`last_view_at` TIMESTAMP NULL DEFAULT NULL,
	INDEX `idx_parent_id` (`parent_id` ASC),
	UNIQUE INDEX `un_url` (`url` ASC),
	INDEX `idx_locale_id` (`locale_id` ASC),
	INDEX `idx_category_id` (`category_id` ASC),
	INDEX `idx_status_id` (`status_id` ASC),
	INDEX `idx_author_id` (`author_id` ASC),
	CONSTRAINT `fk_p_category_id`
		FOREIGN KEY (`category_id`)
		REFERENCES `categories` (`id`),
	CONSTRAINT `fk_p_status_id`
		FOREIGN KEY (`status_id`)
		REFERENCES `statuses` (`id`),
	CONSTRAINT `fk_p_locale_id`
		FOREIGN KEY (`locale_id`)
		REFERENCES `locales` (`id`),
	CONSTRAINT `fk_p_author_id`
		FOREIGN KEY (`author_id`)
		REFERENCES `users` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `comments` (
	`id` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`post_id` BIGINT NOT NULL,
	`author_id` INT NOT NULL,
	`description` TEXT NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
	`deleted_at` TIMESTAMP NULL DEFAULT NULL,
	INDEX `idx_post_id` (`post_id` ASC),
	INDEX `idx_author_id` (`author_id` ASC),
	CONSTRAINT `fk_c_post_id`
		FOREIGN KEY (`post_id`)
		REFERENCES `posts` (`id`),
	CONSTRAINT `fk_c_author_id`
		FOREIGN KEY (`author_id`)
		REFERENCES `users` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `posts_likes` (
	`post_id` BIGINT NOT NULL,
	`user_id` INT NOT NULL,
	INDEX `idx_post_id` (`post_id` ASC),
	INDEX `idx_user_id` (`user_id` ASC),
	UNIQUE INDEX `un_post_id_user_id` (`post_id` ASC, `user_id` ASC),
	CONSTRAINT `fk_pl_post_id`
		FOREIGN KEY (`post_id`)
		REFERENCES `posts` (`id`),
	CONSTRAINT `fk_pl_user_id`
		FOREIGN KEY (`user_id`)
		REFERENCES `users` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `posts_views` (
	`post_id` BIGINT NOT NULL,
	`user_id` INT NOT NULL,
	INDEX `idx_post_id` (`post_id` ASC),
	INDEX `idx_user_id` (`user_id` ASC),
	UNIQUE INDEX `un_post_id_user_id` (`post_id` ASC, `user_id` ASC),
	CONSTRAINT `fk_pv_post_id`
		FOREIGN KEY (`post_id`)
		REFERENCES `posts` (`id`),
	CONSTRAINT `fk_pv_user_id`
		FOREIGN KEY (`user_id`)
		REFERENCES `users` (`id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `posts_info` (
	`post_id` BIGINT NOT NULL PRIMARY KEY,
	`views` INT NOT NULL DEFAULT 0,
	`likes` INT NOT NULL DEFAULT 0,
	`reposts` INT NOT NULL DEFAULT 0,
	CONSTRAINT `fk_pi_post_id`
		FOREIGN KEY (`post_id`)
		REFERENCES `posts` (`id`)
) ENGINE = InnoDB;