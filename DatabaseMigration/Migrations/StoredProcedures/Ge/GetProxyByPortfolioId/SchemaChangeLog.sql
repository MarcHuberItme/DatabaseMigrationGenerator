--liquibase formatted sql

--changeset system:create-alter-procedure-GetProxyByPortfolioId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProxyByPortfolioId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProxyByPortfolioId
CREATE OR ALTER PROCEDURE dbo.GetProxyByPortfolioId
@MasterId UniqueIdentifier,
@PortfolioId UniqueIdentifier,
@Date Datetime

AS

Select R.Id,R.PartnerId,R.ContactPersonId,P.Id,P.RelationSlaveId,
       P.PortfolioId,P.ValidFrom,P.ValidTo,P.ProxyRightNo,
       P.DisposalRightNo,P.Instruction,P.InstructionVerifyFlag, P.Instruction as InstructionDetail, P.SafeDepositID
From PtRelationSlave R
Left Outer Join PtProxyDetail P  On R.Id = P.RelationSlaveId
Where R.MasterId = @MasterId
   And (P.PortfolioId = @PortfolioId
     Or (P.PortfolioId Is NULL And P.AccountId Is NULL And P.SafeDepositId Is NULL))
   And P.ValidFrom <= @Date And (P.ValidTo >= @Date Or P.ValidTo is Null)
   And R.HdVersionNo < 999999999 And P.HdVersionNo < 999999999
Order by P.RelationSlaveId,PortfolioId DESC

