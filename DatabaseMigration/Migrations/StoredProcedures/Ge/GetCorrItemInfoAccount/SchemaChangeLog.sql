--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrItemInfoAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrItemInfoAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrItemInfoAccount
CREATE OR ALTER PROCEDURE dbo.GetCorrItemInfoAccount

@AccountId UniqueIdentifier,
@CorrItemId UniqueIdentifier AS

SELECT * FROM PtCorrAccountView 
WHERE AccountId = @AccountId AND CorrItemId = @CorrItemId
