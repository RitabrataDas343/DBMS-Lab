CREATE TABLE Accounts (
  account_number INTEGER PRIMARY KEY,
  account_holder TEXT NOT NULL,
  balance FLOAT NOT NULL CHECK(balance >= 0)
);

CREATE TABLE Transactions (
  transaction_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  from_account INTEGER NOT NULL,
  to_account INTEGER NOT NULL,
  amount FLOAT NOT NULL CHECK (amount >= 0),
  transaction_date DATE NOT NULL,
  FOREIGN KEY (from_account) REFERENCES Accounts(account_number),
  FOREIGN KEY (to_account) REFERENCES Accounts(account_number)
);

INSERT INTO Accounts 
VALUES 
(1234, 'A', 5000),
(3456, 'B', 6000),
(5678, 'C', 3000);

SET autocommit = 0;
DELIMITER &&
CREATE PROCEDURE Transaction1()
BEGIN
    DECLARE s FLOAT;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions;
    SELECT @bal1234:= balance FROM Accounts WHERE account_number = 1234;
    SELECT @bal5678:= balance FROM Accounts WHERE account_number = 5678;
    SET s = @bal1234 + @bal5678;
    UPDATE Accounts SET balance = (balance - 100) WHERE account_number = 1234;
    UPDATE Accounts SET balance = (balance + 100) WHERE account_number = 5678;
    IF (((@bal1234 + @bal5678) != s) OR (@bal1234 < 100)) THEN 
        SELECT "TRANSACTION UNSUCCESSFUL" AS "Result";
        ROLLBACK;
    ELSE
        INSERT INTO Transactions (from_account, to_account, amount, transaction_date)
            VALUES (1234, 5678, 100, CURRENT_DATE);
        SELECT "TRANSACTION SUCCESSFUL" AS "Result";
        COMMIT;
    END IF;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions;
END &&
DELIMITER ;
CALL Transaction1();



SET autocommit = 0;
DELIMITER &&
CREATE PROCEDURE Transaction2()
BEGIN
    DECLARE s FLOAT;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions;
    SELECT @balA:= balance FROM Accounts WHERE account_holder = 'A';
    SELECT @balB:= balance FROM Accounts WHERE account_holder = 'B';
    SET s = @balA + @balB;
    UPDATE Accounts SET balance = (balance - 500) WHERE account_holder = 'A';
    UPDATE Accounts SET balance = (balance + 500) WHERE account_holder = 'B';
    IF ((@balA < 500) OR ((@balA + @balB) != s)) THEN 
        SELECT "TRANSACTION UNSUCCESSFUL" AS "Result";
        ROLLBACK;
    ELSE
        INSERT INTO Transactions(from_account, to_account, amount, transaction_date)
        VALUES ((SELECT account_number FROM Accounts WHERE account_holder = 'A'),
                (SELECT account_number FROM Accounts WHERE account_holder = 'B'),
                500,
                CURRENT_DATE);
        SELECT "TRANSACTION SUCCESSFUL" AS "Result";
        COMMIT;
    END IF;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions;
END &&
DELIMITER ;
CALL Transaction2();


SET autocommit = 0;
DELIMITER &&
CREATE PROCEDURE Transaction3(IN curr_date DATE)
BEGIN
    DECLARE s FLOAT;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions; 
    SELECT @bal1234:= balance FROM Accounts WHERE account_number = 1234;
    SELECT @bal5678:= balance FROM Accounts WHERE account_number = 5678;
    SET s = @bal1234 + @bal5678;
    UPDATE Accounts SET balance = (balance - 1000) WHERE account_number = 1234;
    UPDATE Accounts SET balance = (balance + 1000) WHERE account_number = 5678;
    IF (@bal1234 < 1000 OR @bal5678 > 5000 OR @curr_date > CURRENT_DATE OR (@bal1234 + @bal5678) != s) THEN 
        SELECT "TRANSACTION UNSUCCESSFUL" AS "Result";
        ROLLBACK;
    ELSE
        INSERT INTO Transactions(from_account, to_account, amount, transaction_date)
            VALUES (1234, 5678, 1000, CURRENT_DATE);
        SELECT "TRANSACTION SUCCESSFUL" AS "Result";
        COMMIT;
    END IF;
    SELECT * FROM Accounts;
    SELECT * FROM Transactions;
END &&
DELIMITER ;
CALL Transaction3('2023-04-05');

