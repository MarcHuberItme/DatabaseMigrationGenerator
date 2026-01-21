--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenSpecProvisionView context:any labels:c-any,o-view,ot-schema,on-AcFrozenSpecProvisionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenSpecProvisionView
CREATE OR ALTER VIEW dbo.AcFrozenSpecProvisionView AS
SELECT *, 
CASE 
WHEN UsableValue >= 0 THEN 0
WHEN -UsableValue  <  SpecProvValueHoCu THEN -UsableValue
ELSE SpecProvValueHoCu
END AS AdjustedSpecProvHoCu,
CASE 
WHEN UsableValue >= 0 THEN SpecProvValueHoCu
WHEN -UsableValue  <  SpecProvValueHoCu THEN SpecProvValueHoCu + UsableValue
ELSE 0
END AS LiabilitiesSpecProvHoCu,
ISNULL(UsableValue,0) + ISNULL(LiquidationValueHoCu,0) AS NetDebtAmountHoCu,
CASE 
WHEN ValueHoCu >= 0 THEN 1
ELSE 2 END AS ValueSign 


FROM (
select 
FSP.Id, FSP.HdVersionNo, FSP.HdPendingChanges, FSP.HdPendingSubChanges, FSP.HdEditStamp, FSP.HdCreator, FSP.HdChangeUser, FSP.HdProcessId, FSP.HdStatusFlag, 
'AcFrozenSpecificProvision' AS SourceTableName, FSP.SpecificProvisionTypeNo, 
ISNULL(FSP.ValueHoCu,0)  AS SpecProvValueHoCu, FSP.Remark, 
FA.AccountNo, NULL AS PortfolioNo, FP.PartnerNo, FP.ReportAdrLine, NULL AS IsinNo, FSP.ReportDate, 
FA.AccountNoText + '-' + FA.Currency AS SpecProvDesc, FA.Currency, FP.CodeC510, FP.LargeExpGroupNo, 
FP.FiscalDomicileCountry, FP.NogaCode2008 AS Noga2008, FA.ValueHoCu AS UsableValue, FSP.ValueHoCu, FP.MainPartnerNo, FSP.LiquidationValueHoCu, FSP.SuppressImpaired
FROM AcFrozenSpecificProvision AS FSP
INNER JOIN AcFrozenAccount AS FA ON FSP.ReportDate = FA.ReportDate AND FA.AccountId = FSP.SourceRecordId
INNER JOIN AcFrozenPartnerView AS FP ON FA.ReportDate = FP.ReportDate AND FA.PartnerId = FP.PartnerId
INNER JOIN AcFireReport AS FR ON FR.ReportDate = FSP.ReportDate
WHERE FR.SpecialProvWithDetails = 1

UNION ALL

select 
FSP.Id, FSP.HdVersionNo, FSP.HdPendingChanges, FSP.HdPendingSubChanges, FSP.HdEditStamp, FSP.HdCreator, FSP.HdChangeUser, FSP.HdProcessId, FSP.HdStatusFlag, 
'AcFrozenSpecificProvision' AS SourceTableName, FSP.SpecificProvisionTypeNo, ISNULL(FSP.ValueHoCu,0) AS SpecProvValueHoCu, FSP.Remark, 
NULL AS AccountNo, FSB.PortfolioNo, FP.PartnerNo, FP.ReportAdrLine, FSB.IsinNo, FSP.ReportDate,
FSB.PortfolioNoText + '-' + ISNULL(FSB.IsinNo,'---') +  '-' + ISNULL(FSB.Currency,'---') AS SpecProvDesc, FSB.Currency, FP.CodeC510, FP.LargeExpGroupNo, 
FP.FiscalDomicileCountry, FP.NogaCode2008 AS Noga2008, -FSB.OwnSecurityValueHoCu AS UsableValue, FSP.ValueHoCu, FP.MainPartnerNo, FSP.LiquidationValueHoCu, FSP.SuppressImpaired
FROM AcFrozenSpecificProvision AS FSP
INNER JOIN AcFrozenSecurityBalance AS FSB ON FSP.SourceRecordId = FSB.Id
INNER JOIN AcFrozenPartnerView AS FP ON FSB.ReportDate = FP.ReportDate AND FSB.NamingPartnerId = FP.PartnerId
INNER JOIN AcFireReport AS FR ON FR.ReportDate = FSP.ReportDate
WHERE FR.SpecialProvWithDetails = 1

UNION ALL

SELECT FA.Id,  FA.HdVersionNo, FA.HdPendingChanges, FA.HdPendingSubChanges, FA.HdEditStamp, FA.HdCreator, FA. HdChangeUser, FA.HdProcessId, FA.HdStatusFlag, 
'AcFrozenAccount' AS SourceTableName, 0 AS SpecificProvisionTypeNo, FA.ValueHoCu AS SpecProvValueHoCu, NULL AS Remark, 
FA.AccountNo, NULL AS PortfolioNo, FP.PartnerNo, FP.ReportAdrLine, NULL AS IsinNo, FA.ReportDate, 
FA.AccountNoText + '-' + FA.Currency + ISNULL(' (' + REPLACE(REPLACE(REPLACE(FA.CustomerReference,',','-') ,CHAR(10),''),CHAR(13),' ') + ')','') AS SpecProvDesc, FA.Currency, 0 AS CodeC510, NULL AS LargeExpGroupNo, 
FP.FiscalDomicileCountry, FP.NogaCode2008 AS Noga2008, FA.ValueHoCu AS UsableValue, FA.ValueHoCu, FP.MainPartnerNo, NULL AS LiquidationValueHoCu, 0 As SuppressImpaired
FROM AcFrozenAccount AS FA
INNER JOIN AcBalanceStructure AS BS ON FA.AccountNo = BS.BalanceAccountNo AND BS.HdVersionNo BETWEEN 1 AND 999999998 AND BS.BalanceSheetTypeNo = 20
INNER JOIN AcFireMapping AS FM ON BS.FireAccountNo = FM.FireAccountNo AND FM.HdVersionNo BETWEEN 1 AND 999999998
INNER JOIN AcFireReport AS FR ON FA.ReportDate = FR.ReportDate
INNER JOIN AcFrozenPartnerView AS FP ON FA.ReportDate = FP.ReportDate AND FA.PartnerId = FP.PartnerId
WHERE FM.MappingTypeNo IN (
	SELECT FMT.MappingTypeNo
	FROM AcFireMappingType AS FMT
	INNER JOIN AsGroupMember AS GM ON FMT.Id = GM.TargetRowId
	INNER JOIN AsGroupLabel AS GL ON GM.GroupId = GL.GroupId
	WHERE GL.Name = 'FireMappingTypeSpecProv'
	)
AND FR.SpecialProvWithDetails = 0 
) AS Result
