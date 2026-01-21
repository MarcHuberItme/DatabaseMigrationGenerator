--liquibase formatted sql

--changeset system:create-alter-procedure-IsAccountsPartnerSameById context:any labels:c-any,o-stored-procedure,ot-schema,on-IsAccountsPartnerSameById,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsAccountsPartnerSameById
CREATE OR ALTER PROCEDURE dbo.IsAccountsPartnerSameById
@AccountId1 uniqueidentifier,
@AccountId2 uniqueidentifier

AS

DECLARE @PartnerId1 uniqueidentifier
DECLARE @PartnerId2 uniqueidentifier
DECLARE @IsPartnersSame bit

Set @IsPartnersSame = 0

Select  @PartnerId1 = PtBase.Id from PtAccountBase
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
where PtAccountBase.Id = @AccountId1


Select @PartnerId2 = PtBase.Id from PtAccountBase
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
where PtAccountBase.Id = @AccountId2

if @PartnerId1 = @PartnerId2 
	BEGIN
		Set @IsPartnersSame = 1
	END
Else
	BEGIN
		Set @IsPartnersSame = 0
	END


Select @IsPartnersSame as IsPartnersSame
