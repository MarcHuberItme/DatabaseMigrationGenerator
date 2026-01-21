--liquibase formatted sql

--changeset system:create-alter-procedure-GetStaffRebateInfoForAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetStaffRebateInfoForAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetStaffRebateInfoForAccount
CREATE OR ALTER PROCEDURE dbo.GetStaffRebateInfoForAccount
@AccountNo decimal(16,0),
@ApplicableDate  datetime,
@RsOutput  bit,
@HasStaffRebate bit OUTPUT
As
Declare @PartnerId  uniqueidentifier

select @PartnerId = PartnerId from PtAccountBase 
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id   
Where AccountNo = @AccountNo


exec GetStaffRebateInfo  @PartnerId, @ApplicableDate, 1 , @HasStaffRebate output
