--liquibase formatted sql

--changeset system:create-alter-procedure-UpdateExtPaybackPaymentPerYear context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdateExtPaybackPaymentPerYear,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdateExtPaybackPaymentPerYear
CREATE OR ALTER PROCEDURE dbo.UpdateExtPaybackPaymentPerYear

@Id  uniqueidentifier,	
@Year integer,
@Amount money	

As	

DECLARE @recCount integer

select @recCount = count(*) from PtAccountPaybackAccountPayList where PaybackAccountId = @Id and Year = @Year and HdVersionNo < 999999999

if(@recCount  = 0)
begin	
  insert into PtAccountPaybackAccountPayList (PaybackAccountId, Year, LastControlDate, PaybackYearToDateAmount) select @Id, @Year,null,@Amount
end
else
begin	
  update PtAccountPaybackAccountPayList Set PaybackYearToDateAmount = @Amount where PaybackAccountId = @Id and year= @Year
end
