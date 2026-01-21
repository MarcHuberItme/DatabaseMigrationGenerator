--liquibase formatted sql

--changeset system:create-alter-view-PtInsaBookingDKView context:any labels:c-any,o-view,ot-schema,on-PtInsaBookingDKView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaBookingDKView
CREATE OR ALTER VIEW dbo.PtInsaBookingDKView AS
SELECT 	Id, HdCreateDate, HdChangeDate, HdVersionNo, TransItemId, TransItemDetailId, TransMessageId, 
	TransDate, ProcessDate, PositionId, InsaRecord, DownloadStartDate, DownloadEndDate,
	Substring(InsaRecord,1  , 1 ) AS BCD,               
	Substring(InsaRecord,2  , 3 ) AS TextCode,          
	Substring(InsaRecord,5  , 1 ) AS TransArt,          
	Substring(InsaRecord,6  , 10) AS KdNru,             
	Substring(InsaRecord,16 , 12) AS KtNru,             
	Substring(InsaRecord,28 , 12) AS GegNru,            
	Substring(InsaRecord,40 , 11) AS BasisPreis,        
	Substring(InsaRecord,51 , 5 ) AS KontraktGr,             
	Substring(InsaRecord,56 , 14) AS ValNr ,            
	Substring(InsaRecord,70 , 16) AS Stueck,            
	Substring(InsaRecord,86 , 9 ) AS Kurs,              
	Substring(InsaRecord,95 , 14) AS Marchzins ,           
	Substring(InsaRecord,109, 14) AS Spesen,           
	Substring(InsaRecord,123, 14) AS Devkurs ,           
	Substring(InsaRecord,137, 14) AS Courtage ,          
	Substring(InsaRecord,151, 14) AS UmsAbgabe,            
	Substring(InsaRecord,165, 14) AS EBV,            
	Substring(InsaRecord,179, 14) AS EndBetrag,            
	Substring(InsaRecord,193, 6 ) AS BDatum ,           
	Substring(InsaRecord,199, 6 ) AS Valuta,            
	Substring(InsaRecord,205, 6 ) AS DstNr ,           
	Substring(InsaRecord,211, 6 ) AS Sachb,             
	Substring(InsaRecord,217, 3 ) AS AbrWrg,            
	Substring(InsaRecord,220, 3 ) AS WrgEinheit,            
	Substring(InsaRecord,223, 2 ) AS RechArt,            
	Substring(InsaRecord,225, 10) AS ValZus ,           
	Substring(InsaRecord,235, 16) AS BetragSfr ,           
	Substring(InsaRecord,251, 4 ) AS SortKey,          
	Substring(InsaRecord,255, 2 ) AS SrcSys ,           
	Substring(InsaRecord,257, 10) AS KontrGr10 ,         
	Substring(InsaRecord,267, 10) AS Reserve1 ,         
	Substring(InsaRecord,277, 10) AS Reserve2
FROM 	PtInsaBooking
WHERE 	Substring(InsaRecord,5  , 1 ) IN ('K', 'D')
