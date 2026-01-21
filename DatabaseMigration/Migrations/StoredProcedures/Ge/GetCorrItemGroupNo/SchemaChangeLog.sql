--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrItemGroupNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrItemGroupNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrItemGroupNo
CREATE OR ALTER PROCEDURE dbo.GetCorrItemGroupNo
    @PartnerId UniqueIdentifier

AS 

SELECT I.CorrItemGroupNo From PtCorrPartnerItemGroup AS I
  JOIN PtCorrPartner AS C
      ON C.Id = I.CorrPartnerId
  WHERE C.PartnerId = @PartnerId
      AND I.CorrItemGroupNo = 1


