--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityInfo
@PublicId UniqueIdentifier
As
DECLARE @PrefVdfInstituteSymbol varchar(12)

Select top 1 @PrefVdfInstituteSymbol = PrPublicTradingPlace .VdfInstituteSymbol  from PrPublicListing 
inner join PrPublictradingPlace on  PrPublicListing.PublicTradingPlaceId = PrPublicTradingPlace.Id and VdfInstituteSymbol is not  null and SelPrioInt is not null
Where PublicId = @PublicId
and PrPublicListing.HdVersionNo between 1 and 99999998
order by SelPrioInt

Select PrPublic.*, PrPublicMaturityView.DueDate, PrPublicMaturityView.ShortName, PrPublicMaturityView.LongName,PrPublicMaturityView.PublicDescription, PrPublicTradingPlace.VdfInstituteSymbol,
PtSector.SectorCode,PtFiscalCountry.CountryCode as SecurityCountry,PrPublicIssue.InterestFromDate, PrPublicIssue.IssuePaymentDate,
IsNull(PrPublicListing.IsFlat,0) as IsFlat, CFConv.Amount as StrikingPrice,CFConv.RightTypeNo,CFConv.PublicUnderlyingId,PrPublicDayCountConv.PMSDayCountCode, PtBase.VdfInstituteSymbol as IssuerVdfInstituteSymbol,
PrPublicSecurityType.PMSSecurityType, @PrefVdfInstituteSymbol as PrefVdfInstituteSymbol, PMSDistFrequencyNo, PMSAssetType
from PrPublic
inner join PrPublicMaturityView on PrPublic.Id = PrPublicMaturityView.Id and LanguageNo = 2
left outer join PtBaseStructure on PrPublic.IssuerId = PtBaseStructure.MasterId and TableName = 'PtSector' and Scheme = 'TKBN'

left outer join PtBaseStructureAssign on PtBaseStructure.Id = PtBaseStructureAssign.structureId and PtBaseStructureAssign.HdVersionNo between 1 and 999999998
left outer join PtSector on PtBaseStructureAssign.ForeignKeyId = PtSector.Id
inner join PtBase on PrPublic.IssuerId = PtBase.Id 
left outer join PtFiscalCountry on PrPublic.IssuerId = PtFiscalCountry.PartnerId and PtFiscalCountry.IsPrimaryCountry = 1
left outer join PrPublicIssue on PrPublic.Id = PrPublicIssue.PublicId
inner join PrPublicSecurityType on PrPublic.SecurityType = PrPublicSecurityType.SecurityType
left outer join PrPublicTradingPlace on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join PrPublicListing on PrPublicListing.PublicTradingPlaceId = PrPublic.MajorTradingPlaceId and PrPublicListing.PublicId = PrPublic.Id and PrPublicListing.HDVersionNo between 1 and 999999998
left outer join PrPublicCF CFConv on PrPublic.Id = CFConv.PublicId and CFConv.PaymentFuncNo = 18 and CFConv.HdVersionNo between 1 and 999999998
left outer join PrPublicDayCountConv on PrPublic.DayCountConvNo = PrPublicDayCountConv.DayCountConvNo
left outer join PrPublicDistribFrequency on PrPublic.ActualDistribFrequencyNo = PrPublicDistribFrequency.DistribFrequencyNo
left outer join CyBase on Prpublic.ExposureCurrency = CyBase.Symbol
left outer join CyAssetClass on CyBase.AssetClassNo = CyAssetClass.ClassNo
left outer join PtPMSAssetType PAT on (isnull(AssetTypeManual,AssetTypeCalculated) = PAT.finstarAssetType) and (isnull(PrPublic.AssetClassManual, CyBase.AssetClassNo) = PAT.FinstarAssetCyClass)
Where PrPublic.Id = @PublicId
