-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projectDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projectDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projectDB` DEFAULT CHARACTER SET utf8 ;
USE `projectDB` ;

-- -----------------------------------------------------
-- Table `projectDB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `nickname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(45) NOT NULL,
  `addr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`pet` (
  `pet_id` INT NOT NULL AUTO_INCREMENT,
  `owner` INT NULL,
  `pet_name` VARCHAR(45) NULL,
  `age` INT NULL,
  `weight` FLOAT NULL,
  `sex` VARCHAR(10) NULL,
  `type` VARCHAR(10) NULL,
  `breed` VARCHAR(45) NULL,
  `pet_image` VARCHAR(45) NULL,
  PRIMARY KEY (`pet_id`),
  INDEX `fk_pet_user_idx` (`owner` ASC) VISIBLE,
  CONSTRAINT `fk_pet_user`
    FOREIGN KEY (`owner`)
    REFERENCES `projectDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`service` (
  `srv_id` INT NOT NULL AUTO_INCREMENT,
  `srv_name` VARCHAR(45) NULL,
  `srv_mobile` VARCHAR(45) NULL,
  `srv_addr` VARCHAR(45) NULL,
  `srv_time` TIME NULL,
  `srv_type` VARCHAR(45) NULL,
  PRIMARY KEY (`srv_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`review` (
  `review_id` INT NOT NULL,
  `review_score` INT NULL,
  `review_context` VARCHAR(45) NULL,
  `srv_id2` INT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_review_service1_idx` (`srv_id2` ASC) VISIBLE,
  CONSTRAINT `fk_review_service1`
    FOREIGN KEY (`srv_id2`)
    REFERENCES `projectDB`.`service` (`srv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`diary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`diary` (
  `diary_id` INT NOT NULL AUTO_INCREMENT,
  `diary_context` TEXT(500) NULL,
  `writer` INT NULL,
  `diary_title` VARCHAR(45) NULL,
  `diary_date` DATE NULL,
  PRIMARY KEY (`diary_id`),
  INDEX `fk_diary_user1_idx` (`writer` ASC) VISIBLE,
  CONSTRAINT `fk_diary_user1`
    FOREIGN KEY (`writer`)
    REFERENCES `projectDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`user_pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`user_pet` (
  `user_pet_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `pet_id` INT NULL,
  INDEX `fk_user_pet_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_pet_pet1_idx` (`pet_id` ASC) VISIBLE,
  PRIMARY KEY (`user_pet_id`),
  CONSTRAINT `fk_user_pet_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `projectDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_pet_pet1`
    FOREIGN KEY (`pet_id`)
    REFERENCES `projectDB`.`pet` (`pet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projectDB`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectDB`.`reservation` (
  `reservation_id` INT NOT NULL AUTO_INCREMENT,
  `reservation_date` DATETIME NULL,
  `svc_id` INT NULL,
  `client_id` INT NULL,
  PRIMARY KEY (`reservation_id`),
  INDEX `fk_reservation_user_pet1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_reservation_service1_idx` (`svc_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_user_pet1`
    FOREIGN KEY (`client_id`)
    REFERENCES `projectDB`.`user_pet` (`user_pet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_service1`
    FOREIGN KEY (`svc_id`)
    REFERENCES `projectDB`.`service` (`srv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
