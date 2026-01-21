--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardChangeRequest context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardChangeRequest,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardChangeRequest
CREATE OR ALTER PROCEDURE dbo.DeleteCardChangeRequest
  @RequestId UNIQUEIDENTIFIER AS
DELETE FROM PtAgrCard WHERE Id = @RequestId AND CardStatus = 0
