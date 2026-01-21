--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfoliosForSecBalance context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfoliosForSecBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfoliosForSecBalance
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfoliosForSecBalance
@LastTransferProcessId UniqueIdentifier, @RC int
AS


Select  distinct top (@RC) PtBase.PartnerNo,PtPortfolio.PortfolioNo, PtPMSPortfolioTRansfer.PortfolioId from PtPMSPortfolioTRansfer
inner join PtPortfolio on PtPMSPortfolioTRansfer.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = Ptbase.Id
--left outer join PtPMSDailyAcctBalance on PtPMSDailyAcctBalance.LastTransferProcessId = @LastTransferProcessId and PtPMSDailyAcctBalance.PortfolioId=PtPortfolio.Id
Where PtPMSPortfolioTRansfer.InternalRejectCode = 0 
and PtPMSPortfolioTRansfer.PortfolioId not in 
(select PortfolioId from PtPMSDailySecurityBalance Where LastTransferProcessId = @LastTransferProcessId and SaveCompleted = 1)
Order by PartnerNo,PtPortfolio.PortfolioNo

