DELIMITER &&
CREATE PROCEDURE invert_number(IN num INT, OUT inv_num INT)
BEGIN
   DECLARE rem INT;
   SET inv_num = 0;
   WHILE num > 0 DO
      SET rem = num % 10;
      SET inv_num = (inv_num * 10) + rem;
      SET num = FLOOR(num / 10);
   END WHILE;
END &&
DELIMITER ;
CALL invert_number(9635, @inv);
SELECT @inv AS Answer;

DELIMITER &&
CREATE PROCEDURE fibonacci(IN num_terms INT)
BEGIN
   DECLARE a INT DEFAULT 0;
   DECLARE b INT DEFAULT 1;
   DECLARE temp INT;
   DECLARE i INT DEFAULT 0;
   DROP TABLE IF EXISTS fibonacci_output;
   CREATE TABLE fibonacci_output (
      Term INT,
      Fibonacci INT
   );
   WHILE i < num_terms DO
      INSERT INTO fibonacci_output (Term, Fibonacci)
      VALUES (i+1, a);
      SET temp = a + b;
      SET a = b;
      SET b = temp;
      SET i = i + 1;
   END WHILE;
   SELECT * FROM fibonacci_output; 
END &&
DELIMITER ;
CALL fibonacci(10);

DELIMITER //
CREATE PROCEDURE calculate_area(IN r FLOAT)
BEGIN
   DECLARE area FLOAT;
   CREATE TABLE IF NOT EXISTS Areas (
      Radius FLOAT,
      Area FLOAT
   );
   SET area = PI() * POW(r, 2);
   INSERT INTO Areas (Radius, Area)
   VALUES (r, area);
   SELECT * FROM Areas;
END //
DELIMITER ;
CALL calculate_area(3);

