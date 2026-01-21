--liquibase formatted sql

--changeset system:create-alter-procedure-GetPtCheckList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPtCheckList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPtCheckList
CREATE OR ALTER PROCEDURE dbo.GetPtCheckList
@LastPartnerNo Int
AS
    SELECT TOP 500 Id, Name, FirstName, NameCont, PartnerNo, SexStatusNo, LegalStatusNo
    FROM PtBase
    WHERE PartnerNo > @LastPartnerNo 
        AND HdVersionNo < 999999999
    ORDER BY PartnerNo
    

