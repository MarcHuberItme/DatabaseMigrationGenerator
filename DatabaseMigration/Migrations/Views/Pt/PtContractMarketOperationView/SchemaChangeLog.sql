--liquibase formatted sql

--changeset system:create-alter-view-PtContractMarketOperationView context:any labels:c-any,o-view,ot-schema,on-PtContractMarketOperationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractMarketOperationView
CREATE OR ALTER VIEW dbo.PtContractMarketOperationView AS
SELECT PtContractMarketOperation.Id,
PtContractMarketOperation.HdCreateDate,
PtContractMarketOperation.HdCreator,
PtContractMarketOperation.HdChangeDate,
PtContractMarketOperation.HdChangeUser,
PtContractMarketOperation.HdEditStamp,
PtContractMarketOperation.HdVersionNo,
PtContractMarketOperation.HdProcessId,
PtContractMarketOperation.HdStatusFlag,
PtContractMarketOperation.HdNoUpdateFlag,
PtContractMarketOperation.HdPendingChanges,
PtContractMarketOperation.HdPendingSubChanges,
PtContractMarketOperation.HdTriggerControl,
PtContractMarketOperation.ContractId,
PtContractMarketOperation.OperationTypeNo,
PtContractMarketOperation.InternalRemarks,
PtContractMarketOperation.ExternalRemarks,
PtContractMarketOperation.StatusNo,
PtContractMarketOperation.StatusDate,
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
PtContractPartner.FxDebitAccountNo, PtContractPartner.FxCreditAccountNo, PtContract.HdCreator as OrderCreator, PtContractPartner.ConversionRate as CustomerRate
from  PtContractMarketOperation
inner join PtContract on PtContract.Id = PtContractMarketOperation.ContractId
inner join ptContracttype on ptcontract.ContractType = ptcontracttype.ContractType
left outer join PtContractPartner on ptcontract.id = PtContractPartner.ContractId
left outer join PtPortfolio on PtContract.PortfolioId = PtPortfolio.Id
left outer join PtBase on PtPortfolio.PartnerId = PtBase.Id

