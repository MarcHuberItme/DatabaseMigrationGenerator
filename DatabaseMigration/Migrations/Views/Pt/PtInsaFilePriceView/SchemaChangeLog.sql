--liquibase formatted sql

--changeset system:create-alter-view-PtInsaFilePriceView context:any labels:c-any,o-view,ot-schema,on-PtInsaFilePriceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaFilePriceView
CREATE OR ALTER VIEW dbo.PtInsaFilePriceView AS
SELECT Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser,  HdVersionNo, 
ControllerId, InsaRecord, PublicId, ProdReferenceId, LocGroupId,
Substring(InsaRecord,1   , 14 ) AS ValNr,  
Substring(InsaRecord,15  , 9  ) AS Kurs,
Substring(InsaRecord,24  , 6  ) AS DStNr,
Substring(InsaRecord,30  , 10 ) AS ValZus,
Substring(InsaRecord,40  , 3  ) AS KursWrg,
Substring(InsaRecord,43  , 11 ) AS Sobas,
Substring(InsaRecord,54  , 2  ) AS KJaHu,
Substring(InsaRecord,56  , 6  ) AS KDat,
Substring(InsaRecord,62  , 1  ) AS Reserve  
FROM 	PtInsaFilePrice

