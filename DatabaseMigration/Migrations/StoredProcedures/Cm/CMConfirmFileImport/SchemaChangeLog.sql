--liquibase formatted sql

--changeset system:create-alter-procedure-CMConfirmFileImport context:any labels:c-any,o-stored-procedure,ot-schema,on-CMConfirmFileImport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CMConfirmFileImport
CREATE OR ALTER PROCEDURE dbo.CMConfirmFileImport
@FileImportProcessId uniqueidentifier
As

Update PtTransMessageIn Set Status =  9, MgStatus = 9 where FileImportProcessId = @FileImportProcessId

Update CMFileImportProcess Set FileImportCompletionTime = GetDate(), FileImportConfirmationTime =GetDate() , FileStatus = 1 
where Id = @FileImportProcessId
