--liquibase formatted sql

--changeset system:create-alter-procedure-FireRecordPostProcessing context:any labels:c-any,o-stored-procedure,ot-schema,on-FireRecordPostProcessing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FireRecordPostProcessing
CREATE OR ALTER PROCEDURE dbo.FireRecordPostProcessing
    @FireReportId uniqueidentifier,
    @BcNumber int
AS

If @BcNumber = 8307
BEGIN

   DECLARE @SequenceNo int

   DELETE FROM AcFireRecord WHERE FireReportId = @FireReportId AND Label Like '%-SPLIT'

   SELECT @SequenceNo = Max(SequenceNo) FROM AcFireRecord WHERE FireReportId = @FireReportId

   INSERT INTO AcFireRecord
           ([Id]
           ,[HdCreateDate]
           ,[HdCreator]
           ,[HdChangeDate]
           ,[HdChangeUser]
           ,[HdEditStamp]
           ,[HdVersionNo]
           ,[HdProcessId]
           ,[HdStatusFlag]
           ,[HdNoUpdateFlag]
           ,[HdPendingChanges]
           ,[HdPendingSubChanges]
           ,[HdTriggerControl]
           ,[FireReportId]
           ,[C001]
           ,[C007]
           ,[C008]
           ,[C009]
           ,[C010]
           ,[C014]
           ,[C040]
           ,[C041]
           ,[C042]
           ,[C510]
           ,[C518]
           ,[C519]
           ,[C523]
           ,[C530]
           ,[C535]
           ,[C536]
           ,[C538]
           ,[C551]
           ,[C553]
           ,[C555]
           ,[C560]
           ,[C561]
           ,[C562]
           ,[C570]
           ,[C571]
           ,[C572]
           ,[C573]
           ,[C577]
           ,[C579]
           ,[C582]
           ,[C583]
           ,[NOGA]
           ,[User4]
           ,[User5]
           ,[SourceTableName]
           ,[SourceRecordId]
           ,[Label]
           ,[SequenceNo])
   SELECT   NEWID() As ID
           ,GETDATE() As HdCreateDate
           ,[HdCreator]
           ,GetDate() As HdChangeDate
           ,[HdChangeUser]
           ,[HdEditStamp]
           ,[HdVersionNo]
           ,[HdProcessId]
           ,[HdStatusFlag]
           ,[HdNoUpdateFlag]
           ,[HdPendingChanges]
           ,[HdPendingSubChanges]
           ,[HdTriggerControl]
           ,[FireReportId]
           ,[C001]
           ,[C007]
           ,[C008]
           ,[C009]
           ,[C010]
           ,[C014]
           ,[C040] * (c536 -100) / 100 As c040
           ,[C041] * (c536 -100) / 100 As c041
           ,[C042] * (c536 -100) / 100 As c042
           ,[C510]
           ,[C518]
           ,[C519]
           ,[C523]
           ,[C530]
           ,[C535]
           ,20 As c536
           ,[C538]
           ,[C551]
           ,[C553]
           ,[C555]
           ,[C560]
           ,[C561]
           ,[C562] * (c536 -100) / 100 As c562
           ,[C570]
           ,[C571]
           ,[C572]
           ,[C573]
           ,[C577]
           ,[C579]
           ,[C582]
           ,[C583]
           ,[NOGA]
           ,[User4]
           ,[User5]
           ,[SourceTableName]
           ,[SourceRecordId]
           ,[Label] + '-SPLIT' As label
           ,@SequenceNo + ROW_NUMBER()  OVER (ORDER BY SequenceNo ASC) AS SequenceNo

  FROM AcFireRecord where FireReportId = @FireReportId
      and C536 in (125,150,175)


   UPDATE AcFireRecord SET C040 = c040 * (200 - c536 ) / 100,
                           C041 = c041 * (200 - c536 ) / 100,
                           C042 = c042 * (200 - c536 ) / 100,
                           C562 = c562 * (200 - c536 ) / 100,
		   				   C536 = 50,
						   Label = Label + '-SPLIT'
   WHERE FireReportId = @FireReportId
       and C536 in (125,150,175)
END  -- of 8307

-- Bank Sparhafen AG
IF @BcNumber = 6808
BEGIN

-- Workaround: Unterbeteiligungen sind noch nicht korrekt erfasst!
UPDATE AcFireRecord set c519 = 3, c518 = '20211231'
where FireReportId = @FireReportId
    AND User4 = 1011        -- Unterbeteiligung Hypothek
    AND c040 < 0

 
UPDATE AcFireRecord set c519 = 3, c518 = '20170430'
where FireReportId = @FireReportId
    AND User4 = 1110        -- Unterbeteiligung Liborhypothek
    AND c040 < 0 


DELETE AcFireRecord
where FireReportId = @FireReportId
   and Label = 'GLOBAL_LIMITS'
   and C001 = 718500
   and User4 IN (1011, 1110)


-- Spezialfall 36619267 : Amortisation über Zinsstaffel, kündbar, C519 = 6 (gefährdet)
-- Datum bei Kontokorrent immer entfernen:

UPDATE AcFireRecord set c518 = null
where FireReportId = @FireReportId
    AND User4 = 1001        -- Kontokorrent

   
END  -- of 6808


-- Scobag
If @BcNumber = 8543
BEGIN
    UPDATE AcFireRecord SET C001 = 502100
	WHERE C001 = 718500
	    AND LABEL = 'GLOBAL_LIMITS'
		AND FireReportId = @FireReportId


END


-- SEBA
If @BcNumber = 83018
BEGIN
    UPDATE AcFireRecord SET C001 = 718200
	WHERE C001 = 718500
	    AND LABEL = 'GLOBAL_LIMITS'
		AND FireReportId = @FireReportId


END
