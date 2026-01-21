--liquibase formatted sql

--changeset system:create-alter-function-GetEsrRefNoWithCorrectChecksum context:any labels:c-any,o-function,ot-schema,on-GetEsrRefNoWithCorrectChecksum,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetEsrRefNoWithCorrectChecksum
CREATE OR ALTER FUNCTION dbo.GetEsrRefNoWithCorrectChecksum
(@InputEsrRefNo varchar(27)) 
RETURNS varchar(27)

BEGIN
DECLARE @strKeyNo varchar(10) = '0946827135' --  Fix char array for: Modulo 10, recursive for checksum calculation for ESR reference numbers.
DECLARE @intCarry int = 0
DECLARE @intCounter int = 0
DECLARE @intPosition int = 0

WHILE @intCounter < 27
BEGIN
	SET @intPosition = (@intCarry + CAST(SUBSTRING(@InputEsrRefNo, @intCounter, 1) AS int)) % 10;

	SET @intCarry = CAST(SUBSTRING(@strKeyNo, @intPosition + 1, 1) AS int);

	SET @intCounter = @intCounter + 1;
END

SET @intCarry = (10 - @intCarry) % 10;

RETURN SUBSTRING(@InputEsrRefNo, 1, 26) + CAST(@intCarry AS varchar(1))

END
