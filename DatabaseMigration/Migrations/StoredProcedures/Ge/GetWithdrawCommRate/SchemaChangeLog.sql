--liquibase formatted sql

--changeset system:create-alter-procedure-GetWithdrawCommRate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetWithdrawCommRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetWithdrawCommRate
CREATE OR ALTER PROCEDURE dbo.GetWithdrawCommRate
@ReferenceDate datetime
As
declare @WithdrawCommPriceType nvarchar(50)
declare @CommissionRate decimal(19)
declare @PriceTypeNo int

exec AsParameter_GetValue 'WithdrawalCommission','PriceTypeCommission',@WithdrawCommPriceType output

if len(@WithdrawCommPriceType) > 0
begin
	if isnumeric(@WithdrawCommPriceType)=1
	begin
		select top 1 @CommissionRate= CommissionRate, @PriceTypeNo = StandardPriceNo from PrStandardPriceValue 
		Where StandardPriceNo = @WithdrawCommPriceType
		and HdVersionNo between 1 and 999999998
		and @ReferenceDate >= ValidFrom
		order by ValidFrom desc
	end	
end

select @CommissionRate as WithdrawCommissionRate,@PriceTypeNo as StandardPriceTypeNo
