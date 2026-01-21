--liquibase formatted sql

--changeset system:create-alter-procedure-CheckConfirmationGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckConfirmationGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckConfirmationGroup
CREATE OR ALTER PROCEDURE dbo.CheckConfirmationGroup
   @ProcessId As UNIQUEIDENTIFIER,
   @AmountUnconfirmed As INTEGER OUTPUT,
   @LatestActivationDate As DATETIME OUTPUT
AS
   SET @AmountUnconfirmed = (SELECT COUNT(*) FROM AsUnconfirmed 
      WHERE ProcessId = @ProcessId
         AND ConfStatus = 2)
  
IF @AmountUnconfirmed = 0
   BEGIN
      SET @LatestActivationDate = (SELECT MAX(ActivationDate) 
         FROM AsUnconfirmed
         WHERE ProcessId = @ProcessId
            AND ConfStatus = 3)

      IF @LatestActivationDate IS NULL
         SET @LatestActivationDate = '18991230 00:00:00'
   END

 
