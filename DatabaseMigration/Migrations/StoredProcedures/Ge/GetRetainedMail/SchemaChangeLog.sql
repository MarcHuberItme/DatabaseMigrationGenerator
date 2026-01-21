--liquibase formatted sql

--changeset system:create-alter-procedure-GetRetainedMail context:any labels:c-any,o-stored-procedure,ot-schema,on-GetRetainedMail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetRetainedMail
CREATE OR ALTER PROCEDURE dbo.GetRetainedMail
@PartnerId as Uniqueidentifier
AS

SELECT D.VirtualDate FROM AsDocument D
JOIN AsDocumentData A ON D.Id = A.DocumentId
WHERE D.PartnerId = @PartnerId AND A.StatusNo = 105
