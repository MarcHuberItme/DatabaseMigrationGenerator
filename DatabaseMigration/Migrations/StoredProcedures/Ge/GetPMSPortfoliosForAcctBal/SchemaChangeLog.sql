--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfoliosForAcctBal context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfoliosForAcctBal,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfoliosForAcctBal
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfoliosForAcctBal
@LastTransferProcessId UniqueIdentifier, @RC int
AS

Select  distinct top (@RC) PtBase.PartnerNo,PtPortfolio.PortfolioNo, PtAccountBase.PortfolioId from PtPMSAccountTransfer
inner join PtAccountBase on PtPMSAccountTransfer.AccountId = PtAccountBAse.Id
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = Ptbase.Id
left outer join PtPMSDailyAcctBalance on PtPMSDailyAcctBalance.LastTransferProcessId = @LastTransferProcessId and PtPMSDailyAcctBalance.PortfolioId=PtPortfolio.Id
Where PtPMSAccountTransfer.InternalRejectCode = 0 and PtPMSDailyAcctBalance.Id is null
Order by PartnerNo,PtPortfolio.PortfolioNo
