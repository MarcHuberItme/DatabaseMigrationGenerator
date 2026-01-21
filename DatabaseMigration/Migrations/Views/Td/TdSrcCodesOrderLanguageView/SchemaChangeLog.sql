--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderLanguageView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderLanguageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderLanguageView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderLanguageView AS
SELECT TOP (100) PERCENT
	 HdVersionNo, TdCodeValue AS ReportLanguage, TdCodeDescription AS TextShort
FROM TdCodes
WHERE TdCodeGroup = N'TdOrder'
	AND TdCodeItem = N'TdReportLanguage'
	AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY 2
