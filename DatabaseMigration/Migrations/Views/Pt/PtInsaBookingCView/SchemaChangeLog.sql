--liquibase formatted sql

--changeset system:create-alter-view-PtInsaBookingCView context:any labels:c-any,o-view,ot-schema,on-PtInsaBookingCView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaBookingCView
CREATE OR ALTER VIEW dbo.PtInsaBookingCView AS
SELECT 	Id, HdCreateDate, HdChangeDate, HdVersionNo, TransItemId, TransItemDetailId, TransMessageId, 
	TransDate, ProcessDate, PositionId, InsaRecord, DownloadStartDate, DownloadEndDate,
	Substring(InsaRecord,1  , 1 ) AS BCD,               
	Substring(InsaRecord,2  , 3 ) AS TextCode,          
	Substring(InsaRecord,5  , 1 ) AS TransArt,          
	Substring(InsaRecord,6  , 10) AS KdNru,             
	Substring(InsaRecord,16 , 12) AS KtNru,             
	Substring(InsaRecord,28 , 12) AS GegNru,            
	Substring(InsaRecord,40 , 11) AS BasisPreis,        
	Substring(InsaRecord,51 , 5 ) AS DstNr,             
	Substring(InsaRecord,56 , 14) AS ValNr ,            
	Substring(InsaRecord,70 , 16) AS Stueck,            
	Substring(InsaRecord,86 , 9 ) AS Kurs,              
	Substring(InsaRecord,95 , 14) AS Brutto ,           
	Substring(InsaRecord,109, 14) AS RueckEg,           
	Substring(InsaRecord,123, 14) AS Leer_1 ,           
	Substring(InsaRecord,137, 14) AS RueckSf ,          
	Substring(InsaRecord,151, 14) AS Steuer,            
	Substring(InsaRecord,165, 14) AS Leer_2,            
	Substring(InsaRecord,179, 14) AS Netto ,            
	Substring(InsaRecord,193, 6 ) AS ErtDat ,           
	Substring(InsaRecord,199, 6 ) AS Valuta,            
	Substring(InsaRecord,205, 6 ) AS Leer_4 ,           
	Substring(InsaRecord,211, 6 ) AS Sachb,             
	Substring(InsaRecord,217, 3 ) AS EgWrg ,            
	Substring(InsaRecord,220, 3 ) AS Leer_6,            
	Substring(InsaRecord,223, 2 ) AS Leer_7,            
	Substring(InsaRecord,225, 10) AS ValZus ,           
	Substring(InsaRecord,235, 16) AS Leer_8 ,           
	Substring(InsaRecord,251, 4 ) AS SortKey,          
	Substring(InsaRecord,255, 2 ) AS SrcSys ,           
	Substring(InsaRecord,257, 10) AS Reserve0 ,         
	Substring(InsaRecord,267, 10) AS Reserve1 ,         
	Substring(InsaRecord,277, 10) AS Reserve2
FROM 	PtInsaBooking
WHERE 	Substring(InsaRecord,5  , 1 ) = 'C'

