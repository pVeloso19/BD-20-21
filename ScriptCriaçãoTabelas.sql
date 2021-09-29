-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ClinicaBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ClinicaBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ClinicaBD` DEFAULT CHARACTER SET utf8 ;
USE `ClinicaBD` ;

-- -----------------------------------------------------
-- Table `ClinicaBD`.`Clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Clinica` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Posto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Posto` (
  `Id` INT NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Codigo_Postal` VARCHAR(45) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(90) NOT NULL,
  `email` VARCHAR(45) NULL,
  `Clinica` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Posto_Clinica1_idx` (`Clinica` ASC) VISIBLE,
  CONSTRAINT `fk_Posto_Clinica1`
    FOREIGN KEY (`Clinica`)
    REFERENCES `ClinicaBD`.`Clinica` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Laboratorio` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(1) NULL,
  `Clinica` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Laboratorio_Clinica1_idx` (`Clinica` ASC) VISIBLE,
  CONSTRAINT `fk_Laboratorio_Clinica1`
    FOREIGN KEY (`Clinica`)
    REFERENCES `ClinicaBD`.`Clinica` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Cliente` (
  `Numero_Cartao_Cidadao` INT NOT NULL,
  `Data_Nascimento` DATE NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(1) NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Codigo_Postal` VARCHAR(45) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Numero_Cartao_Cidadao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Marcacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Marcacao` (
  `Id` INT NOT NULL,
  `Data_De_Realizacao` DATETIME NOT NULL,
  `Matricula` VARCHAR(45) NULL,
  `Posto` INT NOT NULL,
  `Cliente` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Marcacao_Posto1_idx` (`Posto` ASC) VISIBLE,
  INDEX `fk_Marcacao_Cliente1_idx` (`Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Marcacao_Posto1`
    FOREIGN KEY (`Posto`)
    REFERENCES `ClinicaBD`.`Posto` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Marcacao_Cliente1`
    FOREIGN KEY (`Cliente`)
    REFERENCES `ClinicaBD`.`Cliente` (`Numero_Cartao_Cidadao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Funcionario` (
  `Codigo_Funcionario` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Laboratorio` INT NOT NULL,
  PRIMARY KEY (`Codigo_Funcionario`),
  INDEX `fk_Funcionario_Laboratorio1_idx` (`Laboratorio` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Laboratorio1`
    FOREIGN KEY (`Laboratorio`)
    REFERENCES `ClinicaBD`.`Laboratorio` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Teste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Teste` (
  `Id` INT NOT NULL,
  `Data_Realizacao` DATETIME NOT NULL,
  `Tipo` VARCHAR(1) NOT NULL,
  `Data_Analise` DATETIME NOT NULL,
  `Resultado` VARCHAR(1) NOT NULL,
  `Oberservacoes` VARCHAR(128) NULL,
  `Posto` INT NOT NULL,
  `Cliente` INT NOT NULL,
  `Funcionario` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Teste_Posto1_idx` (`Posto` ASC) VISIBLE,
  INDEX `fk_Teste_Cliente1_idx` (`Cliente` ASC) VISIBLE,
  INDEX `fk_Teste_Funcionario1_idx` (`Funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_Teste_Posto1`
    FOREIGN KEY (`Posto`)
    REFERENCES `ClinicaBD`.`Posto` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teste_Cliente1`
    FOREIGN KEY (`Cliente`)
    REFERENCES `ClinicaBD`.`Cliente` (`Numero_Cartao_Cidadao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teste_Funcionario1`
    FOREIGN KEY (`Funcionario`)
    REFERENCES `ClinicaBD`.`Funcionario` (`Codigo_Funcionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`Horario` (
  `Id` INT NOT NULL,
  `Inicio_Manha` TIME NULL,
  `Fim_Manha` TIME NULL,
  `Inicio_Tarde` TIME NULL,
  `Fim_Tarde` TIME NULL,
  `Dia` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`ContactoPosto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`ContactoPosto` (
  `Telefone` VARCHAR(16) NOT NULL,
  `Posto` INT NOT NULL,
  PRIMARY KEY (`Telefone`, `Posto`),
  INDEX `fk_ContactoPosto_Posto1_idx` (`Posto` ASC) VISIBLE,
  CONSTRAINT `fk_ContactoPosto_Posto1`
    FOREIGN KEY (`Posto`)
    REFERENCES `ClinicaBD`.`Posto` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`PostoOperaHorario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`PostoOperaHorario` (
  `Posto` INT NOT NULL,
  `Horario` INT NOT NULL,
  PRIMARY KEY (`Posto`, `Horario`),
  INDEX `fk_Opera_Posto1_idx` (`Posto` ASC) VISIBLE,
  INDEX `fk_Opera_Horario1_idx` (`Horario` ASC) VISIBLE,
  CONSTRAINT `fk_Opera_Posto1`
    FOREIGN KEY (`Posto`)
    REFERENCES `ClinicaBD`.`Posto` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Opera_Horario1`
    FOREIGN KEY (`Horario`)
    REFERENCES `ClinicaBD`.`Horario` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ClinicaBD`.`ContactoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ClinicaBD`.`ContactoCliente` (
  `Telefone` VARCHAR(16) NOT NULL,
  `Cliente` INT NOT NULL,
  PRIMARY KEY (`Telefone`, `Cliente`),
  INDEX `fk_ContactoCliente_Cliente_idx` (`Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_ContactoCliente_Cliente`
    FOREIGN KEY (`Cliente`)
    REFERENCES `ClinicaBD`.`Cliente` (`Numero_Cartao_Cidadao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
