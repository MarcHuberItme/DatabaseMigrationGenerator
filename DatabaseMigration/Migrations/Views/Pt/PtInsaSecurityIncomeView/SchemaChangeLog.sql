--liquibase formatted sql

--changeset system:create-alter-view-PtInsaSecurityIncomeView context:any labels:c-any,o-view,ot-schema,on-PtInsaSecurityIncomeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaSecurityIncomeView
CREATE OR ALTER VIEW dbo.PtInsaSecurityIncomeView AS
SELECT 	Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, 
	TransMessageId, 
	PositionId, 
	InsaRecord, 
	DownloadStartDate,
	SUBSTRING(InsaRecord,   1, 1)  AS BCD,       
	SUBSTRING(InsaRecord,   2, 3)  AS TextCode,
	SUBSTRING(InsaRecord,   5, 1)  AS TransArt,  
	SUBSTRING(InsaRecord,   6, 10) AS KdNru,     
	SUBSTRING(InsaRecord,  16, 12) AS KtNru,     
	SUBSTRING(InsaRecord,  28, 12) AS GegNru, 
	SUBSTRING(InsaRecord,  40, 11) AS BasisPreis,
	SUBSTRING(InsaRecord,  51, 5)  AS KontraktGr,
	SUBSTRING(InsaRecord,  56, 14) AS ValNr,     
	SUBSTRING(InsaRecord,  70, 16) AS Stueck,   
	SUBSTRING(InsaRecord,  86, 9)  AS Kurs,      
	SUBSTRING(InsaRecord,  95, 14) AS Brutto,    
	SUBSTRING(InsaRecord, 109, 14) AS RueckEg,   
	SUBSTRING(InsaRecord, 123, 14) AS Leer_1,    
	SUBSTRING(InsaRecord, 137, 14) AS RueckSf,   
	SUBSTRING(InsaRecord, 151, 14) AS Steuer,    
	SUBSTRING(InsaRecord, 165, 14) AS Leer_2,    
	SUBSTRING(InsaRecord, 179, 14) AS Netto,     
	SUBSTRING(InsaRecord, 193, 6)  AS ErtDat,    
	SUBSTRING(InsaRecord, 199, 6)  AS Leer_3,    
	SUBSTRING(InsaRecord, 205, 6)  AS Leer_4,    
	SUBSTRING(InsaRecord, 211, 6)  AS Leer_5,    
	SUBSTRING(InsaRecord, 217, 3)  AS EgWrg,     
	SUBSTRING(InsaRecord, 220, 3)  AS Leer_6,    
	SUBSTRING(InsaRecord, 223, 2)  AS Leer_7,    
	SUBSTRING(InsaRecord, 225, 10) AS ValZus,    
	SUBSTRING(InsaRecord, 235, 22) AS Leer_8 
FROM 	PtInsaSecurityIncome
