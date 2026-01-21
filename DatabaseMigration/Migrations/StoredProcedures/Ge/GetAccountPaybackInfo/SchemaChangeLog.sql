--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPaybackInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPaybackInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPaybackInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountPaybackInfo

@AccountPaybackId uniqueidentifier

AS

SELECT * FROM PtAccountPaybackView
WHERE Id = @AccountPaybackId
