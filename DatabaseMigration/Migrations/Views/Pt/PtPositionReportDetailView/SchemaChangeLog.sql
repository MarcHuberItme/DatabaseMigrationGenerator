--liquibase formatted sql

--changeset system:create-alter-view-PtPositionReportDetailView context:any labels:c-any,o-view,ot-schema,on-PtPositionReportDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionReportDetailView
CREATE OR ALTER VIEW dbo.PtPositionReportDetailView AS
SELECT	  Id, PositionId
	, SubString(KeyString,222,4)  As PortfolioType
	, SubString(KeyString,16,3)   As Currency
	, SubString(KeyString,35,2)   As LegalStatus
	, SubString(KeyString,47,2)   As CountryDomicile
	, SubString(KeyString,83,3)   As SNBStatisticLine
	, SubString(KeyString,227,3)  As SNBStatisticWeBeKol
	, SubString(KeyString,139,3)  As PrivateProductNo
	, SubString(KeyString,126,12) As PublicProductNo
	, AccountancyPeriod, AmountType, KeyString, CounterValue
	, Quantity
	, ValueProductCurrency, ValueBasicCurrency
FROM PtPositionReportDetail
