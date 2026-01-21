--liquibase formatted sql

--changeset system:create-alter-procedure-GetProxy02 context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProxy02,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProxy02
CREATE OR ALTER PROCEDURE dbo.GetProxy02
@PartnerId UniqueIdentifier,
@ContactPersonId UniqueIdentifier,
@PortfolioId UniqueIdentifier,
@Date Datetime,
@RelationTypeNo Integer

As

SELECT PD.RelationSlaveId, RS.PartnerId, RS.ContactPersonId, PD.Id,
       PD.PortfolioId, PD.AccountId, PD.ValidFrom, PD.ValidTo, PD.ProxyRightNo,
       PD.DisposalRightNo, PD.Instruction, PD.InstructionVerifyFlag,
       RightCumulation =
       CASE 
         WHEN (PD.AccountId IS NOT NULL AND PR.HasRight = 1) THEN 1
         WHEN (PD.AccountId IS NOT NULL AND PR.HasRight = 0) THEN 2
         WHEN (PD.AccountId IS NULL AND PD.PortfolioId IS NOT NULL AND PR.HasRight = 1) THEN 10
         WHEN (PD.AccountId IS NULL AND PD.PortfolioId IS NOT NULL AND PR.HasRight = 0) THEN 20
         WHEN (PD.AccountId IS NULL AND PD.PortfolioId IS NULL AND PR.HasRight = 1) THEN 100
         WHEN (PD.AccountId IS NULL AND PD.PortfolioId IS NULL AND PR.HasRight = 0) THEN 200
       END
FROM   PtRelationSlave RS
JOIN   PtProxyDetail PD ON RS.Id = PD.RelationSlaveId
JOIN   PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
JOIN   PtRelationMaster RM ON RS.MasterId = RM.Id
WHERE  PD.AccountId IS NULL
AND    PD.PortfolioId = @PortfolioId
AND    RS.PartnerId = @PartnerId
AND    RM.RelationTypeNo = @RelationTypeNo
AND    ((RS.ContactPersonId = @ContactPersonId)
OR     ((RS.ContactPersonId IS NULL) AND (@ContactPersonId IS NULL)))
AND   (PD.ValidFrom IS NULL OR PD.ValidFrom <= @Date)
AND   (PD.ValidTo IS NULL OR PD.ValidTo > dateadd(day,1,@Date))
AND     PD.HdVersionNo BETWEEN 1 AND 999999998
AND     PR.HdVersionNo BETWEEN 1 AND 999999998
AND     RS.HdVersionNo BETWEEN 1 AND 999999998

