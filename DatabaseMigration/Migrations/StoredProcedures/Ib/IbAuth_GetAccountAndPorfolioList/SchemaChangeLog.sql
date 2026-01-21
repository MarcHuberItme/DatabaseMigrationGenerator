--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetAccountAndPorfolioList context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetAccountAndPorfolioList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetAccountAndPorfolioList
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetAccountAndPorfolioList
@AgrNo Varchar(10)
AS
SELECT TOP 25 PAB.AccountNo,
PPO.PortfolioNo,
PAED.DefaultForPayment,
PAED.OrderRestriction,
ISNULL(Acc_AsText.TextShort, Prod_AsText.TextShort) AS Cat
FROM PtAgrEBanking PAE
INNER JOIN PtAgrEBankingDetail PAED ON PAE.Id = PAED.AgrEBankingId AND PAED.InternetBankingAllowed = 1 AND PAED.HasAccess = 1 AND PAED.ValidFrom < GetDate() AND PAED.ValidTo > GetDate() AND PAED.HdVersionNo BETWEEN 1 AND 999999998
INNER JOIN PtAccountBase PAB ON PAB.ID = PAED.AccountId AND PAB.HdVersionNo BETWEEN 1 AND 999999998 AND (PAB.TerminationDate IS NULL OR PAB.TerminationDate > GetDate())
INNER JOIN PtPortfolio PPO ON PAB.PortfolioId = PPO.Id AND PPO.Id = PAB.PortfolioId
LEFT OUTER JOIN PrReference PRR ON PAB.Id = PRR.AccountId
INNER JOIN PrPrivate PRP ON PRR.ProductId = PRP.ProductId
LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON PRP.ProductNo = Prod_char.ProductNo AND Prod_char.IsDefault = 1
LEFT OUTER JOIN AsText Prod_AsText ON Prod_char.Id = Prod_AsText.MasterId AND Prod_AsText.LanguageNo = 2
LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON PAB.CharacteristicNo = Acc_char.CharacteristicNo
LEFT OUTER JOIN AsText Acc_AsText ON Acc_char.Id = Acc_AsText.MasterId AND Acc_AsText.LanguageNo = 2
WHERE
	PAE.MgVTNo = @AgrNo
	AND PAB.AccountNo > 0
	AND PAE.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY PAB.AccountNo
