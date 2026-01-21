--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfolioTransInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfolioTransInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfolioTransInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfolioTransInfo
@TransMessageID UniqueIdentifier
As

Select PtTransMessage.PaymentDate, PtTransMessage.TradeDate, DebitAccountNo,CreditAccountNo, PaymentCurrency, PaymentAmount, 
DebitPortfolioId,CreditPortfolioId, PtTransMessage.DebitAmount, PtTransMessage.CreditAmount, 
PtTransMessage.DebitQuantity, PtTransMessage.CreditQuantity, PtTransMessage.TradePrice,
PtTransMessage.CreditAccountCurrency, PtTransMessage.DebitAccountCurrency,  
PtTransMessage.DebitValueDate,PtTransMessage.CreditValueDate ,PtTransMessage.DebitRate,PtTransMessage.CreditRate, 
DP.PartnerId as DPartnerId, CP.PartnerId as CPartnerId, 
DAPMSTrans.Id as DebitAPMSId,CAPMSTrans.Id as CreditAPMSId, DPPMSTRans.Id as DebitPPMSId,CPPMSTRans.Id as CreditPPMSId,
DP.PortfolioNo As DebitPortfolioNo,CP.PortfolioNo As CreditPortfolioNo, DP.Currency as DebitPortfolioCurrency, CP.Currency as CreditPortfolioCurrency, DPart.PartnerNo As DebitPartnerNo,CPart.PartnerNo as CreditPartnerNo, PtTransMessage.BankInternalReference,
isnull(DRef.Currency,Prod.ExposureCurrency) as DRefCurrency, isnull(CRef.Currency,Prod.ExposureCurrency) as CRefCurrency,
Dref.IsShortToff  as DIsShortToff,Cref.IsShortToff as CIsShortToff,
Prod.VDFInstrumentSymbol, Prod.Id as PublicId, Prod.UnitNo,Prod.ActualInterest,Prod.SecurityType,Issuer.PartnerNo as IssuerPartnerNo, IssuePaymentDate,PrPublicRefType.FieldShortLong, StrikeCF.Amount as Strike, RightType.RightTypeNo,
OwnCommCharge.Amount as OwnCommAmount, OwnCommCharge.AmountChargeCurrency as OwnCommChargeCurrency, OwnCommCharge.RelatedToDebit as OwnCommIsDebitRelated, OwnCommCharge.AmountValue as OwnCommValue,OwnCommCharge.SourcePosAmountAcCu as  OwnCommSourcePosAmountAcCu,
ForeignCommCharge.Amount as ForeignCommAmount, ForeignCommCharge.AmountChargeCurrency as ForeignCommChargeCurrency, ForeignCommCharge.RelatedToDebit as ForCommIsDebitRelated,ForeignCommCharge.AmountValue as ForeignCommValue, ForeignCommCharge.SourcePosAmountAcCu as  FCSourcePosAmountAcCu,
StampDuty.Amount as StampDutyAmount, StampDuty.AmountChargeCurrency as StampDutyAmtChargeCurrency,StampDuty.RelatedToDebit as StampDutyIsDebitRelated,StampDuty.AmountValue as StampDutyValue, StampDuty.SourcePosAmountAcCu as  StampDutySourcePosAmountAcCu,
CorpActTax.Amount as CorpActTax,CorpActTax.AmountChargeCurrency as CorpActTaxAmtChargeCurrency, CorpActTax.RelatedToDebit as CATaxIsDebitRelated,CorpActTax.AmountValue as CorpActTaxValue,CorpActTax.SourcePosAmountAcCu as CorpActTaxSourcePosAmountAcCu,
AccruedInterest.Comment as AIComment, AccruedInterest.AmountChargeCurrency as AIAmtChargeCurrency, AccruedInterest.Amount as AIAmount,AccruedInterest.RelatedToDebit as AIIsDebitRelated,AccruedInterest.AmountValue as AIAmountValue,AccruedInterest.SourcePosAmountAcCu as AISourcePosAmountAcCu,
SWXCharge.AmountChargeCurrency as SxAmountChargeCurrency,SWXCharge.Amount as SxChargeAmount,SWXCharge.RelatedToDebit as SXChargeIsDebitRelated,SWXCharge.AmountValue as SWXChargeValue,SWXCharge.SourcePosAmountAcCu as SWXChargeSourcePosAmountAcCu,
TrMsgPrice.Price as TrMsgTradePlacePrice, TrMsgPrice.Currency as TrMsgTradePlacePriceCur, 
PrPubPrice.Price as PubTradePlacePrice, PrPubPrice.Currency as PubTradePlacePriceCur,
DProd.ProductNo as DProductNo, Dprod.AccountGroupNo as DAccountGroupNo,
CProd.ProductNo as CProductNo, Cprod.AccountGroupNo as CAccountGroupNo,
DP.MasterPortfolioId as DMasterPortfolioId, CP.MasterPortfolioId as CMasterPortfolioId,
DRelSlave.Id as DSlaveRelId,CRelSlave.Id as CSlaveRelId, InstrumentTypeNo, 
PtTransMessage.DebitTransText, PtTransMessage.CreditTransText, DRef.MaturityDate as DMaturityDate,CRef.MaturityDate as CMaturityDate,DebitPrReferenceId,CreditPrReferenceId, CP.PortfolioTypeNo as CPortfolioTypeNo,DP.PortfolioTypeNo as DPortfolioTypeNo,
CP.Currency as DPortfolioCurrency, CP.Currency as CPortfolioCurrency,DA.PortfolioId as DAPortfolioId,CA.PortfolioId as CAPortfolioId,Prod.NominalCurrency,Prod.MajorTradingPlaceId,PrPublicTradingPlace.VdfInstituteSymbol,
DebitAmountCv, DebitAmountCvAcCu,CreditAmountCv, CreditAmountCvAcCu, CreditRateAcCuPfCu,DebitRateAcCuPfCu,DebitCvCurrency,CreditCvCurrency,
GenTransCharge.Amount as GenTransChargeAmount, GenTransCharge.AmountChargeCurrency as GenTransAmtChargeCurrency,GenTransCharge.RelatedToDebit as GenTransChargeIsDebitRelated,GenTransCharge.AmountValue as GenTransChargeValue
from PtTransMEssage

inner join PtPortfolio DP on PtTransMEssage.DebitPortfolioId = DP.Id
inner join PtBase DPart on DPart.Id = DP.PartnerId
left outer join PtAccountBase DA on PtTransMessage.DebitAccountNo = DA.AccountNo
left outer join PtPMSAccountTransfer DAPMSTrans on DA.Id = DAPMSTrans.AccountId 
left outer join PtPMSPortfolioTransfer  DPPMSTRans on DP.Id =DPPMSTRans.PortfolioId
left outer join PrReference DRef on PtTransMessage.DebitPrReferenceId = DRef.Id
left outer join PrPrivate DProd on DRef.ProductId = DProd.ProductId
left outer join PtRelationSlave DRelSlave on DPart.Id = DRelSlave.PartnerId and DRelSlave.HdVersionNo between 1 and 999999998 and DRelSlave.RelationRoleNo = 7


inner join PtPortfolio CP on  PtTransMEssage.CreditPortfolioId  = CP.ID
inner join PtBase CPart on CPart.Id = CP.PartnerId
left outer join PtAccountBase CA on PtTransMessage.CreditAccountNo = CA.AccountNo
left outer join PtPMSAccountTransfer CAPMSTrans on CA.Id = CAPMSTrans.AccountId 
left outer join PtPMSPortfolioTransfer  CPPMSTRans on CP.Id = CPPMSTRans.PortfolioId
left outer join PrReference CRef on PtTransMessage.CreditPrReferenceId = CRef.Id
left outer join PrPrivate CProd on CRef.ProductId = CProd.ProductId
left outer join PtRelationSlave CRelSlave on CPart.Id = CRelSlave.PartnerId and CRelSlave.HdVersionNo between 1 and 999999998 and CRelSlave.RelationRoleNo = 7


left outer join PrPublic Prod on ((CRef.ProductId = Prod.ProductId and PtTransMessage.CreditQuantity <> 0) or (DRef.ProductId = Prod.ProductId and PtTransMessage.DebitQuantity<>0))
	or ((PtTransMessage.CreditQuantity is null or PtTransMessage.CreditQuantity = 0) and (PtTransMessage.DebitQuantity is null or PtTransMessage.DEbitQuantity = 0)
	 and (DRef.ProductId = Prod.ProductId or CRef.ProductId = Prod.ProductId) )
left outer join PtBase Issuer on Prod.IssuerId = Issuer.Id 
left outer join PrPublicRefType on PRod.RefTypeNo = PrPublicRefType.RefTypeNo
left outer join PrPublicIssue on PRod.Id = PrPublicIssue.PublicId
left outer join PrPublicCF StrikeCF on Prod.Id = StrikeCF.PublicId and StrikeCF.PaymentFuncNo = 18
left outer join PrPublicCF RightType on Prod.Id = StrikeCF.PublicId and StrikeCF.PaymentFuncNo = 1
left outer join PrPublicPrice TrMsgPrice on PtTransMessage.PublicTradingPlaceId = TrMsgPrice.PublicTradingPlaceId and TrMsgPrice.PublicId = Prod.ID
and TrMsgPrice.PriceDate = PtTransMessage.TradeDate
left outer join PrPublicPrice PrPubPrice on Prod.MajorTradingPlaceId = PrPubPrice.PublicTradingPlaceId and PrPubPrice.PublicId = Prod.ID
and PrPubPrice.PriceDate = PtTransMessage.TradeDate
left outer join PrPublicTradingPlace on Prod.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join
(
Select PtTransMessageCharge.* from PtTransMessageCharge
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and PtTransChargeType.IsForOwnCommission = 1
Where PtTransMessageCharge.TransMessageId = @TransMessageID and PtTransMessageCharge.HdVersionNo between 1 and 999999998
) OwnCommCharge on OwnCommCharge.TransMessageId  = @TransMessageId

left outer join
(
Select TransMessageId, RelatedToDebit,Sum(Amount) as Amount,  Sum(AmountChargeCurrency) as AmountChargeCurrency, Sum(AmountValue) as AmountValue, Sum(SourcePosAmountAcCu) as SourcePosAmountAcCu from PtTransMessageCharge
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and (PtTransChargeType.IsForStampDuty = 1 or PtTransChargeType.IsForUKStampDuty = 1)
Where PtTransMessageCharge.TransMessageId = @TransMessageID and PtTransMessageCharge.HdVersionNo between 1 and 999999998
Group by TransMessageId, RelatedToDebit
) StampDuty on StampDuty.TransMessageId  = @TransMessageId

left outer join
(
Select TransMessageId, RelatedToDebit,Sum(Amount) as Amount,  Sum(AmountChargeCurrency) as AmountChargeCurrency, Sum(AmountValue) as AmountValue, Sum(SourcePosAmountAcCu) as SourcePosAmountAcCu  from PtTransMessageCharge  
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and PtTransChargeType.IsForCorpActTax = 1  
Where PtTransMessageCharge.TransMessageId = @TransMessageID and PtTransMessageCharge.HdVersionNo between 1 and 999999998 
Group by TransMessageId, RelatedToDebit
) CorpActTax on CorpActTax.TransMessageId  = @TransMessageId

left outer join
(
Select PtTransMessageCharge.* from PtTransMessageCharge
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and PtTransChargeType.IsForForeignCommission = 1
Where PtTransMessageCharge.TransMessageId = @TransMessageID and PtTransMessageCharge.HdVersionNo between 1 and 999999998
) ForeignCommCharge on ForeignCommCharge.TransMessageId  = @TransMessageId

left outer join
(
Select PtTransMessageCharge.* from PtTransMessageCharge
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and PtTransChargeType.IsForAccruedInterest = 1
Where PtTransMessageCharge.TransMessageId = @TransMessageID and PtTransMessageCharge.HdVersionNo between 1 and 999999998
) AccruedInterest on AccruedInterest.TransMessageId  = @TransMessageId

left outer join
(
Select PtTransMessageCharge.* from PtTransMessageCharge
Where PtTransMessageCharge.TransMessageId = @TransMessageID and TransSxTariffNo between 4000 and 5999 and PtTransMessageCharge.HdVersionNo between 1 and 999999998
) SWXCharge on SWXCharge.TransMessageId  = @TransMessageId

left outer join
(
Select TransMessageId, RelatedToDebit,Sum(Amount) as Amount,  Sum(AmountChargeCurrency) as AmountChargeCurrency, Sum(AmountValue) as AmountValue, Sum(SourcePosAmountAcCu) as SourcePosAmountAcCu from PtTransMessageCharge
inner join PtTransChargeType on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id  and PtTransChargeType.IsForAccruedInterest = 0 and IsForForeignCommission = 0
	and IsForCorpActTax = 0 and IsForUKStampDuty = 0 and IsForOwnCommission=0 and IsForStampDuty = 0
Where PtTransMessageCharge.TransMessageId = @TransMessageID and (not (TransSxTariffNo between 4000 and 5999))
and PtTransMessageCharge.HdVersionNo between 1 and 999999998
Group by TransMessageId, RelatedToDebit
) GenTransCharge on GenTransCharge.TransMessageId  = @TransMessageId

Where PtTransMessage.Id = @TransMessageID
