--liquibase formatted sql

--changeset system:create-alter-procedure-GetProcConfStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProcConfStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProcConfStatus
CREATE OR ALTER PROCEDURE dbo.GetProcConfStatus
@ProcessID Uniqueidentifier,
@MinStatus Smallint Output AS

Set @MinStatus = (Select Min(ConfStatus) From AsUnconfirmed Where ProcessId = @ProcessID)
If @MinStatus Is Null 
    SET @MinStatus = 0
