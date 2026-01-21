--liquibase formatted sql

--changeset system:create-alter-procedure-CheckAccComponentForConv context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckAccComponentForConv,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckAccComponentForConv
CREATE OR ALTER PROCEDURE dbo.CheckAccComponentForConv

@AccountBaseId as uniqueidentifier

AS

SELECT C.Id
FROM PtAccountComponent AS C
INNER JOIN PrPrivateCompType AS T ON T.Id = C.PrivateCompTypeId
WHERE C.AccountBaseId = @AccountBaseId
AND C.IsOldComponent = 0
AND C.HdVersionNo < 999999999
AND T.IsDebit = 1
AND T.IsFixed = 0

