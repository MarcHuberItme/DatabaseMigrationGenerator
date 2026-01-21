--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountStatementPeriodLast context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountStatementPeriodLast,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountStatementPeriodLast
CREATE OR ALTER PROCEDURE dbo.GetAccountStatementPeriodLast
@AccountId uniqueIdentifier,  
@ActivityRuleCode as int  
AS  

Declare @MaxStatementNo AS int

SELECT @MaxStatementNo = IsNull(MAX(StatementNo),0)
from 
	PtAccountStatementPeriod 
WHERE
	ActivityRuleCode = @ActivityRuleCode and
	AccountId = @AccountId and PtAccountStatementPeriod.HdVersionNo between 1 and 999999998

SELECT * from PtAccountStatementPeriod
Where
	ActivityRuleCode = @ActivityRuleCode and
	AccountId	= @AccountId and
	StatementNo	= @MaxStatementNo and PtAccountStatementPeriod.HdVersionNo between 1 and 999999998


