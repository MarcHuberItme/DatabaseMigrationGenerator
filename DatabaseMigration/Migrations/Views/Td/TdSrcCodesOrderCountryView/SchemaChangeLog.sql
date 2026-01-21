--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderCountryView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderCountryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderCountryView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderCountryView AS
SELECT TOP (100) PERCENT
	 HdVersionNo, TdCodeValue AS ReportCountry, TdCodeDescription AS TextShort
FROM TdCodes
WHERE TdCodeGroup = N'TdOrder'
	AND TdCodeItem = N'TdReportCountry'
	AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY 2
