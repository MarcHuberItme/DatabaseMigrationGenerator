--liquibase formatted sql

--changeset system:create-alter-procedure-InsertFireGlobalLimits context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertFireGlobalLimits,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertFireGlobalLimits
CREATE OR ALTER PROCEDURE dbo.InsertFireGlobalLimits
@FireReportId uniqueidentifier

AS

DECLARE @SequenceNo int

DELETE FROM AcFireRecord WHERE FireReportId = @FireReportId AND Label = 'GLOBAL_LIMITS'

SELECT @SequenceNo = Max(SequenceNo) FROM AcFireRecord WHERE FireReportId = @FireReportId

INSERT INTO AcFireRecord (FireReportId, C001, C003, C004, C007, C009, C014, C041, C510, C518, C519, C530, C538, C540, C551, C561, C562, C570, C576, C577, C579, C582, NOGA, SourceRecordId, Label, User4, SequenceNo)

SELECT FireReportId, 718500 AS C001, C003, C004, C007, C009, C014, C042 - C041 AS C041, C510, C518, C519, C530, C538,  C540, C551, C561, C562, C570, C576, C577, C579, C582, NOGA, 
SourceRecordId, 'GLOBAL_LIMITS' AS Label, User4, @SequenceNo + ROW_NUMBER()  OVER (ORDER BY SequenceNo ASC) AS NewSequenceNo
FROM AcFireRecord
WHERE FireReportId = @FireReportId
AND C001 BETWEEN 104100 AND 105999
AND C042 > C041
ORDER BY C014

UPDATE AcFireRecord
SET C042 = 0
WHERE FireReportId = @FireReportId
AND C001 BETWEEN 104100 AND 105999


