-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema project2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `project2` ;

-- -----------------------------------------------------
-- Table `project2`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `complete_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`language` (
  `language_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`film` (
  `film_id` INT NOT NULL,
  `description` VARCHAR(5000) NULL DEFAULT NULL,
  `release_year` INT NULL DEFAULT NULL,
  `rental_duration` INT NULL DEFAULT NULL,
  `rental_rate` DECIMAL(10,0) NULL DEFAULT NULL,
  `length` INT NULL DEFAULT NULL,
  `replacement_cost` DECIMAL(10,0) NULL DEFAULT NULL,
  `rating` VARCHAR(45) NULL DEFAULT NULL,
  `special_features` VARCHAR(100) NULL DEFAULT NULL,
  `title` VARCHAR(100) NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`film_id`, `language_id`),
  INDEX `fk_film_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `project2`.`language` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`inventory` (
  `inventory_id` INT NOT NULL,
  `store_id` INT NULL DEFAULT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`, `film_id`),
  INDEX `fk_inventory_film1_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `project2`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` DATETIME NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `return_date` DATETIME NULL DEFAULT NULL,
  `staff_id` BIGINT NULL DEFAULT NULL,
  `inventory_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`, `inventory_id`),
  INDEX `fk_rental_inventory1_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `project2`.`inventory` (`inventory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `project2`.`actor_has_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project2`.`actor_has_film` (
  `actor_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  `title` VARCHAR(10) NULL,
  `complete_name` VARCHAR(100) NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`, `category_id`),
  INDEX `fk_actor_has_film_film1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_actor_has_film_actor_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_actor_has_film_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_actor_has_film_actor`
    FOREIGN KEY (`actor_id`)
    REFERENCES `project2`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actor_has_film_film1`
    FOREIGN KEY (`film_id`)
    REFERENCES `project2`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actor_has_film_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `project2`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
