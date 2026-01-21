--liquibase formatted sql

--changeset system:create-alter-procedure-GetItemInfoForPositionUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetItemInfoForPositionUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetItemInfoForPositionUpdate
CREATE OR ALTER PROCEDURE dbo.GetItemInfoForPositionUpdate
@TransId		UNIQUEIDENTIFIER,
@DateLimit	DATETIME

AS
DECLARE	@MaxVersionNo	INT

SET		@MaxVersionNo = 999999998

SELECT		itm.Id, itm.TransId As ItemTransId, itm.DetailCounter, itm.IsClosingItem, 
		itm.TransDate, itm.ValueDate, itm.RealDate, itm.TradeDate, itm.PositionId,
		itm.DebitAmount, itm.CreditAmount, itm.DebitQuantity, itm.CreditQuantity,
		itm.TextNo, itm.MgSpesen, itm.MatchingCode, itm.TransText, itm.CardNo,
		itm.GroupKey, itm.SourceKey, itm.ServiceCenterNo, itm.MgBuffer, itm.IsDueRelevant,
                                itm.MgBetragSfr, itm.MgKurs, itm.MgDepNr, itm.MgMenge, itm.MgValNrAnrecht,
		txt.IsTrade, pos.IsToClose, ref.Currency, ref.MgVrxKey, ref.ObjectId, ref.ProductId,
		ref.ContractId, prd.IsInterestToCalculate, prd.TerminateOnZeroBalance, pub.Id As PrPublicId, 
		pub.IsinNo, por.PortfolioNo, ref.MaturityDate, pos.ProdLocGroupId,
		acc.AccountNo, acc.Id as AccountId, adv.TransactionId as OriginalTransId, adv.ExecutedDate,
		prd.ProductNo, rty.FieldCurrency

FROM		PtTransItem itm
		LEFT OUTER JOIN PtTransItemText txt ON txt.TextNo = itm.TextNo
		 	AND txt.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		INNER JOIN PtPosition pos ON pos.Id = itm.PositionId
		 	AND pos.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		INNER JOIN PrReference ref ON ref.Id = pos.ProdReferenceId
		 	AND ref.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		INNER JOIN PtPortfolio por ON por.Id = pos.PortfolioId
		 	AND por.HdVersionNo < 999999999
		LEFT OUTER JOIN PrPrivate prd ON ref.ProductId = prd.ProductId 
		 	AND prd.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		LEFT OUTER JOIN PrPublic pub ON ref.ProductId = pub.ProductId
			AND pub.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		LEFT OUTER JOIN PrPublicRefType rty ON rty.RefTypeNo = pub.RefTypeNo
		LEFT OUTER JOIN PtAccountBase acc ON ref.accountId = acc.Id
		 	AND acc.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		LEFT OUTER JOIN PtAccountAdvancedClosing adv ON pos.Id = adv.PositionId
		 	AND adv.ExecutedDate >= @DateLimit
		 	AND adv.HdVersionNo BETWEEN 1 AND @MaxVersionNo

WHERE		itm.TransId = @TransId AND itm.HdVersionNo BETWEEN 1 AND @MaxVersionNo
ORDER BY	CAST(SUBSTRING(itm.SourceKey,CHARINDEX('-',itm.SourceKey)+ 1,5) AS INT)
