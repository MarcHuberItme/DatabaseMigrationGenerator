--liquibase formatted sql

--changeset system:create-alter-view-PtContractFXClientView context:any labels:c-any,o-view,ot-schema,on-PtContractFXClientView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractFXClientView
CREATE OR ALTER VIEW dbo.PtContractFXClientView AS
select PtContract.Id,
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
PtContract.ContractNo,  PtContract.PortfolioId, PtContract.ContractType, PtContract.AgentId,
PtContract.InternalRemark, PtContract.ExternalRemark, PtContract.ContactMediaNo, PtContract.OrderDate, PtContract.Currency, PtContract.Amount,
PtContract.DateFrom, PtContract.DateTo, PtContract.InterestPracticeType, PtContract.Status,
PtContract.FxSellCurrency, PtContract.FxBuyCurrency,
PtContractPartner.FxDebitAccountNo, PtContractPartner.FxCreditAccountNo, PtContract.AdditionalInfo,
PtContract.FxSellCurrMktRate, PtContract.FxBuyCurrMktRate,PtContract.FxTransId, PtContract.HdCreator as OrderCreator
from PtContract
Left outer join PtContractPartner on PtContract.Id = PtContractPartner.ContractId

