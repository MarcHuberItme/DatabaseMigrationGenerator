--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAcctTransInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAcctTransInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAcctTransInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSAcctTransInfo
@TransMessageID UniqueIdentifier
As

Select DebitAccountNo,CreditAccountNo, PaymentCurrency, PaymentAmount, DebitPortfolioId,CreditPortfolioId, PtTransMessage.DebitAccountCurrency, 
PtTransMessage.CreditAccountCurrency, PtTransMessage.DebitValueDate,PtTransMessage.CreditValueDate ,PtTransMessage.DebitRate,PtTransMessage.CreditRate, DP.PartnerId as DebitPartnerId, CP.PartnerId as CreditPartnerId, 
PtTransMessage.DebitTransText, PtTransMessage.CreditTransText,
DAPMSTrans.Id as DebitAPMSId,
CAPMSTrans.Id as CreditAPMSId,DP.PortfolioNo As DebitPortfolioNo,CP.PortfolioNo As CreditPortfolioNo, DPart.PartnerNo As DebitPartnerNo,CPart.PartnerNo as CreditPartnerNo, 
DAPMSTrans.InternalRejectCode as DARejectCode,
CAPMSTrans.InternalRejectCode as CARejectCode,
DProd.ProductNo as DProductNo, Dprod.AccountGroupNo as DAccountGroupNo,
CProd.ProductNo as CProductNo, Cprod.AccountGroupNo as CAccountGroupNo,
Cprod.IsMoneyMarket as CIsMoneyMarket, DProd.IsMoneyMarket as DIsMoneyMarket,
DP.MasterPortfolioId as DMasterPortfolioId,CP.MasterPortfolioId as CMasterPortfolioId,
DPart.Id as DPartnerId,CPart.Id as CPartnerId, DRelSlave.Id as DSlaveRelId,CRelSlave.Id as CSlaveRelId,
DP.Currency as DPortfolioCurrency, CP.Currency as CPortfolioCurrency,
/*Sum(Ditem.DebitAmount- Ditem.CreditAmount) as DebitAmount ,
Sum(Citem.CreditAmount- Citem.DebitAmount) as CreditAmount*/
PtTransMessage.DebitAmount,PtTransMessage.CreditAmount,
DebitGroupKey,CreditGroupKey, CancelTransMsgId,
DI.StartRefDate as DStartRefDate,CI.StartRefDate as CStartRefDate
from PtTransMEssage

left outer join PtAccountBase DA on PtTransMessage.DebitAccountNo = DA.AccountNo
left outer join PrReference DRef on DA.Id = DRef.AccountId and DebitPrReferenceId = DRef.Id
left outer join PrPrivate DProd on DRef.ProductId = DProd.ProductId
left outer join PtPosition DPos on Dref.Id = DPos.ProdReferenceId
/*inner join PtTransItemFull DItem on PtTransMessage.ID = Ditem.MessageId And DPos.ID = DItem.PositionId */
left outer join PtPortfolio DP on DA.PortfolioId = DP.Id
left outer join PtBase DPart on DPart.Id = DP.PartnerId
left outer join PtPMSAccountTransfer DAPMSTrans on DA.Id = DAPMSTrans.AccountId 
left outer join PtRelationSlave DRelSlave on DPart.Id = DRelSlave.PartnerId and DRelSlave.HdVersionNo between 1 and 999999998 and DRelSlave.RelationRoleNo = 7
left outer join PtInsaPartner DI on Di.PartnerId = DPart.Id

left outer join PtAccountBase CA on PtTransMessage.CreditAccountNo = CA.AccountNo
left outer join PrReference CRef on CA.Id = CRef.AccountId and CreditPrReferenceId = CRef.Id
left outer join PrPrivate CProd on CRef.ProductId = CProd.ProductId
left outer join PtPosition CPos on Cref.Id = CPos.ProdReferenceId
/*inner join PtTransItemFull CItem on PtTransMessage.ID = Citem.MessageId And CPos.ID = CItem.PositionId */
left outer  join PtPortfolio CP on CA.PortfolioId = CP.Id
left outer  join PtBase CPart on CPart.Id = CP.PartnerId
left outer join PtPMSAccountTransfer CAPMSTrans on CA.Id = CAPMSTrans.AccountId 
left outer join PtRelationSlave CRelSlave on CPart.Id = CRelSlave.PartnerId and CRelSlave.HdVersionNo between 1 and 999999998 and CRelSlave.RelationRoleNo = 7
left outer join PtInsaPartner CI on CI.PartnerId = CPart.Id

Where PtTransMessage.Id = @TransMessageID
/*
Group by DebitAccountNo,CreditAccountNo, PaymentCurrency, PaymentAmount,  DebitPortfolioId,CreditPortfolioId,
PtTransMessage.DebitAccountCurrency, PtTransMessage.CreditAccountCurrency,PtTransMessage.DebitValueDate,PtTransMessage.CreditValueDate,
 PtTransMessage.DebitRate,PtTransMessage.CreditRate,
DP.PartnerId, CP.PartnerID,   PtTransMessage.DebitTransText, PtTransMessage.CreditTransText,
DAPMSTrans.Id,CAPMSTrans.Id,DP.PortfolioNo,CP.PortfolioNo, DPart.PartnerNo,CPart.PartnerNo,
DAPMSTrans.InternalRejectCode, CAPMSTrans.InternalRejectCode,
DProd.ProductNo , Dprod.AccountGroupNo ,
CProd.ProductNo , Cprod.AccountGroupNo ,
Cprod.IsMoneyMarket, Dprod.IsMoneyMarket, 
DP.MasterPortfolioId ,CP.MasterPortfolioId ,
DPart.Id ,CPart.Id , DRelSlave.Id ,CRelSlave.Id, 
DP.Currency,CP.Currency
*/
