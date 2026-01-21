--liquibase formatted sql

--changeset system:create-alter-function-SplitAddressPerColumn context:any labels:c-any,o-function,ot-schema,on-SplitAddressPerColumn,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function SplitAddressPerColumn
CREATE OR ALTER FUNCTION dbo.SplitAddressPerColumn
(
      @String VARCHAR(MAX),  -- Variable for string
      @delimiter VARCHAR(50) -- Delimiter in the string 
)
RETURNS TABLE
As
Return
(
Select 
max(case a.Position 
	When 1 then a.SplitColumn 
	End) as Address1,
max(case a.Position 
	When 2 then a.SplitColumn 
	End) as Address2,
max(case a.Position 
	When 3 then a.SplitColumn 
	End) as Address3,
max(case a.Position 
	When 4 then a.SplitColumn 
	End) as Address4,
max(case a.Position 
	When 5 then a.SplitColumn 
	End) as Address5, 
max(case a.Position 
	When 6 then a.SplitColumn 
	End) as Address6 from 

dbo.SplitString(@String, @delimiter )  a
)
