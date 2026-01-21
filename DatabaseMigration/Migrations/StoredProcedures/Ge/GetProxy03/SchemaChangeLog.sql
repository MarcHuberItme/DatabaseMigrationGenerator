--liquibase formatted sql

--changeset system:create-alter-procedure-GetProxy03 context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProxy03,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProxy03
CREATE OR ALTER PROCEDURE dbo.GetProxy03
@PartnerIdGiving UniqueIdentifier,
@PartnerIdReceiving UniqueIdentifier,
@ContactPersonIdReceiving UniqueIdentifier,
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
JOIN   PtRelationMaster As RM ON RS.MasterId = RM.Id
WHERE  PD.AccountId IS NULL
AND    PD.PortfolioId IS NULL
AND    RS.PartnerId = @PartnerIdReceiving
AND    RM.RelationTypeNo = @RelationTypeNo
AND    RM.PartnerId = @PartnerIdGiving
AND  ((RS.ContactPersonId = @ContactPersonIdReceiving)
OR   ((RS.ContactPersonId IS NULL) AND (@ContactPersonIdReceiving IS NULL)))
AND   (PD.ValidFrom IS NULL OR PD.ValidFrom <= @Date)
AND   (PD.ValidTo IS NULL OR PD.ValidTo > dateadd(day,1,@Date))
AND     PD.HdVersionNo BETWEEN 1 AND 999999998
AND     PR.HdVersionNo BETWEEN 1 AND 999999998
AND     RS.HdVersionNo BETWEEN 1 AND 999999998
AND     RM.HdVersionNo BETWEEN 1 AND 999999998

