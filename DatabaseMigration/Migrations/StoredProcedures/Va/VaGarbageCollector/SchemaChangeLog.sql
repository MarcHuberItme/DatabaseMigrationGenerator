--liquibase formatted sql

--changeset system:create-alter-procedure-VaGarbageCollector context:any labels:c-any,o-stored-procedure,ot-schema,on-VaGarbageCollector,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaGarbageCollector
CREATE OR ALTER PROCEDURE dbo.VaGarbageCollector
--StoreProcedure: VaGarbageCollector
@RunId uniqueidentifier AS

--##### 31.3.2025 rohn: Any clean-up jobs are moved to DBCleanUpRule! 

-- Cleanup VaRun
--Delete VaRun
--Where HdVersionNo not Between 1 and 999999998

--Daily Run löschen
--declare @KeepingDailyRun int = (select Value from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingDailyRun') * -1
--Delete VaRun 
--Where 
--RunTypeNo = 0 AND hdCreateDate < dateadd(d, (select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingDailyRun') * -1 , getdate()) 
--And hdchangedate < dateadd(d, (select cast(Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingDailyRun')*-1, getdate()) 

--AdHoc Run nach einer Woche löschen
--declare @KeepingAdHocRun int = (select Value from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingAdHocRun') * -1
--Delete VaRun 
--Where 
--RunTypeNo = 99 AND hdCreateDate < dateadd(d,(select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingAdHocRun') * -1 ,getdate()) And hdchangedate < dateadd(d, (select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingAdHocRun') * -1, getdate()) 

--VaLatestValuationForPosition/VaLatestValuationForPortfolio/VaLatestRunRef nach x Tagen löschen (default 5)
--declare @KeepingLatestValuationData int = (select Value from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingLatestValuationData') * -1
--Delete VaLatestValuationForPosition 
--Where ValuationDate < dateadd(d, (select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingLatestValuationData') * -1 ,getdate())
--Delete VaLatestValuationForPortfolio
--Where ValuationDate < dateadd(d, (select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingLatestValuationData') * -1 ,getdate())
--Delete VaLatestRunRef
--Where ValuationDate < dateadd(d, (select cast( Value as int) from AsParameterView APV where APV.GroupName = 'ValueAssessment' and APV.ParameterName = 'KeepingLatestValuationData') * -1 ,getdate())
/*
--Cleanup VaPortfolio
Delete VaPortfolio
From VaPortfolio P
Left Outer Join VaRun R on R.Id = P.ValRunId
Where R.Id Is NULL

--Cleanup VaPosQuant
Delete VaPosQuant
From VaPosQuant PQ
Left Outer Join VaPortfolio P on P.PortfolioId = PQ.PortfolioId AND P.ValRunId = PQ.VaRunId
Where P.ID Is Null
*/
--Cleanup VaRefVal
--Delete VaRefVal
--From VaRefVal RV
--Left Outer Join VaRun R on R.Id = RV.ValRunId
--Where R.ID is Null

--Cleanup VaCurrencyRate
--Delete VaCurrencyRate
--From VaCurrencyRate CR
--Left Outer Join VaRun R on R.Id = CR.ValRunId
--Where R.ID is Null

--Cleanup VaPosFutures
--Delete VaPosFutures
--From VaPosFutures PF
--Left Outer Join VaPosQuant PQ on PQ.Id = PF.PosQuantId
--Where PQ.ID is Null

--Cleanup VaRefVal
--Delete VaPosMargin
--From VaPosMargin PM
--Left Outer Join VaRun R on R.Id = PM.VaRunId
--Where R.ID is Null
/*
--Cleanup VaRefVal
Delete VaBookedMargin
From VaBookedMargin BM
Left Outer Join VaRun R on R.Id = BM.VaRunId
Where R.ID is Null
*/



