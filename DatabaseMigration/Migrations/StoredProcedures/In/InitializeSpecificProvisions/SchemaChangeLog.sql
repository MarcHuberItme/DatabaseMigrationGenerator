--liquibase formatted sql

--changeset system:create-alter-procedure-InitializeSpecificProvisions context:any labels:c-any,o-stored-procedure,ot-schema,on-InitializeSpecificProvisions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitializeSpecificProvisions
CREATE OR ALTER PROCEDURE dbo.InitializeSpecificProvisions
@ReportDate datetime,
@UserName varchar(20),
@InitDetails bit

AS

declare @PreviousDate datetime
select @PreviousDate = ReportDate from AcFireReport WHERE ReportDate < @ReportDate order by reportdate DESC

set @PreviousDate = dateadd(d,-1,dateadd(m,-1,dateadd(d,1,@ReportDate))) -- get previous month

DELETE FROM AcFrozenSpecificProvision WHERE ReportDate = @ReportDate
UPDATE AcFireReport SET SpecialProvWithDetails = @InitDetails WHERE ReportDate = @ReportDate

IF @InitDetails = 1
	BEGIN
		INSERT INTO AcFrozenSpecificProvision 
      		(ReportDate, SourceTableName, SourceRecordId, SpecificProvisionTypeNo, IsGeneratedBySystem, ValueHoCu, HdVersionNo, HdCreator)
	
		SELECT FAC.ReportDate, 'AcFrozenAccount', FA.AccountId, 1, 1, SUM(ISNULL(FAC.CreditLimitHoCu,0)) AS ValueHoCu, 1, @UserName
		FROM AcFrozenAccount AS FA
		INNER JOIN AcFrozenAccountComponent AS FAC ON FA.AccountNo = FAC.AccountNo AND FAC.ReportDate = FA.ReportDate
		WHERE FAC.ReportDAte = @ReportDate AND FAC.SecurityLevelNo = 50 AND FAC.CreditLimitHoCu <> 0
		GROUP BY FAC.ReportDate, FA.AccountId

		INSERT INTO AcFrozenSpecificProvision 
      		(ReportDate, SourceTableName, SourceRecordId, SpecificProvisionTypeNo, IsGeneratedBySystem, ValueHoCu, HdVersionNo, HdCreator)
	
		SELECT FA.ReportDate, 'AcFrozenAccount', FA.AccountId, 1, 1, 0 AS ValueHoCu, 1, @UserName
		FROM AcFrozenAccount AS FA
		INNER JOIN AcFrozenPartner AS FP ON FA.ReportDate = FP.ReportDate AND FA.PartnerId = FP.PartnerId
		WHERE FA.ReportDAte = @ReportDate AND FA.ValueHoCu < 0 AND FP.RatingResult = 0.5
		AND FA.AccountNo NOT IN (

					SELECT AccountNo FROM
					AcFrozenAccountComponent AS FAC
					WHERE FAC.ReportDate = @ReportDate AND FAC.SecurityLevelNo = 50 AND FAC.CreditLimitHoCu <> 0
					)

		UPDATE AcFrozenSpecificProvision 
		SET LiquidationValueHoCu = Result.LiquidationValueHoCu
		FROM AcFrozenSpecificProvision
		INNER JOIN (

			select FSP.Id, Max(FSP_Prev.LiquidationValueHoCu) AS LiquidationValueHoCu FROM AcFrozenSpecificProvision AS FSP
			INNER JOIN AcFrozenSpecificProvision AS FSP_Prev ON FSP.SourceRecordId = FSP_Prev.SourceRecordId AND FSP_Prev.ReportDate = @PreviousDate
			WHERE FSP.ReportDate = @ReportDate
			AND FSP.HdVersionNo BETWEEN 1 AND 999999998
			AND FSP_Prev.HdVersionNo BETWEEN 1 AND 999999998
			AND FSP_Prev.LiquidationValueHoCu IS NOT NULL
			GROUP BY FSP.Id) AS Result ON Result.Id = AcFrozenSpecificProvision.Id

	END
