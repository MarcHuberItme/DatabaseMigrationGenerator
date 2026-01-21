--liquibase formatted sql

--changeset system:create-alter-procedure-InitializeInterestRecoveryData context:any labels:c-any,o-stored-procedure,ot-schema,on-InitializeInterestRecoveryData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitializeInterestRecoveryData
CREATE OR ALTER PROCEDURE dbo.InitializeInterestRecoveryData
@ReportDate datetime, 
@UserName varchar(20)

AS

DELETE FROM AcFrozenAccInterestRecovery WHERE ReportDate = @ReportDate
UPDATE AcFrozenAccount SET InterestRecovery = 0, SuppressOverdueFlag = 0 WHERE ReportDate = @ReportDate

INSERT INTO AcFrozenAccInterestRecovery 
(ReportDate, ClosingDate, AccountId, InterestAmountHoCu, HdVersionNo, HdCreator)

SELECT FA.ReportDate, AIR.ClosingDate, AIR.AccountId, InterestAmountHoCu, 1, @UserName
FROM PtAccountInterestRecovery AS AIR
INNER JOIN AcFrozenAccount AS FA ON AIR.AccountId = FA.AccountId
WHERE ReportDate = @ReportDate
AND AIR.HdVersionNo BETWEEN 1 AND 999999998

UPDATE AcFrozenAccount
SET InterestRecovery = 1
WHERE ReportDate = @ReportDate
AND AccountId IN (SELECT AccountId FROM AcFrozenAccInterestRecovery 
				  WHERE InterestAmountHoCu > 0 AND HdVersionNo BETWEEN 1 AND 999999998
				  AND ReportDate = @ReportDate)

UPDATE AcFrozenAccount
SET SuppressOverdueFlag = 1
WHERE ReportDate = @ReportDate
AND NoDebitInterests = 1
AND SuppressOverdueFlag = 0
