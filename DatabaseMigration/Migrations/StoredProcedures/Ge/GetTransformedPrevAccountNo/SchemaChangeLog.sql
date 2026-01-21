--liquibase formatted sql

--changeset system:create-alter-procedure-GetTransformedPrevAccountNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTransformedPrevAccountNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTransformedPrevAccountNo
CREATE OR ALTER PROCEDURE dbo.GetTransformedPrevAccountNo
@AccountNo	VARCHAR(11),
@Currency      	VARCHAR(3)

AS

DECLARE	@MaxVersionNo int
SET		@MaxVersionNo = 999999998

SELECT		Top 1 PrevAccountNo
FROM		MgAccountNoConversion
WHERE		NewAccountNo = @AccountNo
	AND Currency = @Currency
	AND HdVersionNo BETWEEN 1 AND @MaxVersionNo 
ORDER BY	PrevAccountNo
