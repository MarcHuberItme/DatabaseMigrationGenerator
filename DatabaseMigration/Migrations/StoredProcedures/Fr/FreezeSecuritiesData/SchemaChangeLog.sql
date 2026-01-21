--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeSecuritiesData context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeSecuritiesData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeSecuritiesData
CREATE OR ALTER PROCEDURE dbo.FreezeSecuritiesData
@ReportDate datetime

AS

DELETE FROM AcFrozenSecurityBalance WHERE ReportDate = @ReportDate

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
Pos.Quantity, 
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
IsCollateral,
OutstandingInterestDueDate,
BeginDate)

SELECT 
1,
@ReportDate, 
PartnerId, 
PortfolioId, 
PortfolioNo, 
PortfolioTypeNo, 
LocGroupId, 
NostroTypeId, 
PositionId, 
ProdLocGroupId, 
PosNostroTypeId, 
Quantity, 
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
IssuerId, 
TimeUnitNo, 
InterestTypeNo, 
NominalCurrency, 
IsCustomer,
0,
--FROM PtPositionFireView
--where  (Quantity <> 0 or LatestTransDate > DATEADD(month, -3, @ReportDate))
I.OutstandingInterestDueDate,
BK.BeginDate
FROM PtPositionFireView V Outer Apply (
	Select Top 1 DueDate As OutstandingInterestDueDate
	From PrPublicCf CF Join PrPublic Pub On CF.PublicId=Pub.Id
	Where 1=1
	And V.ProductId=ProductId And DueDate>@ReportDate
	And CashFlowFuncNo=4 And PaymentFuncNo=17 And CashFlowStatusNo=13
	Order By DueDate ASC
) I
Outer Apply (
	Select Top 1 TransDate As BeginDate
	From PtTransItem
	Where PositionId=V.PositionId
	Order By ValueDate Asc
) BK

