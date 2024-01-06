DELIMITER //
CREATE PROCEDURE factorial(IN n INT)
BEGIN
   DECLARE fact BIGINT DEFAULT 1;
   DECLARE i INT DEFAULT 2;
   WHILE i <= n DO
      SET fact = fact * i;
      SET i = i + 1;
   END WHILE;

   SELECT fact AS "Factorial";
END //
DELIMITER ;
CALL factorial(5);



CREATE TABLE Accounts(
   Account_Id VARCHAR(6) PRIMARY KEY CHECK(Account_Id LIKE "AC %"), 
   Name VARCHAR(255) NOT NULL,
   Balance INT NOT NULL
);

INSERT INTO Accounts
VALUES
   ("AC 001", "A", 5000),
   ("AC 002", "B", 10000),
   ("AC 003", "D", 5000),
   ("AC 004", "E", 2000),
   ("AC 005", "C", 250);

UPDATE Accounts
SET Balance =  CASE 
                  WHEN Account_Id = "AC 001" THEN 5000
                  WHEN Account_Id = "AC 002" THEN 10000
                  WHEN Account_Id = "AC 003" THEN 5000
                  WHEN Account_Id = "AC 004" THEN 2000
                  WHEN Account_Id = "AC 005" THEN 250
               END;

SET autocommit = 0;
DELIMITER //
CREATE PROCEDURE Transaction(IN acc_num VARCHAR(6), IN amount INT)
BEGIN
    SELECT * FROM Accounts; 
    SELECT @bal:= Balance FROM Accounts WHERE Account_Id = acc_num;
    IF (@bal - amount < 500) THEN 
        SELECT "TRANSACTION UNSUCCESSFUL" AS "Result";
        ROLLBACK;
    ELSE    
        UPDATE Accounts SET Balance = (Balance - amount) WHERE Account_Id = acc_num;
        SELECT "TRANSACTION SUCCESSFUL" AS "Result";
        SELECT * FROM Accounts;
        COMMIT;
    END IF;    
END //
DELIMITER ;

CALL Transaction("AC 001", 2000);