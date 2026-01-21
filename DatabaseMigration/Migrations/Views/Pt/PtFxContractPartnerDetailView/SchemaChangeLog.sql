--liquibase formatted sql

--changeset system:create-alter-view-PtFxContractPartnerDetailView context:any labels:c-any,o-view,ot-schema,on-PtFxContractPartnerDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtFxContractPartnerDetailView
CREATE OR ALTER VIEW dbo.PtFxContractPartnerDetailView AS
SELECT 
	Cp.HdVersionNo AS ParticipantHdVersionNo
	,C.HdVersionNo
	,C.Id AS ContractId
	,C.ContractNo AS ContractNo
	,C.ExternalRemark
	,C.InternalRemark
	,C.HdCreateDate
	,C.HdChangeDate
	,C.HdCreator
	,C.HdChangeUser
	,C.HdProcessId
	,C.Amount AS ContractualAmnt
	,C.AgentId
	,C.DeTourGroup
	,C.Status AS StatusNo
	,Cs.Id AS StatusId
	,C.FxTransId AS TransactionId
	,C.Currency
	,
		CASE 
			WHEN Cp.IsFxBuyer = 1 THEN 'BUY'
			ELSE 'SELL'
		END AS Side
	,C.FxBuyCurrency AS BuyCurrency
	,C.FxSellCurrency AS SellCurrency
	,C.OrderDate
	,C.DateFrom
	,C.DateTo
	,C.TerminationDate AS DateOfTermination
	,C.ContractType AS ContractTypeNo
	,Ct.Id AS ContractTypeId
	,C.BranchNo
	,PartnerPortfolio.Id AS PartnerPortfolioId
	,Partner.Id AS PartnerId
	,Partner.PartnerNo
	,Cp.PartnerDescription
	,Cp.FxDebitAccountNo AS DebitAccountNo
	,Cp.FxCreditAccountNo AS CreditAccountNo
	,Cp.ContributionAmount AS ContributionToContractualAmnt
	,Cp.ClientMargin AS ClientMarginValue
	,Cp.MarginValueType AS ClientMarginType
	,MarginValueType.Id AS ClientMarginTypeId
	,Cp.ConversionRate
	,Cp.MarketRate
FROM PtContract C
		JOIN 
		PtContractPartner Cp
		ON Cp.ContractId = C.Id
			JOIN 
			PtPortfolio PartnerPortfolio
			ON PartnerPortfolio.Id = Cp.PortfolioId
				JOIN 
				PtBase Partner
				ON Partner.Id = PartnerPortfolio.PartnerId
					JOIN 
					PtContractType Ct
					ON Ct.ContractType = C.ContractType
						left JOIN 
						MpValueType MarginValueType
						ON MarginValueType.Label = Cp.MarginValueType
							left JOIN 
							PtContractStatus Cs
							ON Cs.ContractStatusNo = C.Status
					WHERE C.ContractType IN (50,51,52,53)





