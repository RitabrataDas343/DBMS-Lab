SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Bank Branch`;
DROP TABLE IF EXISTS `System Administrator`;
DROP TABLE IF EXISTS `Customer`;
DROP TABLE IF EXISTS `Account`;
DROP TABLE IF EXISTS `ATM`;
DROP TABLE IF EXISTS `Transaction Logs`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Bank Branch` (
    `IFSC Code` VARCHAR(20) NOT NULL,
    `Branch Name` VARCHAR(255) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    `Manager` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`IFSC Code`),
    UNIQUE (`IFSC Code`)
);

CREATE TABLE `System Administrator` (
    `System ID` VARCHAR(10) NOT NULL,
    `Password` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`System ID`)
);

CREATE TABLE `Customer` (
    `Customer ID` VARCHAR(10) NOT NULL,
    `Name` VARCHAR(100) NOT NULL,
    `Date of Birth` DATETIME NOT NULL,
    `Account Number` VARCHAR(16) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `Phone Number` NUMERIC(15) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    `IFSC Code` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`Customer ID`),
    UNIQUE (`Email`, `Phone Number`)
);

CREATE TABLE `Account` (
    `Account Number` VARCHAR(16) NOT NULL,
    `Customer Name` VARCHAR(100) NOT NULL,
    `Account Type` VARCHAR(30) NOT NULL,
    `Amount of Money` BIGINT(255) NOT NULL,
    `Date of Creation` DATETIME NOT NULL,
    PRIMARY KEY (`Account Number`)
);

CREATE TABLE `ATM` (
    `Account Number` VARCHAR(16) NOT NULL,
    `Pin` NUMERIC(4) NOT NULL,
    PRIMARY KEY (`Account Number`),
    UNIQUE (`Account Number`)
);

CREATE TABLE `Transaction Logs` (
    `Account Number` VARCHAR(16) NOT NULL,
    `Number of Transactions` BIGINT(255) NOT NULL,
    `Transaction Flag` BOOLEAN NOT NULL,
    `Amount Deposited` BIGINT(255) NOT NULL,
    `Amount Withdrawn` BIGINT(255) NOT NULL,
    PRIMARY KEY (`Account Number`)
);

ALTER TABLE `Customer` ADD FOREIGN KEY (`Account Number`) REFERENCES `Account`(`Account Number`);
ALTER TABLE `Customer` ADD FOREIGN KEY (`IFSC Code`) REFERENCES `Bank Branch`(`IFSC Code`);
ALTER TABLE `ATM` ADD FOREIGN KEY (`Account Number`) REFERENCES `Account`(`Account Number`);
ALTER TABLE `Transaction Logs` ADD FOREIGN KEY (`Account Number`) REFERENCES `Account`(`Account Number`);