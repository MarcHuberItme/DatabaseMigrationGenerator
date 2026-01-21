--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPendingBenchmarkPriceDays context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPendingBenchmarkPriceDays,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPendingBenchmarkPriceDays
CREATE OR ALTER PROCEDURE dbo.GetPMSPendingBenchmarkPriceDays
As
select distinct convert(varchar(8),PriceDate,112) as FormattedDate
from PrPublic
inner join PrReference on PrPublic.ProductId = PrReference.ProductId
inner join PtPMSSecurityTransfer on PrPublic.Id = PtPMSSecurityTransfer.PublicProdId and PtPMSSecurityTransfer.InternalRejectCode = 0
inner join PrPublicPrice on PrPublicPrice.PublicId = PrPublic.Id
left outer join PrPublicTradingPlace  on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
inner join PrPublicPriceType  on PrPublicPrice.PriceTypeNo = PrPublicPriceType.PriceTypeNo
left outer join PtPMSTransferProcess on convert(varchar(8),PriceDate,112) = convert(varchar(8),TransDate,112)
and TransferTypeCode = 21
Where InstrumentTypeNo = 7
and PrPublicPrice.PriceTypeNo = 1
and PrPublic.ID not in
(
Select distinct PublicId from PtPMSSecurityPriceTransfer
)
Order by 1
