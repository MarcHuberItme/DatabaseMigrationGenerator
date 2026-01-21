--liquibase formatted sql

--changeset system:create-alter-procedure-GetJobMailInset context:any labels:c-any,o-stored-procedure,ot-schema,on-GetJobMailInset,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetJobMailInset
CREATE OR ALTER PROCEDURE dbo.GetJobMailInset
    @JobId varchar(40)
AS
SELECT j.ForElectronicMail, j.ForPaperMail, j.FilterStatement, m.DocumentNo
    FROM PsJobMailInset j 
    JOIN AsMailInset m ON j.MailInsetId = m.Id
    WHERE j.HdVersionNo BETWEEN 1 AND 999999998
        AND m.HdVersionNo BETWEEN 1 AND 999999998
        AND j.JobId = @JobId
