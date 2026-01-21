--liquibase formatted sql

--changeset system:create-alter-function-GetALRightsReceivedIds context:any labels:c-any,o-function,ot-schema,on-GetALRightsReceivedIds,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetALRightsReceivedIds
CREATE OR ALTER FUNCTION dbo.GetALRightsReceivedIds
(
@PartnerId uniqueidentifier,
@ContactPersonFlag varchar(1),
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo integer
)
RETURNS TABLE
AS
RETURN (
SELECT A.AccountId FROM
(SELECT MP.AccountId As AccountId, CAST(SUM(MP.RightCumulation) AS varchar(4)) As Rights FROM

(SELECT PA.Id As AccountId,
        1000 As RightCumulation
FROM PtAccountBase As PA
JOIN PtPortfolio As PP ON PA.PortfolioId = PP.Id
WHERE PP.HdVersionNo BETWEEN 1 AND 999999998
AND PA.HdVersionNo BETWEEN 1 AND 999999998
AND PP.PartnerId = @PartnerId
AND (PA.OpeningDate IS NULL OR PA.OpeningDate <= @PerDate+1)
AND (PA.TerminationDate IS NULL OR PA.TerminationDate >= @PerDate)
UNION
SELECT PA.Id As AccountId,
       RightCumulation =
       CASE 
         WHEN ((PR.HasRight = 1) AND ((PR.IsCollective = 0) OR (@ExclCollectiveFlag = 0))) THEN 100
         ELSE 200
       END
FROM PtAccountBase As PA
JOIN PtPortfolio As PP ON PA.PortfolioId = PP.Id
JOIN PtRelationMaster As RM ON PP.PartnerId = RM.PartnerId
JOIN PtRelationSlave As RS ON RM.Id = RS.MasterId
JOIN PtProxyDetail As PD ON RS.Id = PD.RelationSlaveId
JOIN PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
WHERE RM.HdVersionNo BETWEEN 1 AND 999999998
AND RS.HdVersionNo BETWEEN 1 AND 999999998
AND PD.HdVersionNo BETWEEN 1 AND 999999998
AND PP.HdVersionNo BETWEEN 1 AND 999999998
AND PA.HdVersionNo BETWEEN 1 AND 999999998
AND RM.RelationTypeNo = @RelationTypeNo
AND (((@ContactPersonFlag = 'P') AND (RS.PartnerId = @PartnerId))
OR   ((@ContactPersonFlag = 'C') AND (RS.ContactPersonId = @PartnerId)))
AND (RS.ValidFrom IS NOT NULL)
AND (RS.ValidFrom <= @PerDate)
AND (RS.ValidTo IS NULL OR RS.ValidTo >= @PerDate)
AND (PD.ValidFrom IS NOT NULL)
AND (PD.ValidFrom <= @PerDate)
AND (PD.ValidTo IS NULL OR PD.ValidTo >= @PerDate)
AND PD.PortfolioId IS NULL
AND PD.AccountId IS NULL
AND PD.SafeDepositId IS NULL
UNION
SELECT PA.Id As AccountId,
       RightCumulation =
       CASE 
         WHEN ((PR.HasRight = 1) AND ((PR.IsCollective = 0) OR (@ExclCollectiveFlag = 0))) THEN 10
         ELSE 20
       END
FROM PtAccountBase As PA
JOIN PtPortfolio As PP ON PA.PortfolioId = PP.Id
JOIN PtRelationMaster As RM ON PP.PartnerId = RM.PartnerId
JOIN PtRelationSlave As RS ON RM.Id = RS.MasterId
JOIN PtProxyDetail As PD ON RS.Id = PD.RelationSlaveId
JOIN PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
WHERE RM.HdVersionNo BETWEEN 1 AND 999999998
AND RS.HdVersionNo BETWEEN 1 AND 999999998
AND PD.HdVersionNo BETWEEN 1 AND 999999998
AND PP.HdVersionNo BETWEEN 1 AND 999999998
AND PA.HdVersionNo BETWEEN 1 AND 999999998
AND RM.RelationTypeNo = @RelationTypeNo
AND (((@ContactPersonFlag = 'P') AND (RS.PartnerId = @PartnerId))
OR   ((@ContactPersonFlag = 'C') AND (RS.ContactPersonId = @PartnerId)))
AND (RS.ValidFrom IS NOT NULL)
AND (RS.ValidFrom <= @PerDate)
AND (RS.ValidTo IS NULL OR RS.ValidTo >= @PerDate)
AND (PD.ValidFrom IS NOT NULL)
AND (PD.ValidFrom <= @PerDate)
AND (PD.ValidTo IS NULL OR PD.ValidTo >= @PerDate)
AND PD.PortfolioId IS NOT NULL
AND PD.AccountId IS NULL
AND PD.SafeDepositId IS NULL
AND PP.Id = PD.PortfolioId
UNION
SELECT PA.Id As AccountId,
       RightCumulation =
       CASE 
         WHEN ((PR.HasRight = 1) AND ((PR.IsCollective = 0) OR (@ExclCollectiveFlag = 0))) THEN 1
         ELSE 2
       END
FROM PtAccountBase As PA
JOIN PtPortfolio As PP ON PA.PortfolioId = PP.Id
JOIN PtRelationMaster As RM ON PP.PartnerId = RM.PartnerId
JOIN PtRelationSlave As RS ON RM.Id = RS.MasterId
JOIN PtProxyDetail As PD ON RS.Id = PD.RelationSlaveId
JOIN PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
WHERE RM.HdVersionNo BETWEEN 1 AND 999999998
AND RS.HdVersionNo BETWEEN 1 AND 999999998
AND PD.HdVersionNo BETWEEN 1 AND 999999998
AND PP.HdVersionNo BETWEEN 1 AND 999999998
AND PA.HdVersionNo BETWEEN 1 AND 999999998
AND RM.RelationTypeNo = @RelationTypeNo
AND (((@ContactPersonFlag = 'P') AND (RS.PartnerId = @PartnerId))
OR   ((@ContactPersonFlag = 'C') AND (RS.ContactPersonId = @PartnerId)))
AND (RS.ValidFrom IS NOT NULL)
AND (RS.ValidFrom <= @PerDate)
AND (RS.ValidTo IS NULL OR RS.ValidTo >= @PerDate)
AND (PD.ValidFrom IS NOT NULL)
AND (PD.ValidFrom <= @PerDate)
AND (PD.ValidTo IS NULL OR PD.ValidTo >= @PerDate)
AND PD.AccountId IS NOT NULL
AND PD.SafeDepositId IS NULL
AND PA.Id = PD.AccountId) As MP
group by MP.AccountId) As A
WHERE ((LEN(A.Rights) = 1) AND
       (A.Rights = '1'))
OR   ((LEN(A.Rights) = 2) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10')))
OR   ((LEN(A.Rights) = 3) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10') OR
      (RIGHT(A.Rights,3) = '100')))
OR   ((LEN(A.Rights) = 4) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10') OR
      (RIGHT(A.Rights,3) = '100') OR (RIGHT(A.Rights,4) = '1000')))
)

