--liquibase formatted sql

--changeset system:create-alter-procedure-GetNameComparisonData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetNameComparisonData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetNameComparisonData
CREATE OR ALTER PROCEDURE dbo.GetNameComparisonData
@AccountNo decimal(11,0),
@RuleNo smallint,
@PaymentAmount money
As
DECLARE @Name nvarchar(40)
DECLARE @FirstName nvarchar(40)
DECLARE @MiddleName nvarchar(40)
DECLARE @NameCont nvarchar(40)
DECLARE @MaidenName nvarchar(40)
DECLARE @SexStatusNo tinyint
DECLARE @Street nvarchar(26)
DECLARE @HouseNo nvarchar(10)
DECLARE @Zip nvarchar(13)
DECLARE @Town nvarchar(25)

DECLARE  @IsToCompareName bit
DECLARE  @IsToCompareFirstName bit

DECLARE @MinPercentPartsMatched int
DECLARE @NameAcceptedMatchLen smallint
DECLARE @FirstNameAcceptedMatchLen smallint


DECLARE @AmountLimit money
DECLARE @NameComparisonRuleCount int

select @NameComparisonRuleCount = count(*) from PtNameComparisonRule where RuleNo = @RuleNo and HdVersionNo between 1 and 999999998

if @NameComparisonRuleCount = 0
Begin
	select @RuleNo =Value from AsParameterView 
	where GroupName = 'PaymentSystem' and ParameterName =  'DefaultNameComparisonRule'
	
End 



select @Name = PtBase.Name, @FirstName = PtBase.FirstName, @MiddleName = PtBase.MiddleName, @NameCont = PtBase.NameCont, @MaidenName = PtBase.MaidenName, @SexStatusNo = PtBase.SexStatusNo,
@Street = PtAddress.Street, @HouseNo = PtAddress.HouseNo, @Zip = PtAddress.Zip, @Town = PtAddress.Town
from PtBase
inner join PtPortfolio on PtBase.Id  = PtPortfolio.PartnerId
inner join PtAccountBase on PtPortfolio.Id = PtAccountBase.PortfolioId
left outer join PtAddress on PtBase.Id = PtAddress.PartnerId
where PtAccountBase.AccountNo = @AccountNo
and PtAddress.AddressTypeNo = 11

select top 1 @IsToCompareName = IsToCompareName, @IsToCompareFirstName = IsToCompareFirstName,
       @MinPercentPartsMatched =  MinPercentPartsMatched, @NameAcceptedMatchLen=NameAcceptedMatchLen,
	@FirstNameAcceptedMatchLen = FirstNameAcceptedMatchLen, @AmountLimit = AmountLimit from PtNameComparisonRuleLimit
	where RuleNo = @RuleNo and AmountLimit >= @PaymentAmount and SexStatusNo=@SexStatusNo
	order by AmountLimit

if @@Rowcount = 0  
	Begin
		select top 1 @IsToCompareName = IsToCompareName, @IsToCompareFirstName = IsToCompareFirstName,
       		@MinPercentPartsMatched =  MinPercentPartsMatched, @NameAcceptedMatchLen=NameAcceptedMatchLen,
		@FirstNameAcceptedMatchLen = FirstNameAcceptedMatchLen, @AmountLimit = AmountLimit from PtNameComparisonRuleLimit
		where RuleNo = @RuleNo and AmountLimit >= @PaymentAmount and SexStatusNo is null
		order by AmountLimit
		
	end


select @Name as Name, @FirstName as FirstName, @MiddleName as MiddleName, @NameCont as NameCont, @MaidenName as MaidenName, @IsToCompareName as IsToCompareName, 
@IsToCompareFirstName as IsToCompareFirstName,@MinPercentPartsMatched as MinPercentPartsMatched, 
@NameAcceptedMatchLen as NameAcceptedMatchLen, @FirstNameAcceptedMatchLen as FirstNameAcceptedMatchLen, @AmountLimit as AmountLimit, @Street as Street, @HouseNo as HouseNo, @Zip as Zip, @Town as Town, @SexStatusNo as SexStatusNo
