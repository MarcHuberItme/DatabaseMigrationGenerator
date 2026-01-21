--liquibase formatted sql

--changeset system:create-alter-view-PtOwnBondTransferAdviceView context:any labels:c-any,o-view,ot-schema,on-PtOwnBondTransferAdviceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOwnBondTransferAdviceView
CREATE OR ALTER VIEW dbo.PtOwnBondTransferAdviceView AS

SELECT Obt.CorrId, Obt.AddressId, Obt.AttentionOf, Obt.CarrierTypeNo, Obt.DeliveryRuleNo,
Obt.DetourGroup,
Obt.CopyNumber,
Obt.SourceTableName,
Obt.PrintDate,
Obt.ReportName,
Obt.IsDeliveryOut, Pf.PartnerId, Pf.Id AS PortfolioId, Obt.IsPhysical, Obt.AccountRefId, 
Obt.ValueDate, Obt.TransId, Obt.LanguageNo, Obt.TotalAmount, Obt.TransDate, Obt.TransGroupNo, 
Pf.PortfolioNoEdited, Pt.PartnerNo, Obt.BranchNo, Tx.TextLong AS TextShort, Obt.HasCharges, Obt.IsConformAdvice
FROM
(
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
Corr.IsDeliveryOut,
CASE
WHEN Corr.IsDeliveryOut = Corr.IsConformAdvice THEN E.SourceIsPhysical
ELSE E.DestinationIsPhysical
END AS IsPhysical,
E.AccountRefId,
E.ValueDate,
E.TransactionId AS TransId,
ISNULL(Adr.CorrespondenceLanguageNo,E.LanguageNo) AS LanguageNo,
CASE
WHEN Corr.IsDeliveryOut = 0 AND Corr.IsConformAdvice = 0 THEN ISNULL(E.DestinationNetAmount,0)
WHEN Corr.IsDeliveryOut = 1 AND Corr.IsConformAdvice = 0 THEN ISNULL(E.SourceNetAmount,0)
WHEN Corr.IsDeliveryOut = 0 AND Corr.IsConformAdvice = 1 THEN 0
WHEN Corr.IsDeliveryOut = 1 AND Corr.IsConformAdvice = 1 THEN 0
END AS TotalAmount,
Trans.TransDate,
Trans.TransGroupNo,
Pc.BranchNo,
Corr.IsConformAdvice,
CASE
WHEN Corr.IsDeliveryOut = 0 AND Corr.IsConformAdvice = 0 THEN E.DestinationHasCharges
WHEN Corr.IsDeliveryOut = 1 AND Corr.IsConformAdvice = 0 THEN E.SourceHasCharges
ELSE CAST(0 AS BIT)
END AS HasCharges,
CASE
WHEN Corr.IsDeliveryOut = 0 AND Corr.IsConformAdvice = 0 THEN DestinationPortfolioId
WHEN Corr.IsDeliveryOut = 1 AND Corr.IsConformAdvice = 0 THEN SourcePortfolioId
WHEN Corr.IsDeliveryOut = 0 AND Corr.IsConformAdvice = 1 THEN DestinationDepositPfId
WHEN Corr.IsDeliveryOut = 1 AND Corr.IsConformAdvice = 1 THEN SourceDepositPfId
END AS PortfolioId
FROM PtOwnBondTransfer AS E
INNER JOIN PtOwnBondTransCorr AS Corr ON E.Id = Corr.SourceRecordId
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo
INNER JOIN PtTransaction AS Trans ON E.TransactionId = Trans.Id
LEFT OUTER JOIN PtAddress AS Adr ON Corr.AddressId = Adr.Id
WHERE Corr.HdVersionNo BETWEEN 1 AND 999999998 AND
E.HdVersionNo BETWEEN 1 AND 999999998
AND Corr.SourceTableName = 'PtOwnBondTransfer') AS Obt
INNER JOIN PtPortfolio AS Pf ON Obt.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
INNER JOIN PtPortfolioType AS PfType ON Pf.PortfolioTypeNo = PfType.PortfolioTypeNo
LEFT OUTER JOIN AsText AS Tx ON PfType.Id = Tx.MasterId AND Tx.MasterTableName = 'PtPortfolioType' AND Tx.LanguageNo = Obt.LanguageNo
