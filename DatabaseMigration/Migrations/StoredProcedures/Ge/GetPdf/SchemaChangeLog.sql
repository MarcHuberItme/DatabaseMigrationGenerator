--liquibase formatted sql

--changeset system:create-alter-procedure-GetPdf context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPdf,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPdf
CREATE OR ALTER PROCEDURE dbo.GetPdf
    @Location integer,
    @DocId varchar(60)
AS

IF @Location = 0
    SELECT MailOutput As Datastring FROM AsMailOutput WHERE Id = @DocId
ELSE
    SELECT Datastring FROM AsDocumentData WHERE Id = @DocId
    
RETURN 0
