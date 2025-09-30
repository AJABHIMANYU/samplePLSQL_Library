-- foreign_keys.sql
-- Adds foreign key constraints to enforce referential integrity

ALTER TABLE Customer
ADD CONSTRAINT Customer_FK
FOREIGN KEY (cardNumber)
REFERENCES Card(cardID);

ALTER TABLE Employee
ADD CONSTRAINT Employee_FK_Card
FOREIGN KEY (cardNumber)
REFERENCES Card(cardID);

ALTER TABLE Employee
ADD CONSTRAINT Employee_FK_Branch
FOREIGN KEY (branchName)
REFERENCES Branch(name);

ALTER TABLE Branch
ADD CONSTRAINT Branch_FK
FOREIGN KEY (address)
REFERENCES Location(address);

ALTER TABLE Book
ADD CONSTRAINT Book_FK
FOREIGN KEY (address)
REFERENCES Location(address);

ALTER TABLE Video
ADD CONSTRAINT Video_FK
FOREIGN KEY (address)
REFERENCES Location(address);

ALTER TABLE Rent
ADD CONSTRAINT Rent_FK_Card
FOREIGN KEY (cardID)
REFERENCES Card(cardID);
