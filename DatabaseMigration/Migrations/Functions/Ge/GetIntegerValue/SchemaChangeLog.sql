--liquibase formatted sql

--changeset system:create-alter-function-GetIntegerValue context:any labels:c-any,o-function,ot-schema,on-GetIntegerValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetIntegerValue
CREATE OR ALTER FUNCTION dbo.GetIntegerValue
(@INPUT VARCHAR(8000), @VaribleName Varchar(1000)) Returns bigint


Begin
--DECLARe @INPUT VARCHAR(1000)
--Declare @VaribleName As Varchar(1000)
Declare @OUTPUT as Varchar (1000)
Declare @StartIndex as Integer
Declare @ValueLen as Integer


--SET @VaribleName = 'ZIP'
--SET @INPUT =	'ZIP=5600,RegionGroup=,ErrorState=,Country='

SET @StartIndex = PATINDEX ( '%'+ @VaribleName +'=%', @INPUT )+ LEN(@VaribleName +'=')
set @ValueLen = CHARINDEX (  ',', @INPUT,@StartIndex)  

if @ValueLen > 0 
	set @ValueLen = @ValueLen - @StartIndex
Else
	set @ValueLen = Len(@INPUT)+1 - @StartIndex

SET @OUTPUT = SUBSTRING ( @INPUT ,@StartIndex , @ValueLen )

 
Return CAST ( isnull(@OUTPUT,0) AS bigint )


End
