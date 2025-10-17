USE group3ARMYBASE

-- Stored Procedure 

CREATE OR ALTER PROCEDURE AddSoilder
@DOB date, 
@GenderName varchar(40), 
@SoldierFname varchar(50), 
@SoldierLname varchar(50), 
@SoldierPermAddress varchar(50)
AS

DECLARE @GendertypeID INT 

SET @GendertypeID = (SELECT GendertypeID FROM tblGENDER_TYPE WHERE GenderName = @GenderName)

BEGIN TRAN G1 
INSERT INTO tblSOLDIER(DOB, GendertypeID, SoldierFname, SoldierLname, SoldierPermAddress)
VALUES(@DOB, @GendertypeID, @SoldierFname, @SoldierLname, @SoldierPermAddress)
COMMIT TRAN G1


EXEC AddSoilder
@DOB = '2003-09-24',
@GenderName = 'Female', 
@SoldierFname = 'Sheryl',
@SoldierLname = 'Meryl',
@SoldierPermAddress = 'Suzy Queue 4455 Landing Lange, APT 4 Louisville, KY 40018-1234'


CREATE OR ALTER PROCEDURE AddNewRankType 
@RankTypeName varchar(100),
@RankTypeDescr varchar(100), 
@Salary INT 

AS 
 
BEGIN TRANSACTION G1
INSERT INTO tblRANK_TYPE(RankTypeName, RankTypeDescr, Salary)
VALUES(@RankTypeName, @RankTypeDescr, @Salary) 
COMMIT TRANSACTION G1


CREATE OR ALTER PROCEDURE AddEquip_Event_Storage
@StorageName varchar(100), 
@StorageGPS INT, 
@Longitude numeric(9,2),
@Latitude numeric(9,2), 
@EQ_Name varchar(100), 
@DateManufactured date, 
@SupplierName varchar(100),
@EventName varchar(100),
@WeaponCount INT 

AS

DECLARE @StorageID INT, @EquipmentID INT, @EventID INT 

SET @StorageID = (SELECT S.StorageID FROM 
					tblSTORAGE S 
					JOIN tblBASE B ON S.BaseID = B.BaseID 
					WHERE S.StorageName = @StorageName AND 
					S.StorageGPS = @StorageGPS AND B.Longitude= @Longitude
					AND B.Latitude = @Latitude)
SET @EquipmentID = (SELECT E.EquipmentID FROM 
					tblEQUIPMENT E 
					JOIN tblSUPPLIER S ON E.SupplierID = S.SupplierID
					WHERE S.Supplier_Name = @SupplierName
					AND E.EQName = @EQ_Name AND E.EQManufactured = @DateManufactured
					)

SET @EventID = (SELECT E.EventID FROM 
				tblEVENT E
				WHERE E.EventName=@EventName)

BEGIN TRANSACTION T1
INSERT INTO tblEQUIP_EVENT_STORAGE(StorageID, ItemCount, EquipmentID, EventID)
VALUES(@StorageID, @WeaponCount, @EquipmentID, @EventID) 
COMMIT TRANSACTION T1





CRAB DIES 
-- Bussiness Rules 

CREATE OR ALTER FUNCTION AgeLimit()
RETURNS INT 
AS 
BEGIN 
DECLARE @RET INT = 0 
IF EXISTS(
	SELECT * 
	FROM tblSOLDIER S
	WHERE S.DOB < DATEADD(YEAR, -20, GETDATE())
	AND S.DOB > DATEADD(YEAR, -75, GETDATE())
)
BEGIN 
	SET @RET = 1
END 
RETURN @Ret
END 
GO 

ALTER TABLE tblSOLDIER 
ADD CONSTRAINT CK_AgeLimit
CHECK (dbo.AgeLimit() = 0)
GO

CRAB DIES 
CREATE OR ALTER FUNCTION SupplierRule()
RETURNS INT 
AS 
BEGIN 
DECLARE @RET INT = 0
IF EXISTS(
SELECT * 
FROM tblEQUIPMENT T 
JOIN tblSUPPLIER D ON T.SupplierID = D.SupplierID
WHERE T.EQName = 'M67'
AND D.Supplier_Name = 'France'
)
BEGIN  
SET @RET = 1 
END 
RETURN @RET
END 
GO

ALTER TABLE tblEQUIPMENT  
ADD CONSTRAINT C_SupplierRule
CHECK (dbo.SupplierRule() = 0)
GO

 











 -- Computed Columns 


--Write the code to create a computed column to determine the total number of storages that 
--are ‘Climate-Controlled’ and contain equipment grenades for each base. (Shri) ( BIG CHECK ) 


CRAB DIES 

CREATE OR ALTER FUNCTION TotalStorage(@PKBID INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT COUNT(*) 
				FROM tblBASE B 
				JOIN tblSTORAGE E ON B.BaseID = E.BaseID 
				JOIN tblSTORAGE_TYPE U ON E.StorageTypeID = U.StorageTypeID
				JOIN tblEQUIP_EVENT_STORAGE N ON E.StorageID = N.StorageID
				JOIN tblEQUIPMENT V ON N.EquipmentID = V.EquipmentID
				JOIN tblEQ_TYPE Z ON V.EQ_TypeID = Z.EQ_TypeID
				WHERE U.StorageTypeName = 'Temperature-Controlled'
				AND Z.EQ_TypeName = 'Grenade' 
				AND B.BaseID = @PKBID
				)
RETURN @RET 
END
GO 

ALTER TABLE tblBASE 
DROP COLUMN newTasks 

ALTER TABLE tblBASE 
ADD newTasks AS (dbo.TotalStorage(BaseID))

SELECT * 
FROM tblBASE

SELECT * 
FROM tblSTORAGE_TYPE


INSERT INTO tblSTORAGE(StorageName, StorageGPS, BaseID, StorageTypeID)
VALUES('180 Lot Mobile Storage', 56, 3, 16), ('167 Lot Mobile Storage', 64, 3, 16), 
('130 Lot Mobile Storage',40, 3, 16),('188 Lot Mobile Storage', 6, 2, 16), ('17 Lot Mobile Storage', 49, 2, 16), 
('131 Lot Mobile Storage',27, 2, 16)

INSERT INTO tblEQUIPMENT(EQName, EQCost, EQManufactured,SupplierID, EQ_TypeID)
VALUES('M67', 4000,'2019-03-01', 3, 3)


INSERT INTO tblEQUIP_EVENT_STORAGE(StorageID, EquipmentID, EventID, ItemCount)
VALUES(13, 16, 2, 56),(14, 16, 2, 30),(15, 16, 2, 25),(16, 16, 2, 78), (17,16,3,88), 
(18,16,1,50)

SELECT * 
FROM tblEQUIPMENT
-- EquipID = 16
SELECT * 
FROM tblEQUIP_EVENT_STORAGE

SELECT * 
FROM tblEVENT





INSERT INTO tblASSIGNMENT(Enlistment_Date, Discharge_Date, SoldierID, RankID )
VALUES ('2005-08-12', '9999-12-31', 11, 2), ('2000-03-11', '9999-12-31', 21, 1), 
('2018-03-11', '2019-12-31', 24, 1), ('2020-03-11', '2021-12-31', 24, 1), 
('2022-03-11', '9999-12-31', 24, 1), ('2007-03-11', '2021-12-31', 27, 3)


-- Measure the total number of assignments each female soilder has. (Shri) DONE DONE DONE 

CRAB DIES 

CREATE OR ALTER FUNCTION totalWomenSoldierAssignment(@PKEQT INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT COUNT(*) 
FROM tblSOLDIER S
JOIN tblGENDER_TYPE E ON S.GendertypeID = E.GendertypeID
JOIN tblASSIGNMENT J ON S.SoldierID = J.SoldierID

WHERE E.GenderName = 'Female'
AND S.SoldierID = @PKEQT
)

RETURN @RET 
END 
GO 

ALTER TABLE tblSOLDIER 
DROP COLUMN CK_totalWomenSoldierAssignment

ALTER TABLE tblSOLDIER 
ADD CK_totalWomenSoldierAssignment AS dbo.totalWomenSoldierAssignment(SoldierID)


--Views

-- Find the soldiers who have been discharged from '2012-01-01' who have lived in a triple room
-- with the quarter room name Sokyryntsi.

CREATE OR ALTER VIEW SoldiersLivinginSokyryntsi
AS
SELECT DISTINCT S.SoldierID, S.SoldierFname, S.SoldierLname
FROM tblSOLDIER S
JOIN tblASSIGNMENT H ON S.SoldierID = H.SoldierID 
JOIN tblRANK J ON H.RankID = J.RankID 
JOIN tblRANK_TYPE K ON J.RankTypeID = K.RankTypeID 
JOIN tblASSIGNMENT_QUARTERS N ON H.AssignmentID = N.AssignmentID
JOIN tblQUARTERS X ON N.QuarterID = X. QuarterID 
JOIN tblQUARTERS_TYPE W ON X.QuarterTypeID = W.QuarterTypeID
WHERE H.Discharge_Date > '2012-01-01'
AND W.QuarterRoomTypeName = 'Triple'
AND X.QuarterRoomName = 'Sokyryntsi'


INSERT INTO tblASSIGNMENT_QUARTERS(BeginDate, EndDate,AssignmentID, QuarterID)
VALUES('3/11/2000','12/31/2003',14,3),('3/11/2018','4/2/2019',15,3),('3/11/2007','12/31/2021',18,3)

 
-- 14, 15, 18

--  Complexity as appropriate: multiple JOINs, GROUP BY, ORDER BY, TOP

-- Find the Bases with the most amount of equipment that are supplied by 'America' 
CREATE OR ALTER VIEW BaseEquipUSA
AS
SELECT TOP 2 (B.BaseID),SUM(ItemCount) AS TotalStorage
FROM tblBASE B
JOIN tblSTORAGE S ON B.BaseID = S.BaseID 
JOIN tblEQUIP_EVENT_STORAGE E ON S.StorageID = E.StorageID
JOIN tblEVENT H ON E.EventID = H.EventID
JOIN tblEQUIPMENT J ON E.EquipmentID = J.EquipmentID
JOIN tblSUPPLIER Y ON J.SupplierID = Y.SupplierID
WHERE Y.Supplier_Name = 'United States'
GROUP BY B.BaseID
ORDER BY TotalStorage DESC

 




















