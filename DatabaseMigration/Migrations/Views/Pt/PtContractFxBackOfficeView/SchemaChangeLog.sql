--liquibase formatted sql

--changeset system:create-alter-view-PtContractFxBackOfficeView context:any labels:c-any,o-view,ot-schema,on-PtContractFxBackOfficeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractFxBackOfficeView
CREATE OR ALTER VIEW dbo.PtContractFxBackOfficeView AS
SELECT PtContract.Id,
PtContract.HdCreateDate,
PtContract.HdCreator,
PtContract.HdChangeDate,
PtContract.HdChangeUser,
PtContract.HdEditStamp,
PtContract.HdVersionNo,
PtContract.HdProcessId,
PtContract.HdStatusFlag,
PtContract.HdNoUpdateFlag,
PtContract.HdPendingChanges,
PtContract.HdPendingSubChanges,
PtContract.HdTriggerControl, 
PtPortfolio.PartnerId,
PtPortfolio.PortfolioNo,
PtBase.PartnerNo,
PtContract.ContractNo,  PtContract.PortfolioId, PtContract.ContractType, PtContract.AgentId, PtContract.InternalRemark, PtContract.OrderDate,
PtContract.Currency, PtContract.Amount, PtContract.DateFrom, PtContract.DateTo, PtContract.InterestPracticeType, 
PtContract.TerminationDate,PtContract.ExternalRemark,
PtContract.FxBuyCurrMktRate,
PtContract.FxSellCurrMktRate,
PtContractPartner.IsFxBuyer, 
PtContract.Status,PtContract.FxSellCurrency, PtContract.FxBuyCurrency, 
CASE when PtContractPartner.IsFxBuyer=0 Then ptContract.FxBuyCurrency ELSE Ptcontract.FxSellCurrency END as CustBuyCurrency,
CASE when PtContractPartner.IsFxBuyer=0 Then ptContract.FxSellCurrency ELSE Ptcontract.FxBuyCurrency END as CustSellCurrency, PtContract.FxTransId,
PtContractPartner.FxDebitAccountNo, PtContractPartner.FxCreditAccountNo, PtContract.HdCreator as OrderCreator, PtContractPartner.ConversionRate as CustomerRate from PtContract
inner join ptContracttype on ptcontract.ContractType = ptcontracttype.ContractType
left outer join PtContractPartner on ptcontract.id = PtContractPartner.ContractId
left outer join PtPortfolio on PtContract.PortfolioId = PtPortfolio.Id
left outer join PtBase on PtPortfolio.PartnerId = PtBase.Id
where PtContracttype.IsFxTrade = 1
