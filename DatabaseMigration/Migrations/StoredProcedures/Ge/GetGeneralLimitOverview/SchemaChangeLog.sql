--liquibase formatted sql

--changeset system:create-alter-procedure-GetGeneralLimitOverview context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGeneralLimitOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGeneralLimitOverview
CREATE OR ALTER PROCEDURE dbo.GetGeneralLimitOverview

@VaRunId uniqueidentifier = NULL

AS

DECLARE @Id uniqueidentifier
DECLARE @PrevId uniqueidentifier
DECLARE @PartnerId uniqueidentifier
DECLARE @PrevPartnerId uniqueidentifier
DECLARE @LimitTypeNo smallint
DECLARE @LimitGroupNo smallint
DECLARE @PrevLimitGroupNo smallint
DECLARE @AmountHoCu money
DECLARE @NextAmountHoCu money
DECLARE @ValueHomeCurrency money
DECLARE @FreeAmountHoCu money
DECLARE @MyCursor CURSOR 

IF @VaRunId IS NULL 
	EXEC VaRunIdLastDailyRun @VaRunId OUTPUT

CREATE TABLE #MyTempTable (
	Id uniqueidentifier Primary key, 
	PartnerId uniqueidentifier, 
	LimitTypeNo smallint, 
	ValidFrom datetime, 
	AmountHoCu money, 
	FreeAmountHoCu money, 
	NextValidFrom datetime, 
	NextAmountHoCu money, 
	ValueHomeCurrency money, 
	LimitGroupNo smallint)

INSERT INTO #MyTempTable (Id, PartnerId , LimitTypeNo , ValidFrom , AmountHoCu , NextValidFrom , NextAmountHoCu , ValueHomeCurrency, LimitGroupNo )
SELECT Newid(), PartnerId, 
LimitTypeNo, 
MAX(ValidFrom) AS ValidFrom, 
ISNULL(SUM(AmountHoCu),0) AS AmountHoCu, 
MAX(NextValidFrom) AS NextValidFrom, 
ISNULL(SUM(NextAmountHoCu),0) AS NextAmountHoCu, 
SUM(ValueHomeCurrency) AS ValueHomeCurrency, 
CASE WHEN LimitTypeNo IN (102,103,104) THEN 102 ELSE LimitTypeNo END AS LimitGroupNo 
FROM 
(
	SELECT PartnerId, LimitTypeNo, NULL AS ValidFrom, NULL AS AmountHoCu, NULL AS NextValidFrom, NULL AS NextAmountHoCu, ValRunId, ValueHomeCurrency 
	FROM PtBankCounterpartyBalance WHERE ValRunId = @VaRunId
	
	UNION ALL
	
	SELECT PartnerId, LimitTypeNo, ValidFrom, AmountHoCu, NextValidFrom, NextAmountHoCu, NULL AS ValRunId, NULL AS ValueHomeCurrency
	FROM PtBankCounterpartyLimit
) AS RESULT
GROUP BY PartnerId, LimitTypeNo
ORDER BY PartnerId, LimitGroupNo ASC, LimitTypeNo DESC

SET @MyCursor = CURSOR 
FOR 
Select Id, PartnerId, LimitTypeNo, AmountHoCu, NextAmountHoCu, ValueHomeCurrency, LimitGroupNo
From #MyTempTable 
ORDER BY PartnerId, LimitTypeNo

OPEN @MyCursor 
FETCH NEXT FROM @MyCursor 
INTO @Id, @PartnerId,@LimitTypeNo, @AmountHoCu, @NextAmountHoCu, @ValueHomeCurrency, @LimitGroupNo

SET @FreeAmountHoCu = 0

WHILE @@FETCH_STATUS = 0 
	BEGIN 
		PRINT @PartnerId
		SET @PrevId = @Id
		SET @PrevPartnerId = @PartnerId
		SET @PrevLimitGroupNo = @LimitGroupNo

		SET @FreeAmountHoCu = @FreeAmountHoCu + @AmountHoCu + @ValueHomeCurrency

		IF (@FreeAmountHoCu) >= 0 
			BEGIN
				UPDATE #MyTempTable
				SET FreeAmountHoCu = @FreeAmountHoCu
				WHERE Id = @Id
				SET @FreeAmountHoCu = 0

				FETCH NEXT FROM @MyCursor 
				INTO @Id, @PartnerId,@LimitTypeNo, @AmountHoCu, @NextAmountHoCu, @ValueHomeCurrency, @LimitGroupNo

			END

		ELSE
			BEGIN
				FETCH NEXT FROM @MyCursor 
				INTO @Id, @PartnerId,@LimitTypeNo, @AmountHoCu, @NextAmountHoCu, @ValueHomeCurrency, @LimitGroupNo
				
				IF @@FETCH_STATUS <> 0 
					BEGIN
						UPDATE #MyTempTable
						SET FreeAmountHoCu = @FreeAmountHoCu
						WHERE Id = @PrevId
						SET @FreeAmountHoCu = 0
					END
				ELSE
					IF NOT (@PartnerId = @PrevPartnerId AND @LimitGroupNo = @PrevLimitGroupNo)
						BEGIN
							UPDATE #MyTempTable
							SET FreeAmountHoCu = @FreeAmountHoCu
							WHERE Id = @PrevId
							SET @FreeAmountHoCu = 0
						END
			END
	END 

CLOSE @MyCursor 
DEALLOCATE @MyCursor 

select * from #MyTempTable

drop table #MyTempTable

