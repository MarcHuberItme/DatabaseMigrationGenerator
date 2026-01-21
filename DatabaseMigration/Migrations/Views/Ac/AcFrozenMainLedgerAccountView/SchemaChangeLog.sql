--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenMainLedgerAccountView context:any labels:c-any,o-view,ot-schema,on-AcFrozenMainLedgerAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenMainLedgerAccountView
CREATE OR ALTER VIEW dbo.AcFrozenMainLedgerAccountView AS
SELECT TOP 100 PERCENT 
FA.Id, 
FA.AccountGroupNo, 
FA.AccountId, 
FA.AccountNo, 
FA.AccountNoText, 
FA.CharacteristicNo, 
FA.ClosingPeriodRuleNo, 
FA.ConsCreditMonitorId, 
FA.Currency, 
FA.DueValuePrCu, 
FA.DueValuePrCuAdjustment, 
FA.FreezeStatus, 
FA.IsDueRelevant, 
FA.IsMoneyMarket, 
FA.MgOBJEKT, 
FA.MgOBJPLZ, 
FA.MgSITZ, 
FA.NotAssignedDueValue, 
FA.NotAssignedValue, 
FA.OperationTypeNo, 
FA.PartnerId, 
FA.PositionId, 
FA.ProductNo, 
FA.PrReferenceId, 
FA.ReportDate, 
FA.AccountNoText + '-' + FA.Currency + ISNULL(' (' + REPLACE(REPLACE(REPLACE(FA.CustomerReference,',','-') ,CHAR(10),''),CHAR(13),' ') + ')','') AS AccountDesc,
CASE 
WHEN ValuePrCu >= 0 THEN 1
ELSE 2 END AS ValueSign ,
CASE 
WHEN ValuePrCu >= 0 THEN ValuePrCu
ELSE 0 - ValuePrCu END AS ValuePrCu,
CASE 
WHEN ValuePrCu >= 0 THEN ValueHoCu
ELSE 0 - ValueHoCu END AS ValueHoCu,
NULL AS InterestRate,
1 AS AmountType,
FP.CodeC510, FP.PartnerNo, FP.NogaCode2008 AS Noga2008
FROM AcFrozenAccount AS FA
left outer join AcFrozenPartnerView AS FP ON FA.PartnerId = FP.PartnerId AND FA.ReportDate = FP.ReportDate
WHERE Fa.OperationtypeNo = 10 AND (Fa.ValueHoCu <> 0 OR Fa.ValuePrCu <> 0)
