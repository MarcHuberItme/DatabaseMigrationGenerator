--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteDocumentTree context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteDocumentTree,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteDocumentTree
CREATE OR ALTER PROCEDURE dbo.DeleteDocumentTree
@DocumentId  uniqueidentifier

AS
DECLARE @MailId			uniqueidentifier
DECLARE @DocumentDataId	uniqueidentifier
DECLARE @Processed		bit
DECLARE @JobDocId		uniqueidentifier
DECLARE @ErrorOccurred		bit
DECLARE @Counter		int
DECLARE @DocumentNo		int
DECLARE @crsMailCursor		CURSOR

SET NOCOUNT ON
SET @ErrorOccurred = 0

/*** Check (and delete) AsMailOutput records ***/
SET @crsMailCursor = CURSOR SCROLL DYNAMIC FOR
SELECT mail.Id, mail.DocumentDataId, mail.Processed, mail.JobDocId, doc.DocumentNo
   FROM   AsDocument doc INNER JOIN AsDocumentData docdata
          ON doc.Id = docdata.DocumentId  JOIN AsMailOutput mail
          ON docdata.Id = mail.DocumentDataId
   WHERE doc.Id = @DocumentId

OPEN @crsMailCursor
FETCH FIRST FROM @crsMailCursor INTO @MailId, @DocumentDataId, @Processed, @JobDocId, @DocumentNo

WHILE @@FETCH_STATUS = 0
   /*** Check AsMailOutput Job conditions ***/
   BEGIN
   IF @Processed = 1
      BEGIN
      SET @ErrorOccurred = 1
      RAISERROR ('Record in Table AsMailOutput is declared as processed! (DocumentNo: %d)', 16,1, @DocumentNo)
      BREAK
      END
   ELSE
      IF @JobDocId IS NOT NULL
         BEGIN
         SET @Counter = (SELECT COUNT(*) FROM AsMailOutputJobDoc WHERE Id = @JobDocId AND Processed = 1)
         IF @Counter > 0
            BEGIN
            SET @ErrorOccurred = 1
            RAISERROR ('Record in Table AsMailOutput references Job which is processed! (DocumentNo: %d)', 16,1, @DocumentNo)
            BREAK
            END
         ELSE
            BEGIN
            SET @Counter = (SELECT COUNT(*) FROM AsMailOutputJobDoc WHERE Id = @JobDocId)
            IF @Counter > 0
               BEGIN
               DELETE AsMailOutputJobXML FROM AsMailOutputJobXML
                              INNER JOIN AsMailOutputJob ON AsMailOutputJobXML.JobId = AsMailOutputJob.Id
                                          JOIN AsMailOutputJobDoc ON AsMailOutputJob.Id = AsMailOutputJobDoc.JobId
                      WHERE AsMailOutputJobDoc.Id = @JobDocId
               DELETE AsMailOutputJob FROM AsMailOutputJob
                                      INNER JOIN AsMailOutputJobDoc ON AsMailOutputJob.Id = AsMailOutputJobDoc.JobId
                      WHERE AsMailOutputJobDoc.Id = @JobDocId 
               DELETE FROM AsMailOutputJobDoc WHERE Id = @JobDocId
               END
            END
         END
   FETCH NEXT FROM @crsMailCursor INTO @MailId, @DocumentDataId, @Processed, @JobDocId, @DocumentNo
   END
CLOSE @crsMailCursor

IF @ErrorOccurred = 1
   RETURN
ELSE
   /*** Delete (Rollback) Records from AsMailOutput, AsDocumentData, AsDocument, AsDocumentIndex ***/
   BEGIN
   DELETE AsMailOutputInset FROM AsMailOutputInset
                  INNER JOIN AsMailOutput ON AsMailOutputInset.MailOutputId = AsMailOutput.Id
                              JOIN AsDocumentData ON AsMailOutput.DocumentDataId = AsDocumentData.Id
          WHERE AsDocumentData.DocumentId = @DocumentId
   DELETE AsMailOutput FROM AsMailOutput 
                  INNER JOIN AsDocumentData ON AsMailOutput.DocumentDataId = AsDocumentData.Id
          WHERE AsDocumentData.DocumentId = @DocumentId
   DELETE FROM AsDocumentData WHERE DocumentId = @DocumentId
   DELETE FROM AsDocumentIndex WHERE DocumentId = @DocumentId
   DELETE FROM AsDocument WHERE Id = @DocumentId
   END

