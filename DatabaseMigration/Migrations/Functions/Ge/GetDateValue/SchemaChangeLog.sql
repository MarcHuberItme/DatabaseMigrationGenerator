--liquibase formatted sql

--changeset system:create-alter-function-GetDateValue context:any labels:c-any,o-function,ot-schema,on-GetDateValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetDateValue
CREATE OR ALTER FUNCTION dbo.GetDateValue
(@INPUT VARCHAR(8000), @VaribleName Varchar(1000)) Returns Datetime


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

 
Return CAST ( isnull(@OUTPUT,'') AS Datetime)


End
