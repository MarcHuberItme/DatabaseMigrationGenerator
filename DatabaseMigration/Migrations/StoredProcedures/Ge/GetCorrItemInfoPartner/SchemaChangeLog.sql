--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrItemInfoPartner context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrItemInfoPartner,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrItemInfoPartner
CREATE OR ALTER PROCEDURE dbo.GetCorrItemInfoPartner

@PartnerId UniqueIdentifier,
@CorrItemId UniqueIdentifier AS

SELECT * FROM PtCorrPartnerView 
WHERE PartnerId = @PartnerId AND CorrItemId = @CorrItemId
