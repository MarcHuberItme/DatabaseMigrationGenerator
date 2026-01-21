--liquibase formatted sql

--changeset system:create-alter-procedure-GetAMLMonthsUntilNextCheck context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAMLMonthsUntilNextCheck,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAMLMonthsUntilNextCheck
CREATE OR ALTER PROCEDURE dbo.GetAMLMonthsUntilNextCheck
AS
BEGIN
	SELECT periodicities.MonthsUntilNextCheck, checks.ID
	FROM
	PtMLPeriodicCheckOverview Checks
	INNER JOIN PtBase Partners ON Checks.PartnerId = Partners.Id
	INNER JOIN PtProfile Profiles ON Profiles.PartnerId = Partners.Id
	INNER JOIN PtMLPeriodicCheckPeriodicity periodicities ON profiles.MoneyLaunderSuspect = periodicities.MLSuspectNo
	WHERE Checks.CustomerTypeNoCalculated = periodicities.MLCustomerTypeNo
	AND periodicities.ValidFrom <= GETDATE() AND ISNULL(periodicities.ValidTo, '99991231') >= GETDATE()

END


