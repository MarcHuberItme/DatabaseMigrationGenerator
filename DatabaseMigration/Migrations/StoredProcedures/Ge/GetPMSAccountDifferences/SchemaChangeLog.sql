--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAccountDifferences context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAccountDifferences,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAccountDifferences
CREATE OR ALTER PROCEDURE dbo.GetPMSAccountDifferences
As
Declare @LastNetfolioBalanceDate datetime
Declare @AccountancyPeriod int
Declare @TransferProcessId UniqueIdentifier
DEclare @Id UniqueIdentifier 

exec VaRunIdLastDailyRun @Id Output
 
Select top 1 @TransferProcessId=Id, @LastNetfolioBalanceDate= TransDate  from PtPMsTransferProcess Where TransferTypeCode = 14 
and TransDate = (Select max(TransDate) from PtPMsTransferProcess where TransferTypeCode = 14)

Select PtAccountBase.AccountNo,  a.Quantity as FinstarBalance,
n.AccountBalance , a.Quantity -n.AccountBalance as Difference from PtPMSDailyAcctBalance n
inner join PtAccountBase on n.AccountNo = PtAccountBase.AccountNo
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtInsaPartner on PtPortfolio.PartnerId = PtInsaPartner.PartnerId and PtInsaPartner.IsValidForPMS=1
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId
inner  join VaPosQuant a on  PtPosition.Id = a.PositionId and VaRunId = @Id
Where LastTransferProcessId = @TransferProcessId
and a.Quantity <> n.AccountBalance
and not (n.AccountNo=83168052 and n.PortfolioId = '593ADDFB-4499-4FC6-961F-D378CFBBA6AF')
