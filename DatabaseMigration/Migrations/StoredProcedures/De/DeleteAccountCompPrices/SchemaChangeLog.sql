--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteAccountCompPrices context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteAccountCompPrices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteAccountCompPrices
CREATE OR ALTER PROCEDURE dbo.DeleteAccountCompPrices

@AccountId Uniqueidentifier

AS

DELETE FROM PtAccountComposedPrice
WHERE Id IN (
	SELECT P.Id 
	FROM PtAccountComposedPrice AS P
	INNER JOIN PtAccountComponent AS C ON P.AccountComponentId = C.Id  
	INNER JOIN PtAccountBase AS A ON C.AccountBaseId = A.Id
	WHERE A.Id = @AccountId
	)

