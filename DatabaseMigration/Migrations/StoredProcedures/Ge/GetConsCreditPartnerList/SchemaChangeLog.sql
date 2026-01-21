--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPartnerList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPartnerList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPartnerList
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPartnerList

@BatchId      		uniqueidentifier,
@StartCheckAmount   	money,
@FromAmount 	    	money,
@ToAmount 	    	money,
@MonitoringDate        	datetime,
@ConsStatusForwarded          smallint

AS

Declare @BalanceDate2 	  datetime
Declare @BalanceDate3 	  datetime
Declare @VaRunId     	  uniqueidentifier
Declare @VaRunId2     	  uniqueidentifier
Declare @PreviousBatchId  uniqueidentifier

SET @BalanceDate2 = DATEADD(day,-1,CAST(LEFT(CONVERT(VARCHAR(20), @MonitoringDate,112),6) + '01' AS Datetime))
SET @BalanceDate3 = DATEADD(day,-1,CAST(LEFT(CONVERT(VARCHAR(20), @BalanceDate2,112),6) + '01' AS Datetime))

Select Top 1 @VaRunId = ID 
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @BalanceDate2
Order  by ValuationDate DESC

Select Top 1 @VaRunId2 = ID 
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @BalanceDate3
Order  by ValuationDate DESC

Select @PreviousBatchId = Id FROM  PtConsCreditMonitorBatch WHERE PlannedForwardDate = @BalanceDate2

SELECT TOP 1000 Pt.PartnerNo, Pt.Id, Pt.Name, Pt.FirstName, Pt.DateOfBirth, Pt.SexStatusNo, Pt.LegalStatusNo, Pt.NogaCode2008, Pt.OpeningDate,
SUM(Va.MarketValueCHF), SUM(Va.MarketValueCHF),
Case 
WHEN PrevMon.Id IS NULL THEN 1
ELSE 0
END AS FirstForward, PrevMon.IkoContractId
FROM VaPrivateView AS Va
INNER JOIN PtBase AS Pt ON Va.PartnerId = Pt.Id
INNER JOIN PrReference AS Ref ON Va.ProdReferenceId = Ref.Id
INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId AND ConsCreditMonitoring = 1
INNER JOIN VaPrivateView AS Va2 ON Va.PositionId = Va2.PositionId AND Va2.VaRunId = @VaRunId2 AND Va2.MarketValueCHF < @StartCheckAmount AND Va2.MarketValueCHF > @ToAmount
LEFT OUTER JOIN PtConsCreditMonitor AS PrevMon ON Pt.Id = PrevMon.PartnerId AND PrevMon.MonitorBatchId = @PreviousBatchId AND PrevMon.StatusNo = @ConsStatusForwarded AND PrevMon.HdVersionNo BETWEEN 1 AND 999999998
WHERE Va.VaRunId = @VaRunId AND Va.MarketValueCHF < @StartCheckAmount AND Va.MarketValueCHF > @ToAmount

AND Pt.TerminationDate IS NULL
AND (
	(Pt.SexStatusNo = 3 AND Pt.LegalStatusNo IN (32,33))	OR	(Pt.SexStatusNo <> 3)
     )
AND NOT EXISTS (
		Select Value FROM PtAccountComponent AS Ac 
		INNER JOIN PtAccountComposedPrice AS Acv ON Acv.AccountComponentId = Ac.Id
		INNER JOIN PrPrivateCompType AS Ct ON Ac.PrivateCompTypeId = Ct.Id
		WHERE Ct.IsDebit = 1 AND Ct.SecurityLevelNo IS NOT NULL AND Ct.SecurityLevelNo <> 60
		AND Acv.Value > 0
		AND Acv.ValidFrom <= @MonitoringDate AND (Acv.ValidTo > @MonitoringDate OR Acv.ValidTo IS NULL)
		AND Ac.AccountBaseId = Ref.AccountId)
AND NOT EXISTS (Select Id FROM PtConsCreditMonitor AS ccm WHERE ccm.MonitorBatchId = @BatchId AND ccm.PartnerId = Pt.Id)
AND Pt.NogaCode2008 LIKE '97%'
Group By Pt.PartnerNo, Pt.Id, Pt.Name, Pt.FirstName, Pt.DateOfBirth, Pt.SexStatusNo, Pt.LegalStatusNo, Pt.NogaCode2008, Pt.OpeningDate, PrevMon.Id, PrevMon.IkoContractId
Having SUM(Va.MarketValueCHF) < @FromAmount AND SUM(Va.MarketValueCHF) > @ToAmount 
       AND SUM(Va2.MarketValueCHF) < @FromAmount AND SUM(Va2.MarketValueCHF) > @ToAmount
ORDER BY Pt.PartnerNo

