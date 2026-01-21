--liquibase formatted sql

--changeset system:create-alter-procedure-BpTaskHaTokenCtrl_TrySwitchToken context:any labels:c-any,o-stored-procedure,ot-schema,on-BpTaskHaTokenCtrl_TrySwitchToken,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure BpTaskHaTokenCtrl_TrySwitchToken
CREATE OR ALTER PROCEDURE dbo.BpTaskHaTokenCtrl_TrySwitchToken
    @TakeTokenFromTaskId uniqueidentifier,
    @TakeTokenFromTaskIdHdEditStamp uniqueidentifier,
    @GiveTokenToTaskId uniqueidentifier
AS
    UPDATE BpTaskHaTokenCtrl SET
        HasToken = 0,
        HdChangeDate = GETDATE(),
        HdEditStamp = NEWID()
        WHERE TaskId = @TakeTokenFromTaskId AND HasToken = 1 AND HdEditStamp = @TakeTokenFromTaskIdHdEditStamp;
    IF @@ROWCOUNT = 1 BEGIN 
        UPDATE BpTaskHaTokenCtrl SET 
            HasToken = 1,
            HdChangeDate = GETDATE(),
            HdEditStamp = NEWID()            
            WHERE TaskId = @GiveTokenToTaskId AND HasToken = 0;
    END
