--liquibase formatted sql

--changeset system:create-alter-view-AiTaxFatcaIndiciaRepDateView context:any labels:c-any,o-view,ot-schema,on-AiTaxFatcaIndiciaRepDateView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AiTaxFatcaIndiciaRepDateView
CREATE OR ALTER VIEW dbo.AiTaxFatcaIndiciaRepDateView AS
SELECT DISTINCT 
0 AS HdPendingChanges,
0 AS HdPendingSubChanges,
1 AS HdVersionNo,
CONVERT(VARCHAR(10),i.ReportDate,120) AS ReportDate
FROM   AiTaxFatcaIndicia i

