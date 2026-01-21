--liquibase formatted sql

--changeset system:create-alter-procedure-GetInvoiceCorrInfoPortfolio context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInvoiceCorrInfoPortfolio,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInvoiceCorrInfoPortfolio
CREATE OR ALTER PROCEDURE dbo.GetInvoiceCorrInfoPortfolio

@PortfolioId uniqueidentifier

AS

SELECT PortfolioId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, IsPrimaryCorrAddress, ReceiverPartnerId

FROM (
	SELECT 
		Pf.PortfolioId, 
		Pf.AddressId AS AddressId, 
		Pf.AttentionOf AS AttentionOf,
		Pf.CarrierTypeNo AS CarrierTypeNo, 
		Pf.DeliveryRuleNo AS DeliveryRuleNo,
		Pf.DetourGroup AS DetourGroup,
		Pf.IsPrimaryCorrAddress,
		Adr.PartnerId AS ReceiverPartnerId
	FROM PtCorrPortfolio AS Pf
	INNER JOIN PtAddress AS Adr ON Pf.AddressId = Adr.Id
	WHERE Pf.PortfolioId = @PortfolioId
	AND (Pf.HdVersionNo BETWEEN 1 AND 999999998)

	UNION ALL

		SELECT 
			Pf.PortfolioId, 
			Pt.AddressId AS AddressId, 
			Pt.AttentionOf AS AttentionOf,
			Pt.CarrierTypeNo AS CarrierTypeNo, 
			Pt.DeliveryRuleNo AS DeliveryRuleNo,
			Pt.DetourGroup AS DetourGroup,
			Pt.IsPrimaryCorrAddress,
			Adr.PartnerId AS ReceiverPartnerId
		FROM PtCorrPortfolio AS Pf
		INNER JOIN PtCorrPartner AS Pt ON Pt.PartnerId = Pf.PartnerIdCorr AND (Pt.HdVersionNo BETWEEN 1 AND 999999998)
		INNER JOIN PtAddress AS Adr ON Pt.AddressId = Adr.Id
		WHERE Pf.PortfolioId = @PortfolioId
		AND (Pf.HdVersionNo BETWEEN 1 AND 999999998)

) AS Cor

GROUP BY PortfolioId,AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, IsPrimaryCorrAddress, ReceiverPartnerId
ORDER BY IsPrimaryCorrAddress DESC, CarrierTypeNo ASC
