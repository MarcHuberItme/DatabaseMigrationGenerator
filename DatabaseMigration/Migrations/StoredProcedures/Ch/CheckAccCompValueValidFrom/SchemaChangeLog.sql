--liquibase formatted sql

--changeset system:create-alter-procedure-CheckAccCompValueValidFrom context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckAccCompValueValidFrom,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckAccCompValueValidFrom
CREATE OR ALTER PROCEDURE dbo.CheckAccCompValueValidFrom

@AccountComponentId AS uniqueidentifier,
@AccountCompValueId AS uniqueidentifier,
@ValidFrom AS datetime
AS 

SELECT * FROM PtAccountCompValue 
WHERE Id <> @AccountCompValueId
AND AccountComponentId = @AccountComponentId
AND (HdPendingChanges <> 0 OR
   (year(ValidFrom) = year(@ValidFrom) 
    AND month(ValidFrom) = month(@ValidFrom) 
    AND day(ValidFrom) = day(@ValidFrom) 
   ) 
)
