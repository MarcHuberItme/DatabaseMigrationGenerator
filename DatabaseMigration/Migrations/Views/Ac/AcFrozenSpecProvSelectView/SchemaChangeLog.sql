--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenSpecProvSelectView context:any labels:c-any,o-view,ot-schema,on-AcFrozenSpecProvSelectView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenSpecProvSelectView
CREATE OR ALTER VIEW dbo.AcFrozenSpecProvSelectView AS



select FA.AccountId AS Id, FA.HdVersionNo, FA.HdPendingChanges, FA.HdPendingSubChanges, FA.HdEditStamp, FA.HdCreator, FA.HdChangeUser, FA.HdProcessId, FA.HdStatusFlag, 
Pt.PartnerNo, Pt.ReportAdrLine, Pf.PortfolioNo, FA.AccountNo, NULL AS IsinNo, NULL AS MaturityDate, NULL AS InterestRate, FA.ValueHoCu AS AmountHoCu, NULL AS InterestsHoCu, NULL AS ConsolidAcrInterestDebHoCu, 
FA.AccountId AS SourceRecordId, 'AcFrozenAccount' AS SourceTableName, Pt.ReportDate,  1 AS SpecificProvisionTypeNo, Acc.AccountNoEdited + ' (' + CAST(Pt.PartnerNo AS VARCHAR(20)) + ') ' + Pt.ReportAdrLine  AS PosDescription
FROM AcFrozenAccount AS FA 
INNER JOIN PtAccountBase AS Acc ON FA.AccountNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN AcFrozenPartner AS Pt ON Pf.PartnerId = Pt.PartnerId AND Pt.ReportDate = FA.ReportDate
WHERE FA.ValueHoCu < 0 AND FA.OperationTypeNo = 20
AND FA.AccountId NOT IN (SELECT SourceRecordId FROM AcFrozenSpecificProvision WHERE ReportDate = FA.ReportDate AND SourceRecordId = FA.AccountId)

UNION ALL

SELECT FSB.Id, FSB.HdVersionNo, FSB.HdPendingChanges, FSB.HdPendingSubChanges, FSB.HdEditStamp, FSB.HdCreator, FSB.HdChangeUser, FSB.HdProcessId, FSB.HdStatusFlag, FP.PartnerNo, FP.ReportAdrLine, FSB.PortfolioNo, NULL AS AccountNo, IsinNo, MaturityDate, InterestRate, OwnSecurityValueHoCu AS AmountHoCu, NULL, NULL, 
FSB.Id AS SourceRecordId, 'AcFrozenSecurityBalance' AS SourceTableName, FSB.ReportDate,  2 AS SpecificProvisionTypeNo, CAST(FP.PartnerNo AS VARCHAR(20)) + '(' + IsinNo + ') ' + FP.ReportAdrLine  AS PosDescription
FROM AcFrozenSecurityBalance AS FSB
INNER JOIN AcFireMappingPortfolio AS MP ON FSB.PortfolioId = MP.PortfolioId
INNER JOIN AcFrozenPartner AS FP ON FSB.NamingPartnerId = FP.PartnerId AND FSB.ReportDate = FP.ReportDate
WHERE OwnSecurityValueHoCu > 0
