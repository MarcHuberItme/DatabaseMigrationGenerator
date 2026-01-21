--liquibase formatted sql

--changeset system:create-alter-procedure-InsertPaybackLogComp context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertPaybackLogComp,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertPaybackLogComp
CREATE OR ALTER PROCEDURE dbo.InsertPaybackLogComp

@Id uniqueidentifier,
@Creator varchar(50),
@PaybackLogId uniqueidentifier,
@AccountCompId uniqueidentifier,
@ReducedAmount money

AS

INSERT INTO PtAccountPaybackLogComp
(
Id,
HdCreator, 
HdChangeUser, 
HdVersionNo, 
AccountComponentId,
PaybackLogId,
ReducedAmount)

VALUES(
@Id,
@Creator,
@Creator,
1,
@AccountCompId,
@PaybackLogId,
@ReducedAmount)
