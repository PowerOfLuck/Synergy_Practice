-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- Schema tourism

CREATE SCHEMA IF NOT EXISTS `tourism` DEFAULT CHARACTER SET utf8 ;
USE `tourism` ;

-- Table `tourism`.`country`
CREATE TABLE IF NOT EXISTS `tourism`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Table `tourism`.`tour_type`
CREATE TABLE IF NOT EXISTS `tourism`.`tour_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Table `tourism`.`client`
CREATE TABLE IF NOT EXISTS `tourism`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- Table `tourism`.`tour_order`
CREATE TABLE IF NOT EXISTS `tourism`.`tour_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `price` DECIMAL(10,2) NULL,
  `country_id` INT NOT NULL,
  `tour_type_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tour_order_country_idx` (`country_id` ASC),
  INDEX `fk_tour_order_tour_type1_idx` (`tour_type_id` ASC),
  INDEX `fk_tour_order_client1_idx` (`client_id` ASC),
  CONSTRAINT `fk_tour_order_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `tourism`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tour_order_tour_type1`
    FOREIGN KEY (`tour_type_id`)
    REFERENCES `tourism`.`tour_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tour_order_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `tourism`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;