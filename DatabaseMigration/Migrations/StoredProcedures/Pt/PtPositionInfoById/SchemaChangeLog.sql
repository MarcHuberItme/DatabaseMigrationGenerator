--liquibase formatted sql

--changeset system:create-alter-procedure-PtPositionInfoById context:any labels:c-any,o-stored-procedure,ot-schema,on-PtPositionInfoById,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtPositionInfoById
CREATE OR ALTER PROCEDURE dbo.PtPositionInfoById
@id uniqueidentifier  
as  
SELECT  PtPosition.Id, PtPosition.HdCreateDate, 
	PtPosition.HdCreator, PtPosition.HdChangeDate,   
	PtPosition.HdChangeUser, 
	PtPosition.HdEditStamp, 
	PtPosition.HdVersionNo, 
	PtPosition.HdProcessId, 
	PtPosition.HdStatusFlag, 
	PtPosition.HdNoUpdateFlag, 
	PtPosition.HdPendingChanges,   
	PtPosition.HdPendingSubChanges, 
	PtPosition.HdTriggerControl, 
	PtPosition.PortfolioId,   
	PtPosition.ProdReferenceId, 
                PtPosition.ValueProductCurrency,
	PrReference.AccountId, 
	PtPosition.IsToClose, 
	PtAccountBase.AccountNoText,   
	PtAccountBase.AccountNo, 
	PtAccountBase.AccountNoEdited, 
	PtAccountBase.TerminationDate, 
	PtAccountBase.MgSPESKATId,
	PtAccountBase.MgSITZ,
	PrReference.Currency, 
 	CyBase.RndTypeAmount,   
	PtPortfolio.PartnerId,   
	PtPortfolio.PortfolioNo, 
	PtPortfolio.PortfolioNoText, 
	PtPortfolio.PortfolioNoEdited, 
	PtBase.PartnerNoText,   
	PtBase.PartnerNo, 
	PtBase.PartnerNoEdited, 
	PtBase.FirstName, 
	PtBase.MiddleName, 
	PtBase.Name,   
	PrReference.ProductId,
	PrPrivate.Id as PrPrivateId,
	PrPrivate.ProductNo,
	IsNull(PtContract.WithholdingTaxType,PrPrivate.WithholdingTaxType) as WithholdingTaxType,
	PrPrivate.IsInterestToCalculate, 
	PrPrivate.InterestPracticeType,
	PrPrivate.IsDueRelevant,
	PrPrivate.EndBalanceRoundingType,
                PrPrivate.UseSpecialMortgageClosing,
                PrPrivate.IsMoneyMarket,
                PrPrivate.WithdrawCommRelevant, 
                PrPrivate.BookWithdrawComm
		FROM    PtPosition
INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id 
INNER JOIN PtAccountBase ON PrReference.AccountId = PtAccountBase.Id 
INNER JOIN CyBase On PrReference.Currency = CyBase.Symbol   
INNER JOIN PtPortfolio ON PtPosition.PortfolioId = PtPortfolio.Id AND 
		PtAccountBase.PortfolioId = PtPortfolio.Id 
INNER JOIN PtBase ON PtPortfolio.PartnerId = PtBase.Id
INNER JOIN PrPrivate ON PrReference.ProductId = PrPrivate.ProductId
left outer join PtContractPartner on PtAccountBase.AccountNo = PtContractPartner.MMAccountNo and PtContractPartner.ContractId = (Select top 1 Id from PtContract Where Status = 4 and Id = PtContractPartner.ContractId)
left outer join PtContract on PtContractPartner.ContractId = PtContract.Id and PtContract.Status = 4
WHERE (PtPosition.HdVersionNo > 0) AND (PtPosition.HdVersionNo < 999999999)  
and PtPosition.Id = @id
