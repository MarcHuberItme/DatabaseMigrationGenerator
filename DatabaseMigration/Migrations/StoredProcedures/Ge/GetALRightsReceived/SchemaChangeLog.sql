--liquibase formatted sql

--changeset system:create-alter-procedure-GetALRightsReceived context:any labels:c-any,o-stored-procedure,ot-schema,on-GetALRightsReceived,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetALRightsReceived
CREATE OR ALTER PROCEDURE dbo.GetALRightsReceived
@PartnerId uniqueidentifier,
@ContactPersonFlag varchar(1),
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo integer

As

SELECT PB.Id As PartnerId, PB.Name, PB.FirstName, PB.NameCont, PB.PartnerNoEdited,
       PP.Id As PortfolioId, PP.PortfolioNoEdited, PP.CustomerReference As PortfolioReference,
       PA.Id As AccountId, PA.AccountNoEdited, PA.CustomerReference As AccountReference
FROM PtAccountBase As PA
JOIN PtPortfolio As PP ON PA.PortfolioId = PP.Id
JOIN PtBase As PB ON PP.PartnerId = PB.Id
WHERE PA.Id IN
(SELECT * FROM GetALRightsReceivedIds (@PartnerId, @ContactPersonFlag, @ExclCollectiveFlag, @PerDate, @RelationTypeNo))

