-- triggers.sql
-- Triggers for automating card creation and fine updates

CREATE OR REPLACE TRIGGER addCardCusto_library
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
  INSERT INTO card VALUES (:new.cardNumber, 'A', 0);
  DBMS_OUTPUT.PUT_LINE('Card created for customer');
END;
/

CREATE OR REPLACE TRIGGER addCardEmp_library
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
  INSERT INTO card VALUES (:new.cardNumber, 'A', 0);
  DBMS_OUTPUT.PUT_LINE('Card created for employee');
END;
/

CREATE OR REPLACE TRIGGER modifyFines_library
AFTER DELETE ON rent
FOR EACH ROW
DECLARE
  auxCardID NUMBER;
  auxItemID VARCHAR2(6);
  auxBook NUMBER;
  auxVideo NUMBER;
  auxDeby NUMBER;
BEGIN
  auxCardID := :old.cardID;
  auxItemID := :old.itemID;

  SELECT COUNT(*) INTO auxBook
  FROM book
  WHERE bookID = auxItemID;

  SELECT COUNT(*) INTO auxVideo
  FROM video
  WHERE videoID = auxItemID;

  IF SYSDATE > :old.returnDate THEN
    IF auxVideo > 0 THEN
      SELECT debyCost INTO auxDeby
      FROM video
      WHERE videoID = auxItemID;
    ELSIF auxBook > 0 THEN
      SELECT debyCost INTO auxDeby
      FROM book
      WHERE bookID = auxItemID;
    END IF;

    UPDATE card
    SET status = 'B', fines = fines + auxDeby
    WHERE cardID = auxCardID;
    DBMS_OUTPUT.PUT_LINE('Fines updated for card ' || auxCardID);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Item returned before deadline');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error in fine calculation: Item or card not found');
END;
/
