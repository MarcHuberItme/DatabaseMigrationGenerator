--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccCompValueId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccCompValueId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccCompValueId
CREATE OR ALTER PROCEDURE dbo.GetAccCompValueId
@AccountCompId uniqueidentifier

AS

SELECT Id, HdEditStamp FROM PtAccountCompValue
WHERE AccountComponentId = @AccountCompId

