--liquibase formatted sql

--changeset system:create-alter-procedure-InsertPaybackLog context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertPaybackLog,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertPaybackLog
CREATE OR ALTER PROCEDURE dbo.InsertPaybackLog

@Id uniqueidentifier,
@Creator varchar(50),
@AccountPaybackId uniqueidentifier,
@MatureDate datetime

AS 

INSERT INTO PtAccountPaybackLog
(
Id,
HdCreator, 
HdChangeUser, 
HdVersionNo, 
AccountPaybackId,
MatureDate)

VALUES(
@Id,
@Creator,
@Creator,
1,
@AccountPaybackId,
@MatureDate)
