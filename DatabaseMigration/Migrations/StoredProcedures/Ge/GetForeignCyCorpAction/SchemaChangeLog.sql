--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyCorpAction context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyCorpAction,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyCorpAction
CREATE OR ALTER PROCEDURE dbo.GetForeignCyCorpAction

@LanguageNo tinyint

AS

SELECT Currency, AccountNo, ProductNo, ValueDate, SUM(DebitAmount) AS DebitAmount, SUM(CreditAmount) AS CreditAmount, EventDesc, EventNo, IsCoba, COUNT(Res.AccountNo) AS BookingsCount
FROM (
SELECT
Ev.Currency,
AccountNo =
CASE 
WHEN PrCoba.ProductNo >= 0 THEN Ev.AccountNo
ELSE 99999999999
END,
ProductNo =
CASE
WHEN PrCoba.ProductNo >= 0 THEN PrCoba.ProductNo
WHEN PrCust.ProductNo >= 0 THEN PrCust.ProductNo
ELSE NULL
END,
Ev.EffectiveDate AS ValueDate,
Ev.DebitAmount,
Ev.CreditAmount,
ISNULL(Txe.TextShort + ': ', '') + ISNULL(PubDesc.ShortName +' ','') AS EventDesc,
Ev.EventNo,
IsCoba =
CASE 
WHEN PrCoba.ProductNo >= 0 THEN 1
WHEN PrCust.ProductNo >= 0 THEN 0
ELSE NULL
END
FROM EvSelectionPosForexPendingView AS Ev
LEFT OUTER JOIN PrPrivateCobaProductNo AS PrCoba ON PrCoba.ProductId = Ev.ProductId
LEFT OUTER JOIN PrPrivateCustProductNo AS PrCust ON PrCust.ProductId = Ev.ProductId
LEFT OUTER JOIN PrPublicDescriptionView AS PubDesc ON Ev.PublicId = PubDesc.Id AND PubDesc.LanguageNo = @LanguageNo
LEFT OUTER JOIN EvEventType AS Et ON Ev.EventTypeNo = Et.EventTypeNo
LEFT OUTER JOIN AsText AS Txe ON Et.Id = Txe.MasterId AND Txe.LanguageNo = @LanguageNo
WHERE Ev.Currency <> 'CHF') AS RES
WHERE IsCoba IS NOT NULL
GROUP BY Currency, AccountNo, ProductNo, ValueDate, EventDesc, EventNo, IsCoba
