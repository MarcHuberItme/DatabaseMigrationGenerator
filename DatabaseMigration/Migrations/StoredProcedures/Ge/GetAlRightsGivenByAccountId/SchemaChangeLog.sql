--liquibase formatted sql

--changeset system:create-alter-procedure-GetAlRightsGivenByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAlRightsGivenByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAlRightsGivenByAccountId
CREATE OR ALTER PROCEDURE dbo.GetAlRightsGivenByAccountId
@AccountId uniqueidentifier,
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo Integer

As

DECLARE @PartnerId UniqueIdentifier
DECLARE @PortfolioId UniqueIdentifier

SET @PortfolioId =
(SELECT PA.PortfolioId
FROM    PtAccountBase PA
WHERE   PA.Id = @AccountId
AND     PA.HdVersionNo BETWEEN 1 AND 999999998)

SET @PartnerId =
(SELECT PP.PartnerId
FROM    PtPortfolio PP
WHERE   PP.Id = @PortfolioId
AND     PP.HdVersionNo BETWEEN 1 AND 999999998)

SELECT * FROM GetALRightsGivenIds (@PartnerId, @ExclCollectiveFlag, @PerDate, @RelationTypeNo) AS G
WHERE G.AccountId = @AccountId

