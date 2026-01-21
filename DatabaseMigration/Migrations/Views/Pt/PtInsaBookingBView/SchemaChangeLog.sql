--liquibase formatted sql

--changeset system:create-alter-view-PtInsaBookingBView context:any labels:c-any,o-view,ot-schema,on-PtInsaBookingBView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaBookingBView
CREATE OR ALTER VIEW dbo.PtInsaBookingBView AS
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
	Substring(InsaRecord,95 , 14) AS KursAwrg ,           
	Substring(InsaRecord,109, 12) AS MarchAwrg,           
	Substring(InsaRecord,121, 12) AS CourtAwrg ,           
	Substring(InsaRecord,133, 12) AS SteGebAwrg ,          
	Substring(InsaRecord,145, 12) AS SpeseAwrg,            
	Substring(InsaRecord,157, 14) AS NettoAwrg,            
	Substring(InsaRecord,171, 3) AS Awrg,            
	Substring(InsaRecord,174, 10 ) AS ChAwrgKto ,           
	Substring(InsaRecord,184, 14 ) AS NettoKwrg,            
	Substring(InsaRecord,198, 3 ) AS Kwrg ,           
	Substring(InsaRecord,201, 10 ) AS ChAwrgSfr,             
	Substring(InsaRecord,211, 14 ) AS NettoSfr,            
	Substring(InsaRecord,225, 6 ) AS Abrdat,            
	Substring(InsaRecord,231, 6 ) AS Valdat,            
	Substring(InsaRecord,237, 10) AS ValZus ,           
	Substring(InsaRecord,247, 4) AS Reserve ,           
	Substring(InsaRecord,251, 4 ) AS SortKey,          
	Substring(InsaRecord,255, 2 ) AS SrcSys ,           
	Substring(InsaRecord,257, 10) AS KontrGr10 ,         
	Substring(InsaRecord,267, 10) AS Reserve1 ,         
	Substring(InsaRecord,277, 10) AS Reserve2
FROM 	PtInsaBooking
WHERE 	Substring(InsaRecord,5  , 1 ) = 'B'
