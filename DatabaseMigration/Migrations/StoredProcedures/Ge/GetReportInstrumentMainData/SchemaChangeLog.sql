--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportInstrumentMainData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportInstrumentMainData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportInstrumentMainData
CREATE OR ALTER PROCEDURE dbo.GetReportInstrumentMainData
@PublicId UniqueIdentifier

AS

SELECT  VdfInstrumentSymbol, NamingPartnerId, InstrumentFormNo, IsinNo, InstrumentTypeNo, SecurityType, RankingNo, 
                UsIrsIncomeCode, FundTypeNo, NominalCurrency, ExposureCurrency, UnitNo, ContractSize, ActualInterest, RefTypeNo, 
	RedemptionCode, PartnerId, CountryCode, FundCatSchemeCode
FROM      PrPublicInstrumentMainDataView
WHERE Id = @PublicId

