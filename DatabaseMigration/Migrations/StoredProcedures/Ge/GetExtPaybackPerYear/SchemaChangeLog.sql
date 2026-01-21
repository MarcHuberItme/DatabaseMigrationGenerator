--liquibase formatted sql

--changeset system:create-alter-procedure-GetExtPaybackPerYear context:any labels:c-any,o-stored-procedure,ot-schema,on-GetExtPaybackPerYear,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetExtPaybackPerYear
CREATE OR ALTER PROCEDURE dbo.GetExtPaybackPerYear
@Id  uniqueidentifier,	
@Year integer,
@TotalPayback Money OUTPUT
	
As	
	
DECLARE @Payback money	
	
select 	@Payback = SUM(PayList.PaybackYearToDateAmount)
from    PtAccountPaybackAccountPayList PayList
where	PayList.PaybackAccountId = @Id and PayList.Year = @Year
	
if(@Payback  IS NULL)	
begin	
	SET @Payback = 0
end	
set @TotalPayback = @Payback
	
Select  @TotalPayback AS TotalPayback
