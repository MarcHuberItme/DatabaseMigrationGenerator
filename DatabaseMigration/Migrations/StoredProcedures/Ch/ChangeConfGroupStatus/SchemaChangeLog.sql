--liquibase formatted sql

--changeset system:create-alter-procedure-ChangeConfGroupStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-ChangeConfGroupStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure ChangeConfGroupStatus
CREATE OR ALTER PROCEDURE dbo.ChangeConfGroupStatus
    @ProcessId UNIQUEIDENTIFIER,
    @OldStatus TINYINT,
    @NewStatus TINYINT
AS
    UPDATE AsNavigationIndex 
        SET Status = @NewStatus
        FROM AsNavigationIndex I, AsNavigationIndexSub S, AsUnconfirmed U
            WHERE U.Id = S.Id
                AND S.NavigationIndexId = I.Id
                AND U.ProcessId = @ProcessId
                AND I.Status = @OldStatus

 UPDATE AsNavigationIndex 
        SET Status = @NewStatus
        FROM AsNavigationIndex I, AsUnconfirmed U
            WHERE U.Id = I.TableId
                AND U.ProcessId = @ProcessId
                AND I.Status = @OldStatus
            
    UPDATE AsNavigationIndexSub
        SET ConfStatus = @NewStatus
        FROM AsNavigationIndexSub S, AsUnconfirmed U
            WHERE U.Id = S.Id
                AND U.ProcessId = @ProcessId
                AND S.ConfStatus = @OldStatus
               
    UPDATE AsUnconfirmed 
        SET ConfStatus = @NewStatus
        WHERE ProcessId = @ProcessId
            AND ConfStatus = @OldStatus

