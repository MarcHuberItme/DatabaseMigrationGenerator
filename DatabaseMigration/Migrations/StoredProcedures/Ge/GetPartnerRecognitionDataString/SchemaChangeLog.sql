--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerRecognitionDataString context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerRecognitionDataString,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerRecognitionDataString
CREATE OR ALTER PROCEDURE dbo.GetPartnerRecognitionDataString

@PartnerId uniqueidentifier

AS

SELECT TOP 1 DataString
FROM PtRecognition AS Rec
INNER JOIN AsDocumentIndex AS I ON Rec.Id = I.SourceRecordId
INNER JOIN AsDocument AS Doc ON I.DocumentId = Doc.Id
INNER JOIN AsDocumentData AS Data On Doc.Id = Data.DocumentId
WHERE
Rec.PartnerId = @PartnerId 
AND Rec.RecognitionTypeNo IN (10)
AND Doc.PartnerId = @PartnerId 
AND Data.Format IN('TIF','JPG','GIF')
AND Data.StatusNo = 200
AND Rec.HdVersionNo BETWEEN 1 AND 999999998
AND I.HdVersionNo BETWEEN 1 AND 999999998
AND Doc.HdVersionNo BETWEEN 1 AND 999999998
AND Data.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY Data.RecordDate DESC
