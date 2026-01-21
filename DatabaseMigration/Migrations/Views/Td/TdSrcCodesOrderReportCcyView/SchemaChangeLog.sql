--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderReportCcyView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderReportCcyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderReportCcyView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderReportCcyView AS
SELECT TOP (100) PERCENT
	 HdVersionNo, TdCodeValue AS ReportCurrency, TdCodeDescription AS TextShort
FROM TdCodes
WHERE TdCodeGroup = N'TdOrder'
	AND TdCodeItem = N'TdReportCurrency'
	AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY 2
