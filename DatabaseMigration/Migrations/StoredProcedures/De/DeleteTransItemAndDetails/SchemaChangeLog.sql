--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteTransItemAndDetails context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteTransItemAndDetails,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteTransItemAndDetails
CREATE OR ALTER PROCEDURE dbo.DeleteTransItemAndDetails

@ItemId uniqueidentifier

AS
DELETE FROM PtTransItemDetail
WHERE TransItemId = @ItemId

DELETE FROM PtTransItem
WHERE Id = @ItemId

