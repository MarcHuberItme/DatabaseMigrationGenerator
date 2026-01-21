--liquibase formatted sql

--changeset system:create-alter-view-PtCorrPortfolioView context:any labels:c-any,o-view,ot-schema,on-PtCorrPortfolioView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrPortfolioView
CREATE OR ALTER VIEW dbo.PtCorrPortfolioView AS

SELECT TOP 100 PERCENT

	PortfolioId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, CorrItemId, IsPrimaryCorrAddress, SUM(CopyNumber) AS CopyNumber

FROM (
	SELECT 
		Pf.PortfolioId, 
		Pf.AddressId AS AddressId, 
		Pf.AttentionOf AS AttentionOf,
		Pf.CarrierTypeNo AS CarrierTypeNo, 
		Pf.DeliveryRuleNo AS DeliveryRuleNo,
		Pf.DetourGroup AS DetourGroup,
		Pf.IsPrimaryCorrAddress,
		PfItem.CopyNumber AS CopyNumber,
		V1.CorrItemId As CorrItemId
	FROM PtCorrPortfolio AS Pf
	INNER JOIN PtCorrPortfolioItemGroup AS PfItem ON PfItem.CorrPortfolioId = Pf.Id AND PfItem.CopyNumber > 0 AND (PfItem.HdVersionNo BETWEEN 1 AND 999999998)
	INNER JOIN AsCorrItemAssign AS V1 ON PfItem.CorrItemGroupNo = V1.CorrItemGroupNo AND (V1.HdVersionNo BETWEEN 1 AND 999999998)
	WHERE (Pf.HdVersionNo BETWEEN 1 AND 999999998)

	UNION ALL

		SELECT 
			Pf.PortfolioId, 
			Pt.AddressId AS AddressId, 
			Pt.AttentionOf AS AttentionOf,
			Pt.CarrierTypeNo AS CarrierTypeNo, 
			Pt.DeliveryRuleNo AS DeliveryRuleNo,
			Pt.DetourGroup AS DetourGroup,
			Pt.IsPrimaryCorrAddress,
			PtItem.CopyNumber AS CopyNumber,
			V1.CorrItemId As CorrItemId
		FROM PtCorrPortfolio AS Pf
		INNER JOIN PtCorrPartner AS Pt ON Pt.PartnerId = Pf.PartnerIdCorr AND (Pt.HdVersionNo BETWEEN 1 AND 999999998)
		INNER JOIN PtCorrPartnerItemGroup AS PtItem ON PtItem.CorrPartnerId = Pt.Id AND PtItem.CopyNumber > 0 AND (PtItem.HdVersionNo BETWEEN 1 AND 999999998)
		INNER JOIN AsCorrItemAssign AS V1 ON PtItem.CorrItemGroupNo = V1.CorrItemGroupNo AND (V1.HdVersionNo BETWEEN 1 AND 999999998) 
		WHERE (Pf.HdVersionNo BETWEEN 1 AND 999999998)

) AS Cor

GROUP BY PortfolioId,AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, CorrItemId, IsPrimaryCorrAddress
