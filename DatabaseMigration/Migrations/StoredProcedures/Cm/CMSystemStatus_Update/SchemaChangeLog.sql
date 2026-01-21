--liquibase formatted sql

--changeset system:create-alter-procedure-CMSystemStatus_Update context:any labels:c-any,o-stored-procedure,ot-schema,on-CMSystemStatus_Update,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CMSystemStatus_Update
CREATE OR ALTER PROCEDURE dbo.CMSystemStatus_Update

@SystemId uniqueidentifier,
@Code varchar(10),
@Queue varchar(100),
@Status bit

As 
DECLARE @intCount INT

SELECT  @intCount=Count(Code) FROM CMSystemStatus
                where SystemId = @SystemId

IF @intCount = 0

      BEGIN
	Insert into CMSystemStatus (SystemId, Code, Status, Queue) 
                Values(@SystemId, @Code, @Status, @Queue)
		
       END

Else

       BEGIN
                Update CMSystemStatus
                Set Code = @Code, 
                Queue = @Queue,
                Status = @Status where
                SystemId = @SystemId
       END
