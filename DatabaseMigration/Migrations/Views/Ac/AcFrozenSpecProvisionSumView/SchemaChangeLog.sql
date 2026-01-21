--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenSpecProvisionSumView context:any labels:c-any,o-view,ot-schema,on-AcFrozenSpecProvisionSumView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenSpecProvisionSumView
CREATE OR ALTER VIEW dbo.AcFrozenSpecProvisionSumView AS
SELECT 
FR.ReportDate, 
FR.SpecialProvWithDetails,
ISNULL(SpecialProvSumValueHoCu,0) AS SpecialProvSumValueHoCu,
ISNULL(BalanceValueHoCu,0) AS BalanceValueHoCu, 
CASE
WHEN FR.SpecialProvWithDetails = 1 THEN ISNULL(SpecialProvSumValueHoCu,0) - ISNULL(BalanceValueHoCu,0)
ELSE 0 
END AS DifferenceValueHoCu, 
ImpairedValueHoCu, OverdueSumValueHoCu
FROM AcFireReport AS FR
FULL JOIN (	
		SELECT FSP.ReportDate, SUM(FSP.ValueHoCu) AS SpecialProvSumValueHoCu, COUNT(*) AS RecCount
		FROM AcFrozenSpecificProvision AS FSP
		LEFT OUTER JOIN AcFrozenAccount AS FA ON FSP.ReportDate = FA.ReportDate AND FSP.SourceRecordId = FA.AccountId
		WHERE FSP.HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY FSP.ReportDate
	   ) AS FSP ON FR.ReportDate = FSP.ReportDate
FULL JOIN ( 
		SELECT ReportDate, SUM(ValueHoCu) AS BalanceValueHoCu 
		FROM AcFrozenAccount AS FA
		WHERE FA.AccountNo IN (
						SELECT acc.AccountNo 
						FROM PtAccountBase acc
						INNER JOIN AsGroupMember AS GM ON acc.Id = GM.TargetRowId
						INNER JOIN AsGroupLabel AS GL ON GM.GroupId = GL.GroupId
						WHERE GL.Name = 'IndividualRisks'
						  
					)
		GROUP BY ReportDate 
	    ) AS FA ON FR.ReportDate = FA.ReportDate  
FULL JOIN (	
		SELECT FA.ReportDate, SUM(FA.ValueHoCu) AS OverdueSumValueHoCu, COUNT(*) AS RecCount
		FROM AcFrozenAccount AS FA 
		WHERE FA.HdVersionNo BETWEEN 1 AND 999999998 AND SuppressOverdueFlag = 0 AND (InterestRecovery = 1 OR NoDebitInterests = 1)
		AND FA.ValueHoCu < 0
		GROUP BY FA.ReportDate
	   ) AS Overdue ON FR.ReportDate = Overdue.ReportDate
FULL JOIN (	
		SELECT FSP.ReportDate, SUM(FA.ValueHoCu) AS ImpairedValueHoCu, COUNT(*) AS RecCount
		FROM AcFrozenSpecificProvision AS FSP
		LEFT OUTER JOIN AcFrozenAccount AS FA ON FSP.ReportDate = FA.ReportDate AND FSP.SourceRecordId = FA.AccountId
		WHERE FSP.HdVersionNo BETWEEN 1 AND 999999998 AND FA.ValueHoCu < 0
		GROUP BY FSP.ReportDate
	   ) AS Impaired ON FR.ReportDate = Impaired.ReportDate

