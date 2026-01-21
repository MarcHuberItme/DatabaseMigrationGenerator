--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecRelevantPortfolioNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecRelevantPortfolioNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecRelevantPortfolioNo
CREATE OR ALTER PROCEDURE dbo.GetPMSSecRelevantPortfolioNo
@debitPortfolioId UniqueIdentifier,
@creditPortfolioId UniqueIdentifier,
@publicId UniqueIdentifier,
@TransDate DateTime
As
declare @relevantPortfolioNo decimal


Select @relevantPortfolioNo = PortfolioNo from PtPosition 
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId and PrPublic.Id = @publicId
inner join PtPortfolio on PtPosition.PortfolioId = PtPortfolio.Id
Where PortfolioId = @debitPortfolioId
and PtPosition.LatestTransDate >= @TransDate 


if @relevantPortfolioNo is null

	begin

		Select @relevantPortfolioNo = PortfolioNo from PtPosition 
		inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
		inner join PrPublic on PrReference.ProductId = PrPublic.ProductId and PrPublic.Id = @publicId
		inner join PtPortfolio on PtPosition.PortfolioId = PtPortfolio.Id
		Where PortfolioId = @creditPortfolioId
                                and PtPosition.LatestTransDate >= @TransDate 

	end 

-- try without TransDate limit
if @relevantPortfolioNo is null

	begin
		Select @relevantPortfolioNo = PortfolioNo from PtPosition 
		inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
		inner join PrPublic on PrReference.ProductId = PrPublic.ProductId and PrPublic.Id = @publicId
		inner join PtPortfolio on PtPosition.PortfolioId = PtPortfolio.Id
		Where PortfolioId = @debitPortfolioId
                    
	end 

if @relevantPortfolioNo is null

	begin
		Select @relevantPortfolioNo = PortfolioNo from PtPosition 
		inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
		inner join PrPublic on PrReference.ProductId = PrPublic.ProductId and PrPublic.Id = @publicId
		inner join PtPortfolio on PtPosition.PortfolioId = PtPortfolio.Id
		Where PortfolioId = @creditPortfolioId
                    
	end 

select @relevantPortfolioNo as RelevantPortfolioNo
