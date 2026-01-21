--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrPartner11 context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrPartner11,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrPartner11
CREATE OR ALTER PROCEDURE dbo.GetCorrPartner11
    @PartnerId UniqueIdentifier

AS 

SELECT C.Id From PtCorrPartner AS C
  JOIN PtAddress AS A
      ON C.AddressId = A.Id
  WHERE C.PartnerId = @PartnerId
      AND A.AddressTypeNo = 11

