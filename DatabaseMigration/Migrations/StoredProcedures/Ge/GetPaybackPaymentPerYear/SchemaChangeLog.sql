--liquibase formatted sql

--changeset system:create-alter-procedure-GetPaybackPaymentPerYear context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPaybackPaymentPerYear,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPaybackPaymentPerYear
CREATE OR ALTER PROCEDURE dbo.GetPaybackPaymentPerYear
@AccountId  uniqueidentifier,	
@Year integer,
@TotalPayback Money OUTPUT
	
As	
	
DECLARE @Payback money	
	
select 	@Payback = SUM(TI.CreditAmount)
from    PtAccountBase PAB
JOIN    PrReference REF on REF.AccountId = PAB.Id
JOIN    PtPosition POS on POS.ProdReferenceId = REF.Id
JOIN    PtTransItem TI on TI.PositionId = POS.Id and TI.IsClosingItem = 0 and TI.HdVersionNo between 1 and 999999998
where	PAB.Id = @AccountId and YEAR(TI.ValueDate) = @Year
	
if(@Payback  IS NULL)	
begin	
	SET @Payback = 0
end	
set @TotalPayback = @Payback
	
Select  @TotalPayback AS TotalPayback
