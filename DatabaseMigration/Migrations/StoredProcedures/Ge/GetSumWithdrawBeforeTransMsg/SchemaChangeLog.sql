--liquibase formatted sql

--changeset system:create-alter-procedure-GetSumWithdrawBeforeTransMsg context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSumWithdrawBeforeTransMsg,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSumWithdrawBeforeTransMsg
CREATE OR ALTER PROCEDURE dbo.GetSumWithdrawBeforeTransMsg
@TransMessageId as UniqueIdentifier,
@DateFrom as datetime
As

Declare @TransNo decimal(12,0)
Declare @AnalysisSequence int
declare @DebitPrReferenceId as uniqueIdentifier
Declare @DateTo as datetime


Select @TransNo = TransNo, @AnalysisSequence = AnalysisSequence, @DebitPrReferenceId = DebitPrReferenceId, @DateTo = TransDate
from PtTransWithdraw where TransMessageId = @TransMessageId

select isnull(sum(DebitAmount),0) as SumCommRelWithdraw from PtTransWithdraw Where DebitPrReferenceId = @DebitPrReferenceId
and TransDate between @DateFrom and @DateTo
and IsReversal =0 and IsReversed = 0
and TransMessageId <> @TransMessageId
and ((TransNo < @TransNo) or (TransNo = @TransNo and AnalysisSequence<@AnalysisSequence))
and PtTransWithdraw.HdVersionNo between 1 and 99999998
