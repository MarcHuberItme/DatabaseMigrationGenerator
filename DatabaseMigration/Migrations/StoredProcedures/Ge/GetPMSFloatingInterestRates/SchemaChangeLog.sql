--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSFloatingInterestRates context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSFloatingInterestRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSFloatingInterestRates
CREATE OR ALTER PROCEDURE dbo.GetPMSFloatingInterestRates
@LastRunDate DateTime, @CurrentRunId UniqueIdentifier,  @RC int, @transferTypeCode tinyint
As
Select top (@RC) sf.*, VdfInstrumentSymbol,SecurityType, p.ActualInterest,  Amount,EarningPerBeginDate,EarningPerEndDate,
p.Id as PrPublicId, cf.Id as PublicCfId
from PtPMSSecurityTransfer
inner join PrPublic p on PtPMSSecurityTransfer.PublicProdId = p.Id
inner join PrPublicCF cf on p.id = cf.publicId and CF.HdVersionNo between 1 and 999999998
inner join PtPMSTransferType on PtPMSTransferType.TransferTypeCode = @transferTypeCode
left outer join PtPMSSecSingleFieldTransfer sf on cf.Id = sf.SourcerecId
Where  SecurityType in ('L','6') 
and Amount is not null
and EarningPerEndDate > getdate()
and EarningPerBeginDate < getdate()
and ((sf.LastTransferProcessId is null) 
			 or (CF.HdChangeDate > @LastRunDate And sf.LastTransferProcessId <> @CurrentRunId))
and (PtPMSTransferType.UpdatesValidFrom <= CF.HdChangeDate or PtPMSTransferType.UpdatesValidFrom is null) 
order by VdfInstrumentSymbol, EarningPerBeginDate
