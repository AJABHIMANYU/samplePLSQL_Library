-- library_mgmt_pkg.pkb
-- Package body implementing library management operations

CREATE OR REPLACE PACKAGE BODY library_mgmt_pkg AS
  PROCEDURE loginCustomer_library(user IN VARCHAR2, pass IN VARCHAR2) IS
    passAux customer.password%TYPE;
    incorrect_password EXCEPTION;
  BEGIN
    SELECT password INTO passAux
    FROM customer
    WHERE userName = user;
    IF passAux = pass THEN
      DBMS_OUTPUT.PUT_LINE('User ' || user || ' login successful');
    ELSE
      RAISE incorrect_password;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND OR incorrect_password THEN
      DBMS_OUTPUT.PUT_LINE('Incorrect username or password');
  END;

  PROCEDURE loginEmployee_library(user IN VARCHAR2, pass IN VARCHAR2) IS
    passAux employee.password%TYPE;
    incorrect_password EXCEPTION;
  BEGIN
    SELECT password INTO passAux
    FROM employee
    WHERE userName = user;
    IF passAux = pass THEN
      DBMS_OUTPUT.PUT_LINE('User ' || user || ' login successful');
    ELSE
      RAISE incorrect_password;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND OR incorrect_password THEN
      DBMS_OUTPUT.PUT_LINE('Incorrect username or password');
  END;

  PROCEDURE viewItem_library(auxItemID IN VARCHAR2) IS
    auxISBN VARCHAR2(4);
    auxTitle VARCHAR2(50);
    auxYear NUMBER;
    auxState VARCHAR2(10);
    auxDebyCost NUMBER(10,2);
    auxLostCost NUMBER(10,2);
    auxAddress VARCHAR2(50);
    auxAbala VARCHAR2(1);
    auxVideo NUMBER;
    auxBook NUMBER;
  BEGIN
    SELECT COUNT(*) INTO auxBook FROM book WHERE bookID = auxItemID;
    SELECT COUNT(*) INTO auxVideo FROM video WHERE videoID = auxItemID;
    IF auxBook > 0 THEN
      SELECT isbn, state, avalability, debyCost, lostCost, address
      INTO auxISBN, auxState, auxAbala, auxDebyCost, auxLostCost, auxAddress
      FROM book WHERE bookID = auxItemID;
      DBMS_OUTPUT.PUT_LINE('BOOK ' || auxItemID || ' INFO');
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('ISBN: ' || auxISBN);
      DBMS_OUTPUT.PUT_LINE('STATE: ' || auxState);
      DBMS_OUTPUT.PUT_LINE('AVALABILITY: ' || auxAbala);
      DBMS_OUTPUT.PUT_LINE('DEBY COST: ' || auxDebyCost);
      DBMS_OUTPUT.PUT_LINE('LOST COST: ' || auxLostCost);
      DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || auxAddress);
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    ELSIF auxVideo > 0 THEN
      SELECT title, year, state, avalability, debyCost, lostCost, address
      INTO auxTitle, auxYear, auxState, auxAbala, auxDebyCost, auxLostCost, auxAddress
      FROM video WHERE videoID = auxItemID;
      DBMS_OUTPUT.PUT_LINE('VIDEO ' || auxItemID || ' INFO');
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('TITLE: ' || auxTitle);
      DBMS_OUTPUT.PUT_LINE('YEAR: ' || auxYear);
      DBMS_OUTPUT.PUT_LINE('STATE: ' || auxState);
      DBMS_OUTPUT.PUT_LINE('AVALABILITY: ' || auxAbala);
      DBMS_OUTPUT.PUT_LINE('DEBY COST: ' || auxDebyCost);
      DBMS_OUTPUT.PUT_LINE('LOST COST: ' || auxLostCost);
      DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || auxAddress);
      DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Item not found');
    END IF;
  END;

  PROCEDURE customerAccount_library(custoID IN customer.customerID%TYPE) IS
    auxCard NUMBER;
    auxFines NUMBER;
    auxItem VARCHAR2(6);
    rented NUMBER := 0;
  BEGIN
    SELECT cardNumber INTO auxCard FROM customer WHERE customerID = custoID;
    SELECT COUNT(*) INTO rented FROM rent WHERE cardID = auxCard;
    DBMS_OUTPUT.PUT_LINE('The user card is ' || auxCard);
    IF rented > 0 THEN
      SELECT itemID INTO auxItem FROM rent WHERE cardID = auxCard AND ROWNUM = 1;
      DBMS_OUTPUT.PUT_LINE('The user has ' || auxItem || ' rented');
    ELSE
      DBMS_OUTPUT.PUT_LINE('This user has no rents');
    END IF;
    SELECT fines INTO auxFines FROM card WHERE cardID = auxCard;
    DBMS_OUTPUT.PUT_LINE('The user fines are ' || auxFines);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('NOT DATA FOUND');
  END;

  PROCEDURE employeeAccount_library(emploID IN employee.employeeID%TYPE) IS
    auxCard NUMBER;
    auxFines NUMBER;
    auxItem VARCHAR2(6);
    rented NUMBER := 0;
  BEGIN
    SELECT cardNumber INTO auxCard FROM employee WHERE employeeID = emploID;
    SELECT COUNT(*) INTO rented FROM rent WHERE cardID = auxCard;
    DBMS_OUTPUT.PUT_LINE('The user card is ' || auxCard);
    IF rented > 0 THEN
      SELECT itemID INTO auxItem FROM rent WHERE cardID = auxCard AND ROWNUM = 1;
      DBMS_OUTPUT.PUT_LINE('The user has ' || auxItem || ' rented');
    ELSE
      DBMS_OUTPUT.PUT_LINE('This user has no rents');
    END IF;
    SELECT fines INTO auxFines FROM card WHERE cardID = auxCard;
    DBMS_OUTPUT.PUT_LINE('The user fines are ' || auxFines);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('NOT DATA FOUND');
  END;

  PROCEDURE rentItem_library(auxCard IN NUMBER, auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE) IS
    statusAux VARCHAR2(1);
    itemStatus VARCHAR2(1);
  BEGIN
    SELECT status INTO statusAux FROM card WHERE cardID = auxCard;
    IF statusAux = 'A' THEN
      IF itemType = 'book' THEN
        SELECT avalability INTO itemStatus FROM book WHERE bookID = auxItemID;
        IF itemStatus = 'A' THEN
          UPDATE book SET avalability = 'O' WHERE bookID = auxItemID;
          INSERT INTO rent VALUES (auxCard, auxItemID, SYSDATE, auxDate);
          DBMS_OUTPUT.PUT_LINE('Item ' || auxItemID || ' rented');
        ELSE
          DBMS_OUTPUT.PUT_LINE('The item is already rented');
        END IF;
      ELSIF itemType = 'video' THEN
        SELECT avalability INTO itemStatus FROM video WHERE videoID = auxItemID;
        IF itemStatus = 'A' THEN
          UPDATE video SET avalability = 'O' WHERE videoID = auxItemID;
          INSERT INTO rent VALUES (auxCard, auxItemID, SYSDATE, auxDate);
          DBMS_OUTPUT.PUT_LINE('Item ' || auxItemID || ' rented');
        ELSE
          DBMS_OUTPUT.PUT_LINE('The item is already rented');
        END IF;
      ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid item type');
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('The user is blocked');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Card or item not found');
  END;

  PROCEDURE payFines_library(auxCard IN card.cardID%TYPE, money IN NUMBER) IS
    finesAmount NUMBER;
    total NUMBER;
  BEGIN
    SELECT fines INTO finesAmount FROM card WHERE cardID = auxCard;
    IF finesAmount < money THEN
      total := money - finesAmount;
      DBMS_OUTPUT.PUT_LINE('YOU PAY ALL YOUR FINES AND YOU HAVE ' || total || ' MONEY BACK');
      UPDATE card SET status = 'A', fines = 0 WHERE cardID = auxCard;
    ELSIF finesAmount = money THEN
      total := money - finesAmount;
      DBMS_OUTPUT.PUT_LINE('YOU PAY ALL YOUR FINES');
      UPDATE card SET status = 'A', fines = 0 WHERE cardID = auxCard;
    ELSE
      total := finesAmount - money;
      DBMS_OUTPUT.PUT_LINE('YOU WILL NEED TO PAY ' || total || ' MORE DOLLARS TO UNLOCK YOUR CARD');
      UPDATE card SET fines = total WHERE cardID = auxCard;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Card not found');
  END;

  PROCEDURE updateInfoCusto_library(auxCustomer IN customer.customerID%TYPE, pNumber IN NUMBER, address IN VARCHAR2, newPass IN VARCHAR2) IS
  BEGIN
    UPDATE customer
    SET phone = pNumber, customerAddress = address, password = newPass
    WHERE customerID = auxCustomer;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Customer not found');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Customer information updated');
  END;

  PROCEDURE updateInfoEmp_library(auxEmployee IN employee.employeeID%TYPE, pNumber IN NUMBER, address IN VARCHAR2, newPass IN VARCHAR2, newPayCheck IN NUMBER, newBranch IN VARCHAR2) IS
  BEGIN
    UPDATE employee
    SET phone = pNumber, employeeAddress = address, password = newPass, paycheck = newPayCheck, branchName = newBranch
    WHERE employeeID = auxEmployee;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Employee not found');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee information updated');
  END;

  PROCEDURE addCustomer_library(auxCustomerId IN NUMBER, auxName IN VARCHAR2, auxCustomerAddress IN VARCHAR2, auxPhone IN NUMBER, auxPass IN VARCHAR2, auxUserName IN VARCHAR2, auxCardNumber IN NUMBER) IS
  BEGIN
    INSERT INTO customer
    VALUES (auxCustomerId, auxName, auxCustomerAddress, auxPhone, auxPass, auxUserName, SYSDATE, auxCardNumber);
    DBMS_OUTPUT.PUT_LINE('Customer added successfully');
  END;

  PROCEDURE allMedia_library(mediaType IN VARCHAR2) IS
    CURSOR cBooks IS SELECT * FROM book;
    CURSOR cVideos IS SELECT * FROM video;
    xBooks cBooks%ROWTYPE;
    xVideos cVideos%ROWTYPE;
  BEGIN
    IF mediaType = 'books' THEN
      OPEN cBooks;
      DBMS_OUTPUT.PUT_LINE('ISBN     ID     STATE     AVALABILITY     DEBY_COST     LOST_COST    LOCATION');
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
      LOOP
        FETCH cBooks INTO xBooks;
        EXIT WHEN cBooks%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(xBooks.isbn || '     ' || xBooks.bookID || '     ' || xBooks.state || '     ' || xBooks.avalability || '     ' || xBooks.debyCost || '     ' || xBooks.lostCost || '     ' || xBooks.address);
      END LOOP;
      CLOSE cBooks;
    ELSIF mediaType = 'videos' THEN
      OPEN cVideos;
      DBMS_OUTPUT.PUT_LINE('TITLE     YEAR     ID     STATE     AVALABILITY     DEBY_COST     LOST_COST    LOCATION');
      DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------');
      LOOP
        FETCH cVideos INTO xVideos;
        EXIT WHEN cVideos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(xVideos.title || '     ' || xVideos.year || '     ' || xVideos.videoID || '     ' || xVideos.state || '     ' || xVideos.avalability || '     ' || xVideos.debyCost || '     ' || xVideos.lostCost || '     ' || xVideos.address);
      END LOOP;
      CLOSE cVideos;
    ELSE
      DBMS_OUTPUT.PUT_LINE('TYPE INCORRECT, you must choose between books or videos');
    END IF;
  END;

  PROCEDURE handleReturns_library(auxItemID IN VARCHAR2) IS
    auxRented NUMBER;
    auxBook NUMBER;
    auxVideo NUMBER;
  BEGIN
    SELECT COUNT(*) INTO auxRented FROM rent WHERE itemID = auxItemID;
    SELECT COUNT(*) INTO auxBook FROM book WHERE bookID = auxItemID;
    SELECT COUNT(*) INTO auxVideo FROM video WHERE videoID = auxItemID;
    IF auxRented > 0 THEN
      DELETE FROM rent WHERE itemID = auxItemID;
      IF auxBook > 0 THEN
        UPDATE book SET avalability = 'A' WHERE bookID = auxItemID;
        DBMS_OUTPUT.PUT_LINE('The book ' || auxItemID || ' is now available.');
      ELSIF auxVideo > 0 THEN
        UPDATE video SET avalability = 'A' WHERE videoID = auxItemID;
        DBMS_OUTPUT.PUT_LINE('The video ' || auxItemID || ' is now available.');
      END IF;
    ELSE
      DBMS_OUTPUT.PUT_LINE('This item is not rented at the moment');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Item ID incorrect');
  END;

  PROCEDURE addBook_library(auxISBN IN VARCHAR2, auxBookID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER, auxLostCost IN NUMBER, auxAddress IN VARCHAR2) IS
  BEGIN
    INSERT INTO book VALUES (auxISBN, auxBookID, auxState, 'A', auxDebyCost, auxLostCost, auxAddress);
    DBMS_OUTPUT.PUT_LINE('Book inserted correctly');
  END;

  PROCEDURE addVideo_library(auxTitle IN VARCHAR2, auxYear IN INT, auxVideoID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER, auxLostCost IN NUMBER, auxAddress IN VARCHAR2) IS
  BEGIN
    INSERT INTO video VALUES (auxTitle, auxYear, auxVideoID, auxState, 'A', auxDebyCost, auxLostCost, auxAddress);
    DBMS_OUTPUT.PUT_LINE('Video inserted correctly');
  END;

  PROCEDURE removeItem_library(auxItemID IN VARCHAR2) IS
    auxBook NUMBER;
    auxVideo NUMBER;
  BEGIN
    SELECT COUNT(*) INTO auxBook FROM book WHERE bookID = auxItemID;
    SELECT COUNT(*) INTO auxVideo FROM video WHERE videoID = auxItemID;
    IF auxBook > 0 THEN
      DELETE FROM book WHERE bookID = auxItemID;
      DBMS_OUTPUT.PUT_LINE('Book removed correctly');
    ELSIF auxVideo > 0 THEN
      DELETE FROM video WHERE videoID = auxItemID;
      DBMS_OUTPUT.PUT_LINE('Video removed correctly');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Item not found');
    END IF;
  END;

  PROCEDURE viewCustomer_library(auxCustomerID IN NUMBER) IS
    custoName VARCHAR2(40);
    custoAdd VARCHAR2(50);
    custoPhone NUMBER(9);
    userNaM VARCHAR2(10);
    custoDate DATE;
    custoCard NUMBER;
  BEGIN
    SELECT name, customerAddress, phone, userName, dateSignUp, cardNumber
    INTO custoName, custoAdd, custoPhone, userNaM, custoDate, custoCard
    FROM customer WHERE customerID = auxCustomerID;
    DBMS_OUTPUT.PUT_LINE('CUSTOMER ' || auxCustomerID || ' INFO');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('NAME: ' || custoName);
    DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || custoAdd);
    DBMS_OUTPUT.PUT_LINE('PHONE: ' || custoPhone);
    DBMS_OUTPUT.PUT_LINE('USER NAME: ' || userNaM);
    DBMS_OUTPUT.PUT_LINE('DATE OF SIGN UP: ' || custoDate);
    DBMS_OUTPUT.PUT_LINE('CARD NUMBER: ' || custoCard);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Customer not found');
  END;
END library_mgmt_pkg;
/
