--liquibase formatted sql

--changeset system:create-alter-view-PtOwnBondCfFrontDeskAdviceView context:any labels:c-any,o-view,ot-schema,on-PtOwnBondCfFrontDeskAdviceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOwnBondCfFrontDeskAdviceView
CREATE OR ALTER VIEW dbo.PtOwnBondCfFrontDeskAdviceView AS
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
E.TransactionId AS TransId,
E.NetAmount AS TotalAmount,
Trans.TransDate,
Pt.PartnerNoEdited,
Pt.Id AS PartnerId,
Pt.PartnerNo,
Pc.BranchNo,
'' AS TextShort,
Pf.PortfolioNo,
Pf.PortfolioNoEdited,
E.PortfolioId

FROM PtOwnBondCfFrontDesk AS E
INNER JOIN PtTransaction AS Trans ON E.TransactionId = Trans.Id
INNER JOIN PtBase AS Pt ON E.PartnerId = Pt.Id
INNER JOIN PtOwnBondTransCorr AS Corr ON E.Id = Corr.SourceRecordId
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo
LEFT OUTER JOIN PtPortfolio AS Pf ON E.PortfolioId = Pf.Id
LEFT OUTER JOIN PtAddress AS Adr ON Corr.AddressId = Adr.Id
WHERE Corr.HdVersionNo BETWEEN 1 AND 999999998 AND
E.HdVersionNo BETWEEN 1 AND 999999998
AND Corr.SourceTableName = 'PtOwnBondCfFrontDesk'
