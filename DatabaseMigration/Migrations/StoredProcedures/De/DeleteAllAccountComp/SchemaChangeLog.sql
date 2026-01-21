--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteAllAccountComp context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteAllAccountComp,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteAllAccountComp
CREATE OR ALTER PROCEDURE dbo.DeleteAllAccountComp

@AccountId uniqueidentifier

AS

DELETE FROM PtAccountPriceDeviation
WHERE AccountBaseId = @AccountId

DELETE FROM PtAccountCompValue
WHERE AccountComponentId IN (
	SELECT Id FROM PtAccountComponent
	WHERE AccountBaseId = @AccountId)

DELETE FROM PtAccountComponent
WHERE AccountBaseId = @AccountId

