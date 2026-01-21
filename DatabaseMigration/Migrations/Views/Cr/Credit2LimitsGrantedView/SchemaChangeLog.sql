--liquibase formatted sql

--changeset system:create-alter-view-Credit2LimitsGrantedView context:any labels:c-any,o-view,ot-schema,on-Credit2LimitsGrantedView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view Credit2LimitsGrantedView
CREATE OR ALTER VIEW dbo.Credit2LimitsGrantedView AS
SELECT  CB.CollType, CB.Collsubtype, CB.Bvalue, CB.CollNo, POS.Id AS PosId
FROM    CoBase CB
JOIN    PtAccountBase PAB ON PAB.Id = CB.AccountId
JOIN    PrReference REF on REF.AccountId = PAB.Id
JOIN    PtPosition POS ON POS.ProdReferenceId = REF.Id
WHERE   CB.CollType = 1000
AND     CB.Collsubtype = 1000
AND     CB.Inactflag = 0
AND     CB.HdVersionNo BETWEEN 1 AND 999999998
UNION ALL
SELECT  CB.CollType, CB.Collsubtype, CB.Bvalue, CB.CollNo, POS.Id As PosId
FROM    CoBase CB
JOIN    PtPortfolio PF on PF.Id = CB.PortfolioId
JOIN    PtPosition POS on POS.PortfolioId = PF.Id
WHERE   CB.CollType = 2000
AND     CB.Inactflag = 0
AND     CB.HdVersionNo BETWEEN 1 AND 999999998
