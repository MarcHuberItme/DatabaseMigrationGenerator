--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccCompDeviationId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccCompDeviationId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccCompDeviationId
CREATE OR ALTER PROCEDURE dbo.GetAccCompDeviationId
@AccountCompId uniqueidentifier

AS

SELECT Id, HdEditStamp FROM PtAccountPriceDeviation
WHERE AccountComponentId = @AccountCompId

