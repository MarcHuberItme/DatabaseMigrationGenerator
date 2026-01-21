--liquibase formatted sql

--changeset system:create-alter-procedure-DelPrintJob context:any labels:c-any,o-stored-procedure,ot-schema,on-DelPrintJob,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DelPrintJob
CREATE OR ALTER PROCEDURE dbo.DelPrintJob
    @JobId uniqueidentifier,
    @JobFileNo int
AS
    -- delete the entries for Mail Charge
    UPDATE AsMailCharge SET HdVersionNo = 999999999
    FROM AsMailCharge ch 
        JOIN AsMailOutputJobDoc jd ON ch.MailOutputJobDocId = jd.Id
    WHERE jd.JobId = @JobId
        AND jd.JobFileNo = @JobFileNo
    
        -- AsMailChargeDoc will be deleted by cascaded delete trigger

    -- delete the mail journal
    UPDATE PtAddressMail 
    SET HdVersionNo = 999999999
    WHERE MailOutputJobId = @JobId
        AND JobFileNo = @JobFileNo
        
        -- AsMailChargeDoc will be deleted by cascaded delete trigger

    -- delete XML-record 
    DELETE AsMailOutputJobXML
    WHERE JobId = @JobId
        AND JobFileNo = @JobFileNo

    -- reset  AsMailOutput
    UPDATE AsMailOutput SET JobDocId = Null, JobBatchPageNo = Null
    FROM AsMailOutput o JOIN AsMailOutputJobDoc jd ON jd.Id = o.JobDocId
    WHERE jd.JobId = @JobId
        AND jd.JobFileNo = @JobFileNo

    -- reset  AsMailOutputJobDoc
    UPDATE AsMailOutputJobDoc SET Processed = 0, JobFileNo = NULL
        WHERE JobId = @JobId
        AND JobFileNo = @JobFileNo
         
    -- Change Status of AsMailOutput Job
    IF (@JobFileNo = 1)
        UPDATE AsMailOutputJob SET ProcessingStatus = 20 WHERE Id = @JobId
    ELSE
        UPDATE AsMailOutputJob SET ProcessingStatus = 30 WHERE Id = @JobId
    


