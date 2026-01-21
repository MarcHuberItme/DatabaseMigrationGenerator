--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderReportTypeView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderReportTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderReportTypeView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderReportTypeView AS
SELECT 
       HdVersionNo, TdCodeValue AS ReportType, TdCodeDescription AS TextShort
FROM 
       TdCodes
WHERE
       TdCodeGroup = N'TdOrder'
       AND TdCodeItem = N'TdReportType'
       AND HdVersionNo BETWEEN 1 AND 999999998
