--liquibase formatted sql

--changeset system:create-alter-function-GetPFLRightsGivenIds context:any labels:c-any,o-function,ot-schema,on-GetPFLRightsGivenIds,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetPFLRightsGivenIds
CREATE OR ALTER FUNCTION dbo.GetPFLRightsGivenIds
(
@PartnerId uniqueidentifier,
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo integer
)
RETURNS TABLE
AS
RETURN (
SELECT @PartnerId as PartnerIdGiving, A.PartnerId, A.ContactPersonId, A.PortfolioId, A.Rights FROM
(SELECT MP.PartnerId, MP.ContactPersonId, MP.PortfolioId As PortfolioId, CAST(SUM(MP.RightCumulation) AS varchar(4)) As Rights FROM
(SELECT PP.Id As PortfolioId,
	PP.PartnerId As PartnerId,
        NULL As ContactPersonId,
        1000 As RightCumulation
FROM PtPortfolio As PP
WHERE PP.HdVersionNo BETWEEN 1 AND 999999998
AND PP.PartnerId = @PartnerId
AND (PP.OpeningDate IS NULL OR PP.OpeningDate <= @PerDate)
AND (PP.TerminationDate IS NULL OR PP.TerminationDate >= @PerDate)
UNION
SELECT PP.Id As PortfolioId,
       RS.PartnerId As PartnerId,
       RS.ContactPersonId As ContactPersonId,
       RightCumulation =
       CASE 
         WHEN ((PR.HasRight = 1) AND ((PR.IsCollective = 0) OR (@ExclCollectiveFlag = 0))) THEN 100
         ELSE 200
       END
FROM PtPortfolio As PP
JOIN PtRelationMaster As RM ON PP.PartnerId = RM.PartnerId
JOIN PtRelationSlave As RS ON RM.Id = RS.MasterId
JOIN PtProxyDetail As PD ON RS.Id = PD.RelationSlaveId
JOIN PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
WHERE RM.HdVersionNo BETWEEN 1 AND 999999998
AND RS.HdVersionNo BETWEEN 1 AND 999999998
AND PD.HdVersionNo BETWEEN 1 AND 999999998
AND PP.HdVersionNo BETWEEN 1 AND 999999998
AND RM.RelationTypeNo = @RelationTypeNo
AND RM.PartnerId = @PartnerId
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
SELECT PP.Id As PortfolioId,
       RS.PartnerId As PartnerId,
       RS.ContactPersonId As ContactPersonId,
       RightCumulation =
       CASE 
         WHEN ((PR.HasRight = 1) AND ((PR.IsCollective = 0) OR (@ExclCollectiveFlag = 0))) THEN 10
         ELSE 20
       END
FROM PtPortfolio As PP
JOIN PtRelationMaster As RM ON PP.PartnerId = RM.PartnerId
JOIN PtRelationSlave As RS ON RM.Id = RS.MasterId
JOIN PtProxyDetail As PD ON RS.Id = PD.RelationSlaveId
JOIN PtProxyRight As PR ON PD.ProxyRightNo = PR.ProxyRightNo
WHERE RM.HdVersionNo BETWEEN 1 AND 999999998
AND RS.HdVersionNo BETWEEN 1 AND 999999998
AND PD.HdVersionNo BETWEEN 1 AND 999999998
AND PP.HdVersionNo BETWEEN 1 AND 999999998
AND RM.RelationTypeNo = @RelationTypeNo
AND RM.PartnerId = @PartnerId
AND (RS.ValidFrom IS NOT NULL)
AND (RS.ValidFrom <= @PerDate)
AND (RS.ValidTo IS NULL OR RS.ValidTo >= @PerDate)
AND (PD.ValidFrom IS NOT NULL)
AND (PD.ValidFrom <= @PerDate)
AND (PD.ValidTo IS NULL OR PD.ValidTo >= @PerDate)
AND PD.PortfolioId IS NOT NULL
AND PD.AccountId IS NULL
AND PD.SafeDepositId IS NULL
AND PP.Id = PD.PortfolioId) As MP
group by MP.PartnerId, MP.ContactPersonId, MP.PortfolioId) As A
WHERE ((LEN(A.Rights) = 2) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10')))
OR   ((LEN(A.Rights) = 3) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10') OR
      (RIGHT(A.Rights,3) = '100')))
OR   ((LEN(A.Rights) = 4) AND
     ((RIGHT(A.Rights,1) = '1') OR (RIGHT(A.Rights,2) = '10') OR
      (RIGHT(A.Rights,3) = '100') OR (RIGHT(A.Rights,4) = '1000')))
)

