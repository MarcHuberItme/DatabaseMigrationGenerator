--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenAccountView context:any labels:c-any,o-view,ot-schema,on-AcFrozenAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenAccountView
CREATE OR ALTER VIEW dbo.AcFrozenAccountView AS
SELECT TOP 100 PERCENT
Ac.Id, Ac.HdVersionNo, Ac.HdPendingChanges, Ac.HdPendingSubChanges, Ac.HdEditStamp, 
Ac.HdCreator, Ac.HdChangeUser, Ac.HdProcessId, Ac.HdStatusFlag, 
Ac.ReportDate, Ac.AccountNo, Ac.AccountId,
Ac.PrReferenceId, Ac.Currency, Ac.ProductNo, Ac.AccountGroupNo,
Ac.CharacteristicNo, Ac.IsDueRelevant, Ac.CapitalBalance, 
Ac.InterestBalance, Ac.MgSITZ, Ac.MgOBJEKT, Ac.MgOBJPLZ, Ac.PartnerId,
Ac.OperationTypeNo, Ac.ConsCreditMonitorId, Ac.IsMoneyMarket,
Ac.ClosingPeriodRuleNo, Ac.FreezeStatus, Ac.PositionId, AC.ValueHoCu,
Ac.InitValuePrCu, Ac.InitDueValuePrCu, Ac.AcrDebitInterestSumPrCu,
Ac.AcrExpensesSumPrCu, Ac.AcrCommissionSumPrCu, Ac.ValuePrCuAdjustment,
Ac.DueValuePrCuAdjustment, Ac.ValuePrCu, Ac.DueValuePrCu, 
Ac.NotAssignedValue, Ac.NotAssignedDueValue, Ac.OpeningDate,
Ac.InterestRecovery, Ac.NoDebitInterests, Ac.SuppressOverdueFlag,
Pt.PartnerNo, Pt.SexStatusNo, Pt.LegalStatusNo, Pt.BusinessTypeCode, 
Pt.NogaCode2008, Pt.BranchNo, Pt.ReportAdrLine, Pt.SwissTownNo, 
Pt.Canton, Pt.FiscalDomicileCountry, Pt.Nationality, Pt.Employees, 
Pt.EmployeeGroupNo, Pt.FireEmployeeValue
FROM AcFrozenAccount AS Ac
LEFT OUTER JOIN AcFrozenPartner AS Pt ON Ac.ReportDate = Pt.ReportDate AND Ac.PartnerId = Pt.PartnerId
