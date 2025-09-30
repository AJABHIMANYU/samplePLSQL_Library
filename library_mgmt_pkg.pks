-- library_mgmt_pkg.pks
-- Package specification for library management operations

CREATE OR REPLACE TYPE director_library AS OBJECT (
  employeeID NUMBER,
  name VARCHAR2(40),
  address VARCHAR2(50),
  phone INT,
  paycheck NUMBER(10,2),
  extraPaycheck NUMBER(10,2)
);
/

CREATE OR REPLACE PACKAGE library_mgmt_pkg AS
  PROCEDURE loginCustomer_library(user IN VARCHAR2, pass IN VARCHAR2);
  PROCEDURE loginEmployee_library(user IN VARCHAR2, pass IN VARCHAR2);
  PROCEDURE viewItem_library(auxItemID IN VARCHAR2);
  PROCEDURE customerAccount_library(custoID IN customer.customerID%TYPE);
  PROCEDURE employeeAccount_library(emploID IN employee.employeeID%TYPE);
  PROCEDURE rentItem_library(auxCard IN NUMBER, auxItemID IN VARCHAR2, itemType IN VARCHAR2, auxDate IN DATE);
  PROCEDURE payFines_library(auxCard IN card.cardID%TYPE, money IN NUMBER);
  PROCEDURE updateInfoCusto_library(auxCustomer IN customer.customerID%TYPE, pNumber IN NUMBER, address IN VARCHAR2, newPass IN VARCHAR2);
  PROCEDURE updateInfoEmp_library(auxEmployee IN employee.employeeID%TYPE, pNumber IN NUMBER, address IN VARCHAR2, newPass IN VARCHAR2, newPayCheck IN NUMBER, newBranch IN VARCHAR2);
  PROCEDURE addCustomer_library(auxCustomerId IN NUMBER, auxName IN VARCHAR2, auxCustomerAddress IN VARCHAR2, auxPhone IN NUMBER, auxPass IN VARCHAR2, auxUserName IN VARCHAR2, auxCardNumber IN NUMBER);
  PROCEDURE allMedia_library(mediaType IN VARCHAR2);
  PROCEDURE handleReturns_library(auxItemID IN VARCHAR2);
  PROCEDURE addBook_library(auxISBN IN VARCHAR2, auxBookID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER, auxLostCost IN NUMBER, auxAddress IN VARCHAR2);
  PROCEDURE addVideo_library(auxTitle IN VARCHAR2, auxYear IN INT, auxVideoID IN VARCHAR2, auxState IN VARCHAR2, auxDebyCost IN NUMBER, auxLostCost IN NUMBER, auxAddress IN VARCHAR2);
  PROCEDURE removeItem_library(auxItemID IN VARCHAR2);
  PROCEDURE viewCustomer_library(auxCustomerID IN NUMBER);
END library_mgmt_pkg;
/
