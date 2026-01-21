--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrCompTypeListByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrCompTypeListByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrCompTypeListByAccountId
CREATE OR ALTER PROCEDURE dbo.GetPrCompTypeListByAccountId

@AccountBaseId uniqueidentifier,
@LanguageNo tinyint

AS

SELECT C.Id, T.TextShort
FROM PtAccountComponent AS C
INNER JOIN PrPrivateCompType AS P ON P.Id = C.PrivateCompTypeId
LEFT OUTER JOIN AsText AS T ON P.Id = T.MasterId
WHERE C.AccountBaseId = @AccountBaseId
AND LanguageNo = @LanguageNo
ORDER BY C.Id ASC
