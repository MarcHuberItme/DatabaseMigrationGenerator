--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingEsrData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingEsrData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingEsrData
CREATE OR ALTER PROCEDURE dbo.GetPendingEsrData
@AccountId UNIQUEIDENTIFIER,
@LanguageNo int   

AS
SELECT
	B.Id as AccountId,
	B.AccountNo, 
	B.AccountNoEdited,
	R.Currency,
	IsNull(B.CustomerReference, IsNull(Acc_AsText.TextShort, Prod_AsText.TextShort)) as TextShort, 
	Sum(D.Amount) Amount, 
	Count(B.AccountNo) as NumberOfEntries, 
	Min(D.TransDate) as DateFrom, 
	Max(D.TransDate) as DateTo,
	1 as ProcessingStatus
FROM PtTransEsrData as D
INNER JOIN PtAccountBase as B on D.AccountId = B.Id 
JOIN PrReference as R ON B.Id = R.AccountId
JOIN PrPrivate as P ON R.ProductId = P.ProductId
LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON P.ProductNo = Prod_char.ProductNo
     AND Prod_char.IsDefault = 1
LEFT OUTER JOIN AsText Prod_AsText ON Prod_char.Id = Prod_AsText.MasterId
     AND Prod_AsText.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON B.CharacteristicNo = Acc_char.CharacteristicNo
LEFT OUTER JOIN AsText Acc_AsText ON Acc_char.Id = Acc_AsText.MasterId
     AND Acc_AsText.LanguageNo = @LanguageNo
WHERE D.AccountId = @AccountId
AND NOT EXISTS (SELECT * FROM PtTransEsrFetched WHERE TransEsrDataId = D.Id)
                AND d.TransDate > DATEADD(year, -1, GETDATE())
GROUP BY B.Id, B.AccountNo, B.AccountNoEdited, B.CustomerReference, R.Currency, Acc_AsText.TextShort, Prod_AsText.TextShort
OPTION (maxdop 1) -- is used to handle this Errormessage: Intra-query parallelism caused your server command (process ID #51) to deadlock. Rerun the query without intra-query parallelism by using the query hint option (maxdop 1).
