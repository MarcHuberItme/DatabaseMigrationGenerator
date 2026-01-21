--liquibase formatted sql

--changeset system:create-alter-procedure-GetOpenFixComponentsByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetOpenFixComponentsByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetOpenFixComponentsByAccountId
CREATE OR ALTER PROCEDURE dbo.GetOpenFixComponentsByAccountId

@AccountId UniqueIdentifier,
@Date Datetime,
@ReasonType integer,
@LanguageNo tinyint

AS

SELECT Tx.TextShort AS Component, D.ValidFrom, D.ValidTo
FROM PtAccountPriceDeviation AS D
INNER JOIN PtAccountComponent AS C ON D.AccountComponentId = C.Id
INNER JOIN PrPrivateCompType AS T ON C.PrivateCompTypeId = T.Id
LEFT OUTER JOIN AsText AS Tx ON T.Id = Tx.MasterId
WHERE D.AccountBaseId = @AccountId 
AND D.AccountComponentId IS NOT NULL
AND D.ValidTo >= DATEADD(day, 1, @Date)
AND D.ValidFrom < @Date
AND D.ReasonType = @ReasonType 
AND D.HdVersionNo BETWEEN 1 AND 999999998
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Tx.LanguageNo = @LanguageNo 
ORDER BY D.ValidFrom ASC, Tx.TextShort ASC
