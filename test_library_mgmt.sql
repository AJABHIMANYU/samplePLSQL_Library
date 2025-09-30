-- test_library_mgmt.sql
-- Tests all library management operations

SET SERVEROUTPUT ON;

-- Insert sample data
BEGIN
  INSERT INTO Location VALUES ('ARCHEOLOGY ROAD');
  INSERT INTO Location VALUES ('CHEMISTRY ROAD');
  INSERT INTO Location VALUES ('COMPUTING ROAD');
  INSERT INTO Location VALUES ('PHYSICS ROAD');

  INSERT INTO Branch VALUES ('ARCHEOLOGY', 'ARCHEOLOGY ROAD', 645645645);
  INSERT INTO Branch VALUES ('CHEMISTRY', 'CHEMISTRY ROAD', 622622622);
  INSERT INTO Branch VALUES ('COMPUTING', 'COMPUTING ROAD', 644644644);
  INSERT INTO Branch VALUES ('PHYSICS', 'PHYSICS ROAD', 666666666);

  INSERT INTO Card VALUES (101, 'A', 0);
  INSERT INTO Card VALUES (102, 'A', 0);
  INSERT INTO Card VALUES (103, 'A', 0);
  INSERT INTO Card VALUES (104, 'A', 0);
  INSERT INTO Card VALUES (105, 'A', 0);
  INSERT INTO Card VALUES (106, 'A', 0);
  INSERT INTO Card VALUES (107, 'B', 50);
  INSERT INTO Card VALUES (108, 'B', 10);
  INSERT INTO Card VALUES (109, 'B', 25.5);
  INSERT INTO Card VALUES (110, 'B', 15.25);
  INSERT INTO Card VALUES (151, 'A', 0);
  INSERT INTO Card VALUES (152, 'A', 0);
  INSERT INTO Card VALUES (153, 'A', 0);
  INSERT INTO Card VALUES (154, 'A', 0);
  INSERT INTO Card VALUES (155, 'A', 0);

  INSERT INTO Customer VALUES (1, 'ALFRED', 'BACON STREET', 623623623, 'alfred123', 'al1', '12-05-2018', 101);
  INSERT INTO Customer VALUES (2, 'JAMES', 'DOWNTOWN ABBEY', 659659659, 'james123', 'ja2', '10-05-2018', 102);
  INSERT INTO Customer VALUES (3, 'GEORGE', 'DETROIT CITY', 654654654, 'george123', 'ge3', '21-06-2017', 103);
  INSERT INTO Customer VALUES (4, 'TOM', 'WASHINGTON DC.', 658658658, 'tom123', 'tom4', '05-12-2016', 104);
  INSERT INTO Customer VALUES (5, 'PETER', 'CASTERLY ROCK', 652652652, 'peter123', 'pe5', '09-08-2016', 105);
  INSERT INTO Customer VALUES (6, 'JENNY', 'TERRAKOTA', 651651651, 'jenny123', 'je6', '30-04-2017', 106);
  INSERT INTO Customer VALUES (7, 'ROSE', 'SWEET HOME ALABAMA', 657657657, 'rose123', 'ro7', '28-02-2018', 107);
  INSERT INTO Customer VALUES (8, 'MONICA', 'FAKE STREET 123', 639639639, 'monica123', 'mo8', '15-01-2016', 108);
  INSERT INTO Customer VALUES (9, 'PHOEBE', 'CENTRAL PERK', 678678678, 'phoebe123', 'pho9', '25-03-2016', 109);
  INSERT INTO Customer VALUES (10, 'RACHEL', 'WHEREVER', 687687687, 'rachel123', 'ra10', '01-09-2017', 110);

  INSERT INTO Employee VALUES (211, 'ROSS', 'HIS HOUSE', 671671671, 'ross123', 'ro11', 1200, 'ARCHEOLOGY', 151);
  INSERT INTO Employee VALUES (212, 'CHANDLER', 'OUR HEARTHS', 688688688, 'chandler123', 'chand12', 1150.50, 'ARCHEOLOGY', 152);
  INSERT INTO Employee VALUES (213, 'JOEY', 'LITTLE ITALY', 628628628, 'joey123', 'jo13', 975.75, 'ARCHEOLOGY', 153);
  INSERT INTO Employee VALUES (214, 'VICTOR', 'SANTA FE', 654321987, 'victor123', 'vic14', 2200, 'COMPUTING', 154);
  INSERT INTO Employee VALUES (215, 'JAIRO', 'ARMILLA', 698754321, 'jairo123', 'ja15', 2200.50, 'CHEMISTRY', 155);

  INSERT INTO Book VALUES ('A123', 'B1A123', 'GOOD', 'A', 5, 20, 'ARCHEOLOGY ROAD');
  INSERT INTO Book VALUES ('A123', 'B2A123', 'NEW', 'O', 6, 30, 'ARCHEOLOGY ROAD');
  INSERT INTO Book VALUES ('B234', 'B1B234', 'NEW', 'A', 2, 15, 'CHEMISTRY ROAD');
  INSERT INTO Book VALUES ('C321', 'B1C321', 'BAD', 'A', 1, 10, 'PHYSICS ROAD');
  INSERT INTO Book VALUES ('H123', 'B1H123', 'GOOD', 'A', 3, 15, 'CHEMISTRY ROAD');
  INSERT INTO Book VALUES ('Z123', 'B1Z123', 'GOOD', 'O', 4, 20, 'COMPUTING ROAD');
  INSERT INTO Book VALUES ('L321', 'B1L321', 'NEW', 'O', 4, 20, 'COMPUTING ROAD');
  INSERT INTO Book VALUES ('P321', 'B1P321', 'USED', 'A', 2, 12, 'CHEMISTRY ROAD');

  INSERT INTO Video VALUES ('CHEMISTRY FOR DUMMIES', 2016, 'V1CH16', 'NEW', 'O', 10, 50, 'CHEMISTRY ROAD');
  INSERT INTO Video VALUES ('CHEMISTRY FOR DUMMIES', 2016, 'V2CH16', 'BAD', 'A', 5, 20, 'CHEMISTRY ROAD');
  INSERT INTO Video VALUES ('COMPUTING MANAGER', 2014, 'V1CO14', 'GOOD', 'A', 4, 20, 'COMPUTING ROAD');
  INSERT INTO Video VALUES ('JAVA LANGUAGE', 2015, 'V1JA15', 'USED', 'O', 4, 20, 'COMPUTING ROAD');
  INSERT INTO Video VALUES ('DINOSAURS', 2000, 'V1DI00', 'GOOD', 'O', 5, 25, 'ARCHEOLOGY ROAD');
  INSERT INTO Video VALUES ('T-REX, DEADLY KING', 1992, 'V1TR92', 'USED', 'A', 10, 50, 'ARCHEOLOGY ROAD');
  INSERT INTO Video VALUES ('ANCESTORS OF THE HUMANITY', 1998, 'V1AN98', 'BAD', 'A', 3, 15, 'ARCHEOLOGY ROAD');
  INSERT INTO Video VALUES ('PHYSICS, MOST BORING SH*T', 2018, 'V1PH18', 'NEW', 'A', 1, 5, 'PHYSICS ROAD');

  INSERT INTO Rent VALUES (101, 'B2A123', '10-05-2018', '20-05-2018');
  INSERT INTO Rent VALUES (102, 'B1Z123', '10-05-2018', '25-05-2018');
  INSERT INTO Rent VALUES (104, 'V1JA15', '01-05-2018', '21-05-2018');
  INSERT INTO Rent VALUES (105, 'V1DI00', '02-05-2018', '25-05-2018');
  INSERT INTO Rent VALUES (154, 'B1L321', '04-05-2018', '26-05-2018');
  INSERT INTO Rent VALUES (155, 'V1CH16', '29-04-2018', '29-05-2018');

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Sample data inserted successfully');
END;
/

-- Test procedures
DECLARE
  v_director director_library;
BEGIN
  -- Test customer login
  DBMS_OUTPUT.PUT_LINE('Testing customer login for al1');
  library_mgmt_pkg.loginCustomer_library('al1', 'alfred123');
  
  -- Test employee login
  DBMS_OUTPUT.PUT_LINE('Testing employee login for ro11');
  library_mgmt_pkg.loginEmployee_library('ro11', 'ross123');

  -- Test view item
  DBMS_OUTPUT.PUT_LINE('Testing view item B1A123 (book)');
  library_mgmt_pkg.viewItem_library('B1A123');

  -- Test customer account
  DBMS_OUTPUT.PUT_LINE('Testing customer account for ID 1');
  library_mgmt_pkg.customerAccount_library(1);

  -- Test employee account
  DBMS_OUTPUT.PUT_LINE('Testing employee account for ID 211');
  library_mgmt_pkg.employeeAccount_library(211);

  -- Test rent item
  DBMS_OUTPUT.PUT_LINE('Testing rent book B1H123 with card 101');
  library_mgmt_pkg.rentItem_library(101, 'B1H123', 'book', TO_DATE('30-09-2025', 'DD-MM-YYYY'));

  -- Test pay fines
  DBMS_OUTPUT.PUT_LINE('Testing pay fines for card 107 with 60');
  library_mgmt_pkg.payFines_library(107, 60);

  -- Test update customer info
  DBMS_OUTPUT.PUT_LINE('Testing update customer info for ID 1');
  library_mgmt_pkg.updateInfoCusto_library(1, 623623623, 'NEW BACON STREET', 'newpass123');

  -- Test update employee info
  DBMS_OUTPUT.PUT_LINE('Testing update employee info for ID 211');
  library_mgmt_pkg.updateInfoEmp_library(211, 671671671, 'NEW HOUSE', 'newross123', 1300, 'CHEMISTRY');

  -- Test add customer
  DBMS_OUTPUT.PUT_LINE('Testing add customer');
  library_mgmt_pkg.addCustomer_library(customer_seq.NEXTVAL, 'MARI CARMEN', 'CORDOBA', 645892456, 'maricarmen123', 'ma11', card_seq.NEXTVAL);

  -- Test all media
  DBMS_OUTPUT.PUT_LINE('Testing all books');
  library_mgmt_pkg.allMedia_library('books');
  DBMS_OUTPUT.PUT_LINE('Testing all videos');
  library_mgmt_pkg.allMedia_library('videos');

  -- Test handle returns
  DBMS_OUTPUT.PUT_LINE('Testing handle return for B2A123');
  library_mgmt_pkg.handleReturns_library('B2A123');

  -- Test add book
  DBMS_OUTPUT.PUT_LINE('Testing add book');
  library_mgmt_pkg.addBook_library('X789', 'B1X789', 'NEW', 3, 15, 'PHYSICS ROAD');

  -- Test add video
  DBMS_OUTPUT.PUT_LINE('Testing add video');
  library_mgmt_pkg.addVideo_library('NEW VIDEO', 2020, 'V1NV20', 'NEW', 5, 25, 'COMPUTING ROAD');

  -- Test remove item
  DBMS_OUTPUT.PUT_LINE('Testing remove item B1P321');
  library_mgmt_pkg.removeItem_library('B1P321');

  -- Test view customer
  DBMS_OUTPUT.PUT_LINE('Testing view customer for ID 1');
  library_mgmt_pkg.viewCustomer_library(1);

  -- Test director object
  DBMS_OUTPUT.PUT_LINE('Testing director object');
  v_director := director_library(212, 'CHANDLER', 'OUR HEARTHS', 688688688, 1150.5, 500);
  DBMS_OUTPUT.PUT_LINE('DIRECTOR ID: ' || v_director.employeeID);
  DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('NAME: ' || v_director.name);
  DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || v_director.address);
  DBMS_OUTPUT.PUT_LINE('PHONE: ' || v_director.phone);
  DBMS_OUTPUT.PUT_LINE('PAYCHECK: ' || v_director.paycheck);
  DBMS_OUTPUT.PUT_LINE('EXTRA: ' || v_director.extraPaycheck);
  DBMS_OUTPUT.PUT_LINE('--------------------------------------------');

  -- Display final state
  DBMS_OUTPUT.PUT_LINE('Final state of tables:');
  FOR rec IN (SELECT * FROM customer) LOOP
    DBMS_OUTPUT.PUT_LINE('Customer: ID=' || rec.customerID || ', Name=' || rec.name || ', Card=' || rec.cardNumber);
  END LOOP;
  FOR rec IN (SELECT * FROM rent) LOOP
    DBMS_OUTPUT.PUT_LINE('Rent: CardID=' || rec.cardID || ', ItemID=' || rec.itemID || ', ReturnDate=' || TO_CHAR(rec.returnDate, 'DD-MON-YYYY'));
  END LOOP;
  FOR rec IN (SELECT * FROM card) LOOP
    DBMS_OUTPUT.PUT_LINE('Card: ID=' || rec.cardID || ', Status=' || rec.status || ', Fines=' || rec.fines);
  END LOOP;
END;
/
