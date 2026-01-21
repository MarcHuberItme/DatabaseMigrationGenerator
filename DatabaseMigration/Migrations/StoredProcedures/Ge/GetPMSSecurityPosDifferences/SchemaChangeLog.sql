--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityPosDifferences context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityPosDifferences,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityPosDifferences
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityPosDifferences
AS
Declare @LastNetfolioBalanceDate datetime
Declare @AccountancyPeriod int
Declare @TransferProcessId UniqueIdentifier
DEclare @VaRunId UniqueIdentifier 

exec VaRunIdLastDailyRun @VaRunId Output
 

Select top 1 @TransferProcessId=Id, @LastNetfolioBalanceDate= TransDate  from PtPMsTransferProcess Where TransferTypeCode = 15 
and TransDate = (Select max(TransDate) from PtPMsTransferProcess where TransferTypeCode = 15)

--select @TransferProcessId

Select isnull(a.PartnerNo,b.PartnerNo) as PartnerNo,isnull(a.PortfolioNo,b.PortfolioNo) as PortfolioNo,isnull(a.ISINNo,b.ISIN) as ISINNo
,isnull(a.VdfInstrumentSymbol,b.NetFSecNo) as ValorNr,
a.FinstarQuantity,NetfolioQuantity
from
(
Select  PtBase.PartnerNo,Port.PortfolioNo,Pub.VdfInstrumentSymbol,ISINNo, 
Pub.InstrumentTypeNo, sum(Pos.Quantity) as FinstarPosQuantity, sum(PosVal.Quantity) as FinstarQuantity
from VaPosQuant PosVal
join  PtPosition Pos on Pos.id = PosVal.PositionId
join PtPortfolio Port on Port.id = Pos.PortfolioId
join PtBase on PtBase.id = Port.PartnerId
join PrReference Ref on Ref.id = Pos.ProdReferenceId
join PrPublic Pub on Pub.Productid = Ref.ProductId and Pub.RefTypeNo not in (5,6,7)
join PtPMSPortfolioTransfer PMSPortF on Port.Id = PMSPortF.PortfolioId
join PtInsaPartner on PtBase.Id = PtInsaPartner.PartnerId and IsValidForPMS = 1 
Where 
VARunId = @VARunId and 
InstrumentTypeNo not in (201,203) 
Group by PtBase.PartnerNo,Port.PortfolioNo,Pub.VdfInstrumentSymbol,ISINno, Pub.InstrumentTypeNo
) a

full join
(
Select PartnerNo,ISIN,substring(convert(nvarchar(30) , NetfolioSecurityNo),1, len(NetfolioSecurityNo)-3)  as NetFSecNo ,
PortfolioNo,Sum(Quantity) as  NetfolioQuantity
from PtPMSDailySecurityBalance where LastTransferProcessId = @TransferProcessId
and IsIN is not null
group by PartnerNo, ISIN, substring(convert(nvarchar(30) , NetfolioSecurityNo),1, len(NetfolioSecurityNo)-3),PortfolioNo
) b on
a.PartnerNo = b.PartnerNo and a.PortfolioNo=b.PortfolioNo and a.ISINNo = b.ISIN
Where isNull(a.FinstarQuantity,0) <> isnull(b.NetfolioQuantity,0)
and a.PartnerNo <> 119684
