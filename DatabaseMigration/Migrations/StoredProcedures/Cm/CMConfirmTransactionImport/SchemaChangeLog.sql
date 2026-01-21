--liquibase formatted sql

--changeset system:create-alter-procedure-CMConfirmTransactionImport context:any labels:c-any,o-stored-procedure,ot-schema,on-CMConfirmTransactionImport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CMConfirmTransactionImport
CREATE OR ALTER PROCEDURE dbo.CMConfirmTransactionImport
@FileImportProcessId uniqueidentifier

As

Insert into PtTransMessageIn (Id, HdCreateDate, HdChangeDate, HdCreator, HdVersionNo, HdEditStamp, HdPendingChanges, HdPendingSubChanges,
Status,MessageStandard, Message, FileImportProcessId, ClearingDate, MgStatus, PDEKey)
Select Id, GetDate(), GetDate(), HdCreator, HdVersionNo, newid(), 0,0, 9, MessageStandardCode,  Message, ImportProcessId,
getdate(),9, PDEkey from PtTransMessageTemp
where ImportProcessId =@FileImportProcessId

Update PtTransMessageTemp Set Status =  6 where ImportProcessId =@FileImportProcessId


Update CMFileImportProcess Set FileImportCompletionTime = GetDate(), FileImportConfirmationTime =GetDate() , FileStatus = 1 
where Id = @FileImportProcessId
