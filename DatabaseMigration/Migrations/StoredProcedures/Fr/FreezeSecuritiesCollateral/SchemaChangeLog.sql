--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeSecuritiesCollateral context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeSecuritiesCollateral,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeSecuritiesCollateral
CREATE OR ALTER PROCEDURE dbo.FreezeSecuritiesCollateral

@ReportDate datetime

AS

DELETE FROM AcFrozenSecurityBalance WHERE ReportDate = @ReportDate and IsCollateral = 1


INSERT INTO AcFrozenSecurityBalance (
HdVersionNo,
ReportDate, 
PartnerId,
PortfolioId, 
PortfolioNo, 
PortfolioTypeNo, 
PortfolioLocGroupId, 
PortfolioNostroTypeId,
PositionId, 
ProdLocGroupId, 
PosNostroTypeId, 
MaturityDate, 
InterestRate, 
ProductId, 
IsinNo, 
FundCatSchemeCode, 
RefTypeNo, 
SecurityType,
InstrumentFormNo, 
InstrumentTypeNo, 
NamingPartnerId, 
RedemptionCode, 
InstrumentCountryCode,
FundTypeNo,
DepositTypeForFire,
PortfolioNoText,
RankingNo,
Currency,
IssuerPartnerId,
TimeUnitNo,
InterestTypeNo,
NominalCurrency,
IsCustomer,
FireStockExListingCode,
DerivativeTypeNo, 
CodeC520,
CodeC541,
Pledgekey,
Quantity, 
MarketValueHoCu, 
CollateralValueHoCu, 
CollNo,
IsCollateral
)

select 1 As HdVersionNo, 
       @ReportDate As ReportDate, 
	   sb.PartnerId,
	   sb.PortfolioId, 
	   sb.PortfolioNo, 
	   sb.PortfolioTypeNo, 
	   sb.PortfolioLocGroupId, 
       sb.PortfolioNostroTypeId,
	   sb.PositionId, 
	   sb.ProdLocGroupId, 
       sb.PosNostroTypeId, 
	   sb.MaturityDate, 
	   sb.InterestRate, 
	   sb.ProductId, 
	   sb.IsinNo, 
	   sb.FundCatSchemeCode, 
	   sb.RefTypeNo, 
	   sb.SecurityType, 
	   sb.InstrumentFormNo, 
	   sb.InstrumentTypeNo, 
	   sb.NamingpartnerId, 
	   sb.RedemptionCode, 
	   sb.InstrumentCountryCode, 
	   sb.FundTypeNo, 
	   sb.DepositTypeForFire, 
	   sb.PortfolioNoText, 
	   sb.RankingNo,
	   sb.Currency, 
	   sb.IssuerPartnerId,
	   sb.TimeUnitNo, 
	   sb.InterestTypeNo, 
	   sb.NominalCurrency, 
	   sb.IsCustomer,
	   sb.FireStockExListingCode, 
	   sb.DerivativeTypeNo, 
	   sb.CodeC520,
	   sb.CodeC541,
	   mv.C551 As Pledgekey,
	   mv.PosValQuantityAdjust As Quantity,
	   mv.PosTotalValueCHFAdjust As MarketValueHoCu, 
	   mv.PosCollateralValueCHFAdjust As CollateralValueHoCu, 
	   mv.CollNo,
	   1 As IsCollateral

/* 
from AcFrozenSecurityBalance sb 
    join CoMevView2000 mv on mv.PositionId = sb.PositionId 
	    -- and (mv.MevYear = 2016 and MevMonth = 04 and sb.ReportDate  = '20141031')
		and mv.MevYear = YEAR(sb.ReportDate) and mv.MevMonth = Month(sb.ReportDate) 
WHERE 
    sb.ReportDate = @ReportDate
	and sb.IsCollateral = 0
*/

from CoMevView2000 mv
	join AcFrozenSecurityBalance sb on sb.PositionId = mv.PositionId
	and sb.ReportDate = @ReportDate
	and sb.IsCollateral = 0
WHERE 
	mv.MevYear = YEAR(@ReportDate) 
	and mv.MevMonth = Month(@ReportDate) 


UPDATE AcFrozenSecurityBalance 
    SET RemainingMarketValueHoCu = MarketValueHoCu - col.MarketValueCollateral, 
	    RemainingQuantity = Quantity - col.QuantityCollateral
FROM AcFrozenSecurityBalance sb
JOIN (
    SELECT ReportDate, PositionId, Sum(MarketValueHoCu) As MarketValueCollateral, Sum(Quantity) As QuantityCollateral
	FROM AcFrozenSecurityBalance
	WHERE ReportDate = @ReportDate
	   AND IsCollateral = 1 
    GROUP BY ReportDate, PositionId) As col
   ON col.ReportDate = sb.ReportDate and col.PositionId = sb.PositionId
WHERE sb.IsCollateral = 0
   and sb.ReportDate = @ReportDate

