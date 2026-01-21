--liquibase formatted sql

--changeset system:create-alter-function-GetPM1CoupenFrequency context:any labels:c-any,o-function,ot-schema,on-GetPM1CoupenFrequency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetPM1CoupenFrequency
CREATE OR ALTER FUNCTION dbo.GetPM1CoupenFrequency
(
@TimeUnit int, @NumTimeUnit int
)
RETURNS int
AS BEGIN
RETURN (
Select case
	when @TimeUnit = 6	and @NumTimeUnit = 1	then		12
	when @TimeUnit = 6	and @NumTimeUnit = 3	then		4
	when @TimeUnit = 6	and @NumTimeUnit = 6	then		2
	when @TimeUnit = 7	and @NumTimeUnit = 1	then		1
	when @TimeUnit = 63	and @NumTimeUnit = 0	then		0
	else								null
   end)
END

