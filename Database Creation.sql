CREATE DATABASE group3ARMYBASE
GO
USE group3ARMYBASE
GO

DROP TABLE tblSOLDIER

CREATE TABLE tblSOLDIER 
(SoldierID INT IDENTITY(1,1) primary key,
SoldierFname varchar(30) NOT NULL,
SoldierLname varchar(30) NOT NULL,
SoldierPermAddress varchar(100) NOT NULL,
DOB date NOT NULL, 
GendertypeID INT NOT NULL
)
GO
 
ALTER TABLE tblSOLDIER 
DROP COLUMN SoldierFname

ALTER TABLE tblSOLDIER 
ADD SoldierFname varchar(100) NOT NULL

ALTER TABLE tblSOLDIER 
DROP COLUMN SoldierLname

ALTER TABLE tblSOLDIER 
ADD SoldierLname varchar(100) NOT NULL

ALTER TABLE tblSOLDIER 
DROP COLUMN SoldierPermAddress

ALTER TABLE tblSOLDIER 
ADD SoldierPermAddress varchar(100) NOT NULL


DROP TABLE tblASSIGNMENT

CREATE TABLE tblASSIGNMENT 
(AssignmentID INT IDENTITY(1,1) primary key,
Enlistment_Date date NOT NULL,
Discharge_Date date NOT NULL, 
SoldierID INT NOT NULL, 
RankID INT NOT NULL
)
GO

DROP TABLE tblGENDER_TYPE

CREATE TABLE tblGENDER_TYPE 
(GendertypeID INT IDENTITY(1,1) primary key,
 GenderName varchar(50) NOT NULL
)
GO

--DROP TABLE tblASSIGNMENT_QUARTERS 

--ALTER TABLE tblASSIGNMENT_QUARTERS
--ADD AssignmentID INT NOT NULL

--ALTER TABLE tblASSIGNMENT_QUARTERS
--ADD QuarterID INT NOT NULL


CREATE TABLE tblASSIGNMENT_QUARTERS 
(AQuartersID INT IDENTITY(1,1) primary key,
BeginDate date NOT NULL,
EndDate date NOT NULL, 
QuarterID INT NOT NULL, 
AssignmentID INT NOT NULL
)
GO

ALTER TABLE tblQUARTERS 
ADD QuarterTypeID INT NOT NULL

ALTER TABLE tblQUARTERS 
ADD BarracksID INT NOT NULL


CREATE TABLE tblQUARTERS 
(QuarterID INT IDENTITY(1,1) primary key,
QuarterRoomName varchar(50) NOT NULL, 
QuarterTypeID INT NOT NULL, 
BarracksID INT NOT NULL 
)
GO

ALTER TABLE tblBARRACKS 
ADD BaseID INT NOT NULL

CREATE TABLE tblBARRACKS 
(BarracksID INT IDENTITY(1,1) primary key,
BarracksName varchar(50) NOT NULL, 
BaseID INT NOT NULL
)
GO




CREATE TABLE tblQUARTERS_TYPE 
(QuarterTypeID INT IDENTITY(1,1) primary key,
QuarterRoomTypeName varchar(50) NOT NULL,
QuarterRoomTypeDescr varchar(50) NOT NULL
)
GO

DROP TABLE tblRANK

--DROP TABLE tblRANK

CREATE TABLE tblRANK 
(RankID INT IDENTITY(1,1) primary key,
RankName varchar(50) NOT NULL,
RankDescr varchar(50) NOT NULL, 
RankTypeID INT NOT NULL
)
GO


CREATE TABLE tblRANK_TYPE 
(RankTypeID INT IDENTITY(1,1) primary key,
RankTypeName varchar(50) NOT NULL,
RankTypeDescr varchar(50) NOT NULL, 
Salary INT NOT NULL
)
GO

CREATE TABLE tblBASE 
(BaseID INT IDENTITY(1,1) primary key,
BaseName varchar(50) NOT NULL,
Base_GPS INT NOT NULL
)
GO

ALTER TABLE tblBASE 
DROP COLUMN BASE_GPS

ALTER TABLE tblBASE 
ADD Longitude Numeric(9,2) NOT NULL

ALTER TABLE tblBASE 
ADD Latitude Numeric(9,2) NOT NULL

 
CREATE TABLE tblSTORAGE_TYPE 
(StorageTypeID INT IDENTITY(1,1) primary key,
StorageTypeName varchar(50) NOT NULL
)
GO

ALTER TABLE tblSTORAGE
ADD BaseID INT NOT NULL

ALTER TABLE tblSTORAGE
ADD StorageTypeID INT NOT NULL

CREATE TABLE tblSTORAGE
(StorageID INT IDENTITY(1,1) primary key,
StorageName varchar(50) NOT NULL, 
StorageGPS INT NOT NULL, 
BaseID INT NOT NULL, 
StorageTypeID INT NOT NULL
)
GO


ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD StorageID INT NOT NULL

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD EquipmentID INT NOT NULL

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD EventID INT NOT NULL

ALTER TABLE tblEQUIP_EVENT_STORAGE
DROP COLUMN WeaponCount

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD ItemCount INT NOT NULL

CREATE TABLE tblEQUIP_EVENT_STORAGE
(WeaponCount INT NOT NULL,
 StorageID INT NOT NULL, 
 EquipmentID INT NOT NULL, 
 EventID INT NOT NULL
)
GO



ALTER TABLE tblEVENT
ADD Event_TypeID INT NOT NULL

CREATE TABLE tblEVENT
(EventID INT IDENTITY(1,1) primary key,
EventName varchar(50) NOT NULL, 
Event_TypeID INT NOT NULL
)
GO

CREATE TABLE tblEVENT_TYPE
(Event_TypeID INT IDENTITY(1,1) primary key,
Event_TypeName varchar(50) NOT NULL
)
GO

ALTER TABLE tblEQUIPMENT
ADD SupplierID INT NOT NULL

ALTER TABLE tblEQUIPMENT
ADD EQ_TypeID INT NOT NULL


CREATE TABLE tblEQUIPMENT
(EquipmentID INT IDENTITY(1,1) primary key,
 EQName varchar(50) NOT NULL, 
 EQCost INT NOT NULL, 
 EQManufactured date NOT NULL, 
 SupplierID INT NOT NULL, 
 EQ_TypeID INT NOT NULL
)
GO

CREATE TABLE tblSUPPLIER
(SupplierID INT IDENTITY(1,1) primary key,
 Supplier_Name varchar(50) NOT NULL
)
GO

CREATE TABLE tblEQ_TYPE
(EQ_TypeID INT IDENTITY(1,1) primary key,
 EQ_TypeName varchar(50) NOT NULL
)
GO
 

ALTER TABLE tblSOLDIER
ADD CONSTRAINT FK_Soldier_GenderTypeID
FOREIGN KEY (GendertypeID)
REFERENCES tblGENDER_TYPE (GendertypeID)


ALTER TABLE tblASSIGNMENT
ADD CONSTRAINT  FK_Assignment_SoldierID
FOREIGN KEY (SoldierID)
REFERENCES tblSOLDIER (SoldierID)

--ALTER TABLE tblAssignment
--DROP CONSTRAINT FK_Assignment_RankID

ALTER TABLE tblAssignment
ADD CONSTRAINT  FK_Assignment_RankID
FOREIGN KEY (RankID)
REFERENCES tblRANK (RankID)

ALTER TABLE tblRANK
ADD CONSTRAINT  FK_Rank_RankTypeID
FOREIGN KEY (RankTypeID)
REFERENCES tblRANK_TYPE (RankTypeID)

ALTER TABLE tblASSIGNMENT_QUARTERS
ADD CONSTRAINT  FK_AssignmentQuarters_AssignmentID
FOREIGN KEY (AssignmentID)
REFERENCES tblASSIGNMENT (AssignmentID)

ALTER TABLE tblASSIGNMENT_QUARTERS
ADD CONSTRAINT  FK_AssignmentQuarters_QuarterID
FOREIGN KEY (QuarterID)
REFERENCES tblQUARTERS(QuarterID)

ALTER TABLE tblQUARTERS
ADD CONSTRAINT  FK_Quarters_QuarterTypeID
FOREIGN KEY (QuarterTypeID)
REFERENCES tblQUARTERS_TYPE (QuarterTypeID)

ALTER TABLE tblQUARTERS
ADD CONSTRAINT  FK_Quarters_BarracksID
FOREIGN KEY (BarracksID)
REFERENCES tblBARRACKS (BarracksID)

ALTER TABLE tblBARRACKS
ADD CONSTRAINT  FK_Barracks_BaseID
FOREIGN KEY (BaseID)
REFERENCES tblBASE (BaseID)

ALTER TABLE tblSTORAGE
ADD CONSTRAINT  FK_Storage_BaseID
FOREIGN KEY (BaseID)
REFERENCES tblBASE (BaseID)

ALTER TABLE tblSTORAGE
ADD CONSTRAINT  FK_Storage_StorageTypeID
FOREIGN KEY (StorageTypeID)
REFERENCES tblSTORAGE_TYPE (StorageTypeID)

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD CONSTRAINT  FK_EQUIP_EVENT_STORAGE_StorageID
FOREIGN KEY (StorageID)
REFERENCES tblSTORAGE (StorageID)

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD CONSTRAINT  FK_EQUIP_EVENT_STORAGE_EventID
FOREIGN KEY (EventID)
REFERENCES tblEVENT (EventID)

ALTER TABLE tblEQUIP_EVENT_STORAGE
ADD CONSTRAINT  FK_EQUIP_EVENT_STORAGE_EquipmentID
FOREIGN KEY (EquipmentID)
REFERENCES tblEQUIPMENT (EquipmentID)

ALTER TABLE tblEVENT
ADD CONSTRAINT  FK_EVENT_Event_TypeID
FOREIGN KEY (Event_TypeID)
REFERENCES tblEVENT_TYPE (Event_TypeID)


ALTER TABLE tblEQUIPMENT
ADD CONSTRAINT  FK_EQUIPMENT_SupplierID
FOREIGN KEY (SupplierID)
REFERENCES tblSUPPLIER (SupplierID)

ALTER TABLE tblEQUIPMENT
ADD CONSTRAINT  FK_EQUIPMENT_EQ_TypeID
FOREIGN KEY (EQ_TypeID)
REFERENCES tblEQ_TYPE (EQ_TypeID)


INSERT INTO tblGENDER_TYPE (GenderName)
VALUES ('Female'), ('Male'), ('Non-Binary')

INSERT INTO tblEVENT_TYPE (Event_TypeName)
VALUES ('Late Shipment'), ('Infrastrcture Damage'), ('Wrong Shipment'), ('Damaged Shipment')

INSERT INTO tblEVENT_TYPE (Event_TypeName)
VALUES ('Attack')


INSERT INTO tblRANK_TYPE (RankTypeName, RankTypeDescr, Salary)
VALUES ('First', 'Top-Most Level', 200000), ('Second', 'Second-level', 150000), ('Third', 'Third-level', 100000)

SELECT *
FROM tblRANK_TYPE

INSERT INTO tblSTORAGE_TYPE (StorageTypeName)
VALUES ('Temperature-Controlled'), ('Highly-Secured'), ('High Capacity'), ('Low-Capacity'), ('Under-ground')

DELETE FROM tblSTORAGE_TYPE 
WHERE StorageTypeName = 'Weapons'

 
 
INSERT INTO tblEQ_TYPE(EQ_TypeName)
VALUES ('Gun'), ('Mortar'), ('Grenade'), ('Rocket'), ('Bombs')

INSERT INTO tblQUARTERS_TYPE(QuarterRoomTypeName, QuarterRoomTypeDescr)
VALUES ('Single', 'Room designed for 1 person'),('Double', 'Room designed for 2 people'), ('Triple', 'Room designed for 3 people'), ('Quad','Room designed for 4 people')

-- change Base_GPS to longitude and latitude 
INSERT INTO tblBASE(BaseName, Longitude, Latitude)
VALUES('Kyiv', 50.45, 30.5), ('Kharkiv', 49.99, 36.23),('Crimea', 45.34, 34.49), ('Chernobyal', 51.27, 30.22),('Donetsk', 48.02, 37.80) 

SELECT * 
FROM tblBASE 

INSERT INTO tblSUPPLIER(Supplier_Name)
VALUES('United States'), ('United Kingdom'), ('France'), ('Germany'), ('Netherlands')

INSERT INTO tblSOLDIER(SoldierFname, SoldierLname, SoldierPermAddress, DOB, GendertypeID)
VALUES('Jacob', 'Holt', '1234 NW Bobcat Lane, St. Robert, MO 65584-5678','2000-02-01', 2),
('Martha', 'Stewart', '21 Wood Dr.Reisterstown, MD 21136', '1980-01-08', 1), 
('Alex', 'Wescott', '7704 Sherman Ave.Clarksville, TN 37040', '1999-03-16', 3), 
('Raj', 'Chatterjee', '67 Monroe Court Redford, MI 48239', '1995-05-07', 2),
('Shilpa', 'Bhatnagar', '21 Brewery Dr. Green Bay, WI 54302', '1995-07-17', 1),
('John', 'Smith', '38 Bowman Drive Desoto, TX 75115', '1995-07-17', 2) 

INSERT INTO tblSOLDIER(SoldierFname, SoldierLname, SoldierPermAddress, DOB, GendertypeID)
VALUES ('Monty', 'John', '47 Brooklyn Way, WA 98105', '1997/09/19', 3),
('Jamal', 'Murray', '14 Bentoak Way, MI 48239', '1987/03/07', 2),
('Becky', 'Sho', '11 Budford Ave, WA 98123', '1970/04/06', 1), 
('Drake', 'London', '62 Hollard Way, WA 98123', '1992/02/12', 3),
('Cudi', 'James', '15 Crawford Ave, CA 95139', '1995/02/15', 2),
('Travis', 'Scott', '232 Janet Dr, MD 21136', '1970/04/06', 2), 
('Steph', 'Thompson', '17 Denford Way, WA 98123', '1987/05/11', 3),
('Klay', 'Curry', '15 Warrior Dr, VA 95119', '1997-03-14', 2),
('Jordan', 'Green', '221 Benz Ave, MD 21136', '1976-02-01', 2), 
('Christian', 'Mccaffrey', '221 Benz Ave, MD 21136', '1976-02-01', 2),
('Deebo', 'Samuel', '22 Bollinger Way CA 91529', '1989-04-03', 2)

SELECT * 
FROM tblGENDER_TYPE
SELECT * 
FROM tblEVENT

INSERT INTO tblEQUIP_EVENT_STORAGE(StorageID, EquipmentID, EventID, ItemCount)
VALUES(7, 8, 3, 45), (11, 13, 2, 60), (12, 10, 2, 40), (9, 12, 2, 70), (10, 14, 1, 50)

SELECT * 
FROM tblSTORAGE

SELECT * 
FROM tblEQUIPMENT

SELECT * 
FROM tblEVENT

 
INSERT INTO tblRANK(RankName,RankDescr,RankTypeID)
VALUES('Private','Front-Lines/Maintaines Barracks',3), ('Admiral','Commands a fleet or a group of ships',1), ('Lieutenant', 'Manages soldiers', 2), ('General','Commands base',1), ('Sergeant','Manages Soliders',2)

INSERT INTO tblEQUIPMENT(EQName, EQCost, EQManufactured, SupplierID, EQ_TypeID)
VALUES('AK-47',4000,'1980-05-09', 1, 1), ('AK-47',4000,'1980-05-09', 2, 1), 
('AK-47',3000,'1980-05-09', 1, 1), ('AK-47',5000,'1980-05-09', 1, 1), ('AK-47',6000,'1980-05-09', 3, 1), 
('XM1287',5000000,'1976-03-02',5, 2),('XM1287',5000000,'1976-03-02',5, 2)

SELECT * 
FROM tblEQ_TYPE

DELETE FROM tblEQUIPMENT WHERE EQName = 'XM1287'

SELECT * 
FROM tblEVENT_TYPE

INSERT INTO tblSTORAGE(StorageName, StorageGPS, BaseID, StorageTypeID)
VALUES('190 Lot Mobile Storage', 34, 3, 16), ('167 Lot Mobile Storage', 44, 3, 18), ('167 Mobile Storage', 48, 1, 20),
('Top-Secret South-West Storage', 50, 4, 18), ('Underground Bunker Storage', 67, 4, 19), ('Highly Confidential Storage', 23, 5, 17)

SELECT * 
FROM tblASSIGNMENT

SELECT * 
FROM tblSTORAGE_TYPE

SELECT * 
FROM tblBASE

SELECT * 
FROM tblSTORAGE_TYPE

SELECT * 
FROM tblASSIGNMENT_QUARTERS

SELECT * 
FROM tblEQUIPMENT 

SELECT * 
FROM tblEQ_TYPE

SELECT * 
FROM tblSUPPLIER




SELECT R.RankName 
FROM tblRANK R 
JOIN tblRANK_TYPE E ON R.RankTypeID = E.RankTypeID
WHERE E.RankTypeName = 'Second'

SELECT * 
FROM tblSTORAGE


























 





























































































































