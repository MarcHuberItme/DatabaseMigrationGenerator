--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSForexContracts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSForexContracts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSForexContracts
CREATE OR ALTER PROCEDURE dbo.GetPMSForexContracts
@ReferenceDate DateTime, @inputContractNo int, @TransTypeNo smallint, @RC int
AS
Select top(@RC) PtContract.ContractNo, PtContract.SequenceNo,PtContract.Amount,PtContract.DateFrom, PtContract.DateTo, PtContract.FxBuyCurrency, PtContract.FxSellCurrency, PtContractPartner.FxDebitAccountNo, 
PtContractPartner.FxCreditAccountNo, PtContractPartner.ConversionRate, PtContractPartner.IsFxBuyer, 
PtContractPartner.ContributionAmount, DATransfer.Id as DATransferId, CATransfer.Id as CATransferId, 
PtTransType.TransTypeNo, PtTransType.PMSTransCodeDebit, PtPortfolio.PortfolioNo, PtBase.PartnerNo, DPortfolio.PortfolioNo as DPortfolioNo,CPortfolio.PortfolioNo as CPortfolioNo, DPartner.PartnerNo as DPartnerNo, CPartner.PartnerNo as CPartnerNo,  DPartner.Id as DPartnerId, CPartner.Id as CPartnerId,DPortfolio.
MasterPortfolioId as DMasterPortfolioId, CPortfolio.MasterPortfolioId as CMasterPortfolioId, 
DRelSlave.Id as DSlaveRelId,CRelSlave.Id as CSlaveRelId, PtContractPartner.Id as PtContractPartnerId, DPortfolio.Currency as DPortCurrency, CPortfolio.Currency as CPortCurrency,
PtPMSForexContractTransfer.*  from PtContractType
inner join PtContract on PtContractType.ContractType = PtContract.ContractType 
inner join PtContractPartner on PtContractPartner.ContractId = PtContract.Id and PtContractPartner.HdVersionNo between 1 and 999999998
inner join PtPortfolio on PtContractPartner.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
left outer join PtTransType on PtTransType.TransTypeNo = @TransTypeNo
inner join PtAccountBase DebitAcct  on PtContractPartner.FxDebitAccountNo = DebitAcct.AccountNo
inner join PtAccountBase CreditAcct  on PtContractPartner.FxCreditAccountNo = CreditAcct.AccountNo
inner join PtPortfolio DPortfolio on DebitAcct .PortfolioId = DPortfolio.Id
inner join PtPortfolio CPortfolio on CreditAcct .PortfolioId = CPortfolio.Id
inner join PtBase DPartner on DPortfolio.PartnerId = DPartner.Id
inner join PtBase CPartner on CPortfolio.PartnerId = CPartner.Id
left outer join PtPMSAccountTransfer DATransfer on DebitAcct.Id = DATransfer.AccountId
left outer join PtPMSAccountTransfer CATransfer on CreditAcct.Id = CATransfer.AccountId
left outer join PtPMSForexContractTransfer on PtContractPartner.Id = PtPMSForexContractTransfer.ContractPartnerId
left outer join PtRelationSlave DRelSlave on DPartner.Id = DRelSlave.PartnerId and DRelSlave.HdVersionNo between 1 and 999999998 and DRelSlave.RelationRoleNo = 7
left outer join PtRelationSlave CRelSlave on CPartner.Id = CRelSlave.PartnerId and CRelSlave.HdVersionNo between 1 and 999999998 and CRelSlave.RelationRoleNo = 7
Where IsFxTrade = 1 and PtContractType.HdVersionNo between 1 and 999999998 
and not (DATransfer.Id is null and CATransfer.Id is null)
and 
(
	(
		@inputContractNo is null And 
		(
			(convert(varchar(8), PtContract.DateFrom,112)  = @ReferenceDate And PtContract.Status = 4) 
			Or
			(@ReferenceDate between convert(varchar(8), PtContract.DateFrom,112) and convert(varchar(8), PtContract.DateTo,112) And PtContract.Status in (4, 98)) 
		)
	) 
	or PtContract.ContractNo = @inputContractNo 
)
and (PtPMSForexContractTransfer.LastTransferProcessId is null or @inputContractNo is not null)
