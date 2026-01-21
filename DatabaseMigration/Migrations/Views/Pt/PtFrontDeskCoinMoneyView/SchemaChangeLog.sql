--liquibase formatted sql

--changeset system:create-alter-view-PtFrontDeskCoinMoneyView context:any labels:c-any,o-view,ot-schema,on-PtFrontDeskCoinMoneyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtFrontDeskCoinMoneyView
CREATE OR ALTER VIEW dbo.PtFrontDeskCoinMoneyView AS

SELECT Fdcm.Id, Fdcm.BranchNo, Fdcm.ReportDate, Fdcm.ValueHoCu, FM.MappingTypeNo, FM.FireAccountNo
FROM PtFrontDeskCoinMoney AS Fdcm
INNER JOIN AcFireMapping AS FM ON FM.MappingTypeNo = 30
WHERE FM.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT Fdcm.Id, Fdcm.BranchNo, Fdcm.ReportDate, -Fdcm.ValueHoCu AS ValueHoCu, FM.MappingTypeNo, FM.FireAccountNo
FROM PtFrontDeskCoinMoney AS Fdcm
INNER JOIN AcFireMapping AS FM ON FM.MappingTypeNo = 31
WHERE FM.HdVersionNo BETWEEN 1 AND 999999998
