--liquibase formatted sql

--changeset system:create-alter-procedure-IsAccountsPartnerSame context:any labels:c-any,o-stored-procedure,ot-schema,on-IsAccountsPartnerSame,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsAccountsPartnerSame
CREATE OR ALTER PROCEDURE dbo.IsAccountsPartnerSame
@AccountNo1 decimal(11,0),
@AccountNo2 decimal(11,0)

AS

DECLARE @PartnerId1 uniqueidentifier
DECLARE @PartnerId2 uniqueidentifier
DECLARE @IsPartnersSame bit

Set @IsPartnersSame = 0

Select  @PartnerId1 = PtBase.Id from PtAccountBase
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
where PtAccountBase.AccountNo = @AccountNo1


Select @PartnerId2 = PtBase.Id from PtAccountBase
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
where PtAccountBase.AccountNo = @AccountNo2

if @PartnerId1 = @PartnerId2 
	BEGIN
		Set @IsPartnersSame = 1
	END
Else
	BEGIN
		Set @IsPartnersSame = 0
	END


Select @IsPartnersSame as IsPartnersSame
