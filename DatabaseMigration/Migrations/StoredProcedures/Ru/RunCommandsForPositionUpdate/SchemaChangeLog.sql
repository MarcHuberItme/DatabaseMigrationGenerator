--liquibase formatted sql

--changeset system:create-alter-procedure-RunCommandsForPositionUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-RunCommandsForPositionUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunCommandsForPositionUpdate
CREATE OR ALTER PROCEDURE dbo.RunCommandsForPositionUpdate
@TransId			UNIQUEIDENTIFIER,
@UserName		VARCHAR(20)

AS
------------------- Update PtTransItem

UPDATE PtTransItem SET DetailCounter=1, HdChangeUser=@UserName,
       HdChangeDate=GETDATE(), HdVersionNo=HdVersionNo+1 WHERE TransId = @TransId

------------------- Update PtTransaction

UPDATE PtTransaction SET UpdateStatus = 1, HdChangeUser=@UserName,
       HdChangeDate=GETDATE(), HdVersionNo=HdVersionNo+1 WHERE Id = @TransId

