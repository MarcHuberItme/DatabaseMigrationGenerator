--liquibase formatted sql

--changeset system:create-alter-procedure-GetInvoiceCorrInfoAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInvoiceCorrInfoAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInvoiceCorrInfoAccount
CREATE OR ALTER PROCEDURE dbo.GetInvoiceCorrInfoAccount

@AccountId uniqueidentifier

AS

SELECT AccountId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, IsPrimaryCorrAddress, ReceiverPartnerId
FROM (
	SELECT 
		A.AccountId, 
		A.AddressId AS AddressId, 
		A.AttentionOf AS AttentionOf,
		A.CarrierTypeNo AS CarrierTypeNo, 
		A.DeliveryRuleNo AS DeliveryRuleNo,
		A.DetourGroup AS DetourGroup,
		A.IsPrimaryCorrAddress,
		Adr.PartnerId AS ReceiverPartnerId
	FROM PtCorrAccount AS A
	INNER JOIN PtAddress AS Adr ON A.AddressId = Adr.Id
	WHERE A.AccountId = @AccountId 
	AND (A.HdVersionNo BETWEEN 1 AND 999999998)

	UNION ALL

		SELECT 
			A.AccountId, 
			Pf.AddressId AS AddressId, 
			Pf.AttentionOf AS AttentionOf,
			Pf.CarrierTypeNo AS CarrierTypeNo, 
			Pf.DeliveryRuleNo AS DeliveryRuleNo,
			Pf.DetourGroup AS DetourGroup,
			Pf.IsPrimaryCorrAddress,
			Adr.PartnerId AS ReceiverPartnerId
		FROM PtCorrAccount AS A
		INNER JOIN PtCorrPortfolio AS Pf ON Pf.PortfolioId = A.PortfolioIdCorr AND (Pf.HdVersionNo BETWEEN 1 AND 999999998)
		INNER JOIN PtAddress AS Adr ON Pf.AddressId = Adr.Id
		WHERE A.AccountId = @AccountId 
		AND (A.HdVersionNo BETWEEN 1 AND 999999998)

		UNION ALL

			SELECT 
				A.AccountId, 
				Pt.AddressId AS AddressId, 
				Pt.AttentionOf AS AttentionOf,
				Pt.CarrierTypeNo AS CarrierTypeNo, 
				Pt.DeliveryRuleNo AS DeliveryRuleNo,
				Pt.DetourGroup AS DetourGroup,
				Pt.IsPrimaryCorrAddress,
				Adr.PartnerId AS ReceiverPartnerId
			FROM PtCorrAccount AS A
			INNER JOIN PtCorrPortfolio AS Pf ON Pf.PortfolioId = A.PortfolioIdCorr AND (Pf.HdVersionNo BETWEEN 1 AND 999999998)
			INNER JOIN PtCorrPartner AS Pt ON Pt.PartnerId = Pf.PartnerIdCorr AND (Pt.HdVersionNo BETWEEN 1 AND 999999998)
			INNER JOIN PtAddress AS Adr ON Pt.AddressId = Adr.Id

			WHERE A.AccountId = @AccountId 
			AND (A.HdVersionNo BETWEEN 1 AND 999999998)

) AS Cor

GROUP BY AccountId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, IsPrimaryCorrAddress, ReceiverPartnerId
ORDER BY IsPrimaryCorrAddress DESC, CarrierTypeNo ASC
