--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSContractInfoMMRefDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSContractInfoMMRefDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSContractInfoMMRefDate
CREATE OR ALTER PROCEDURE dbo.GetPMSContractInfoMMRefDate
@ReferenceDate DateTime,  @AccountNo Decimal (11,0), @VARundId UniqueIdentifier
AS

Select top 1 PtContract.*, CT.ProductNo,CT.IsDebit,CT.IsFxTrade,CT.IsCallContract,CT.IsFiduciary,CT.NumAdvanceClosingDay,
CT.FiduciaryBorrowProductNo,CT.IsRepo,CT.IsBond,CT.CapitalPaybackRequired, 
PtContractPartner.IsInvestor, PtContractPartner.ConversionRate ,
PtContractPartner.ConversionRatePayback, PtContractPartner.ConversionRateInterestPayment, PtTransType.TransTypeNo
,PtTransType.PMSTransCodeDebit,PtTransType.PMSTransCodeCredit,PtTransType.PMSTransCategory , VAPosQuant.AccruedInterestPrCu
from PtContractPartner 
inner join PtContract on PtContractPartner.ContractId = PtContract.Id
inner join PtContractType CT on PtContract.ContractType = CT.contractType
inner join PtPaymentOrderType on CT.OrderTypeCapitalPayment = PtPaymentOrderType.OrderTypeNo
inner join PtTransType on PtPaymentOrderType.TransTypeNo = PtTransType.TransTypeNo
inner join PtAccountBase on PtAccountBase.AccountNo = @AccountNO
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceID
left outer join VAPosQuant on PtPosition.Id = VAPosQuant.PositionId and VAPosQuant.VarunId = @VARundId
Where MMAccountNo = @AccountNo and @ReferenceDate between PtContract.DateFrom and PtContract.DateTo
Order by PtContract.DateFrom desc

