--liquibase formatted sql

--changeset system:create-alter-view-PtContractFXClientPartnerView context:any labels:c-any,o-view,ot-schema,on-PtContractFXClientPartnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractFXClientPartnerView
CREATE OR ALTER VIEW dbo.PtContractFXClientPartnerView AS
select Id,
HdCreateDate,
HdCreator,
HdChangeDate,
HdChangeUser,
HdEditStamp,
HdVersionNo,
HdProcessId,
HdStatusFlag,
HdNoUpdateFlag,
HdPendingChanges,
HdPendingSubChanges,
HdTriggerControl, 
ContractId,
PortfolioId,
ContributionAmount,
PartnerDescription,
FxDebitAccountNo,
FxCreditAccountNo
ConversionRate,IsFxBuyer
from PtContractPartner
