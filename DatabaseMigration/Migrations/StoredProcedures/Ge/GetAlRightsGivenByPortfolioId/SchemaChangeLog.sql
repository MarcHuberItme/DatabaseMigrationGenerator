--liquibase formatted sql

--changeset system:create-alter-procedure-GetAlRightsGivenByPortfolioId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAlRightsGivenByPortfolioId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAlRightsGivenByPortfolioId
CREATE OR ALTER PROCEDURE dbo.GetAlRightsGivenByPortfolioId
@PortfolioId uniqueidentifier,
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo integer

As

DECLARE @PartnerId UniqueIdentifier

SET @PartnerId =
(SELECT PP.PartnerId
FROM    PtPortfolio PP
WHERE   PP.Id = @PortfolioId
AND     PP.HdVersionNo BETWEEN 1 AND 999999998)

SELECT * FROM GetALRightsGivenIds (@PartnerId, @ExclCollectiveFlag, @PerDate, @RelationTypeNo) AS G
WHERE G.PortfolioId = @PortfolioId

