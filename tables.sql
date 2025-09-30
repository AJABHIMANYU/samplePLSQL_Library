-- tables.sql
-- Creates tables for the library management system

CREATE TABLE Card (
  cardID NUMBER,
  status VARCHAR2(1) CHECK ((status = 'A') OR (status = 'B')),
  fines NUMBER,
  CONSTRAINT Card_PK PRIMARY KEY (cardID)
);

CREATE TABLE Customer (
  customerID NUMBER,
  name VARCHAR2(40),
  customerAddress VARCHAR2(50),
  phone NUMBER(9),
  password VARCHAR2(20),
  userName VARCHAR2(10),
  dateSignUp DATE,
  cardNumber NUMBER,
  CONSTRAINT Customer_PK PRIMARY KEY (customerID)
);

CREATE TABLE Employee (
  employeeID NUMBER,
  name VARCHAR2(40),
  employeeAddress VARCHAR2(50),
  phone NUMBER(9),
  password VARCHAR2(20),
  userName VARCHAR2(10),
  paycheck NUMBER(8,2),
  branchName VARCHAR2(40),
  cardNumber NUMBER,
  CONSTRAINT Employee_PK PRIMARY KEY (employeeID)
);

CREATE TABLE Branch (
  name VARCHAR2(40),
  address VARCHAR2(50),
  phone NUMBER(9),
  CONSTRAINT Branch_PK PRIMARY KEY (name)
);

CREATE TABLE Location (
  address VARCHAR2(50),
  CONSTRAINT Location_PK PRIMARY KEY (address)
);

CREATE TABLE Rent (
  cardID NUMBER,
  itemID VARCHAR2(6),
  apporpriationDate DATE,
  returnDate DATE,
  CONSTRAINT Rent_PK PRIMARY KEY (cardID, itemID)
);

CREATE TABLE Book (
  ISBN VARCHAR2(4),
  bookID VARCHAR2(6),
  state VARCHAR2(10),
  avalability VARCHAR2(1) CHECK ((avalability = 'A') OR (avalability = 'O')),
  debyCost NUMBER(10,2),
  lostCost NUMBER(10,2),
  address VARCHAR2(50),
  CONSTRAINT Book_PK PRIMARY KEY (ISBN, bookID)
);

CREATE TABLE Video (
  title VARCHAR2(50),
  year INT,
  videoID VARCHAR2(6),
  state VARCHAR2(10),
  avalability VARCHAR2(1) CHECK ((avalability = 'A') OR (avalability = 'O')),
  debyCost NUMBER(10,2),
  lostCost NUMBER(10,2),
  address VARCHAR2(50),
  CONSTRAINT Video_PK PRIMARY KEY (title, year, videoID)
);
