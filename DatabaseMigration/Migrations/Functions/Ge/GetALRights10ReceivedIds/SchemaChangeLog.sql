--liquibase formatted sql

--changeset system:create-alter-function-GetALRights10ReceivedIds context:any labels:c-any,o-function,ot-schema,on-GetALRights10ReceivedIds,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetALRights10ReceivedIds
CREATE OR ALTER FUNCTION dbo.GetALRights10ReceivedIds
(
@PartnerId uniqueidentifier
)
RETURNS TABLE
AS
RETURN (
SELECT PA.Id
FROM   PtAccountBase PA
JOIN   PtPortfolio PP ON PA.PortfolioId = PP.Id
JOIN   PtBase PB ON PP.PartnerId = PB.Id
JOIN   PtRelationMaster PRM ON PB.Id = PRM.PartnerId
JOIN   PtRelationSlave PRS ON PRM.Id = PRS.MasterId
WHERE  PRS.PartnerId = @PartnerId
AND    PRM.RelationTypeNo = 10
AND    PRM.HdVersionNo BETWEEN 1 AND 999999998
AND    PRS.HdVersionNo BETWEEN 1 AND 999999998
AND    PB.HdVersionNo BETWEEN 1 AND 999999998
AND    PP.HdVersionNo BETWEEN 1 AND 999999998
AND    PA.HdVersionNo BETWEEN 1 AND 999999998
)
