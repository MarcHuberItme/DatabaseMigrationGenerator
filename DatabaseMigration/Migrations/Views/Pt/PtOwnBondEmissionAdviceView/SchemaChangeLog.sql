--liquibase formatted sql

--changeset system:create-alter-view-PtOwnBondEmissionAdviceView context:any labels:c-any,o-view,ot-schema,on-PtOwnBondEmissionAdviceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOwnBondEmissionAdviceView
CREATE OR ALTER VIEW dbo.PtOwnBondEmissionAdviceView AS
SELECT
Corr.Id AS CorrId,
Corr.AddressId,
Corr.AttentionOf,
Corr.CarrierTypeNo,
Corr.DeliveryRuleNo,
Corr.DetourGroup,
Corr.CopyNumber,
Corr.SourceTableName,
Corr.PrintDate,
Corr.ReportName,
ISNULL(Adr.CorrespondenceLanguageNo,E.LanguageNo) AS LanguageNo,
E.PortfolioId,
E.TransactionId AS TransId,
E.NetAmount AS TotalAmount,
Trans.TransDate,
Pf.PortfolioNoEdited,
Pt.Id AS PartnerId,
Pt.PartnerNo,
Pc.BranchNo,
Tx.TextLong AS TextShort

FROM PtOwnBondEmission AS E
INNER JOIN PtTransaction AS Trans ON E.TransactionId = Trans.Id
INNER JOIN PtPortfolio AS Pf ON E.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
INNER JOIN PtOwnBondTransCorr AS Corr ON E.Id = Corr.SourceRecordId
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo
INNER JOIN PtPortfolioType AS PfType ON Pf.PortfolioTypeNo = PfType.PortfolioTypeNo
LEFT OUTER JOIN AsText AS Tx ON PfType.Id = Tx.MasterId AND Tx.MasterTableName = 'PtPortfolioType' AND Tx.LanguageNo = E.LanguageNo
LEFT OUTER JOIN PtAddress AS Adr ON Corr.AddressId = Adr.Id
WHERE Corr.HdVersionNo BETWEEN 1 AND 999999998 AND
E.HdVersionNo BETWEEN 1 AND 999999998
AND Corr.SourceTableName = 'PtOwnBondEmission'
