--liquibase formatted sql

--changeset system:create-alter-view-EvBaseCorrPortfolioView context:any labels:c-any,o-view,ot-schema,on-EvBaseCorrPortfolioView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvBaseCorrPortfolioView
CREATE OR ALTER VIEW dbo.EvBaseCorrPortfolioView AS
SELECT	CPV.PortfolioId, CPV.AddressId, CPV.AttentionOf, 
	CarrierTypeNo = CASE EVB.MailControlTypeNo
		WHEN 2 THEN CASE CPV.CarrierTypeNo 
			WHEN 2 THEN 1
			WHEN 12 THEN 14
			WHEN 21 THEN 1
			ELSE CPV.CarrierTypeNo
			END
		WHEN 3 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN 14
			ELSE CPV.CarrierTypeNo
			END
		WHEN 11 THEN CASE CPV.CarrierTypeNo 
			WHEN 2 THEN 1
			WHEN 12 THEN 14
			WHEN 20 THEN 1
			WHEN 21 THEN 1
			ELSE CPV.CarrierTypeNo
			END
		WHEN 12 THEN 23
	 	ELSE CPV.CarrierTypeNo
		END, 
	DeliveryRuleNo = CASE EVB.MailControlTypeNo
		WHEN 2 THEN 9400
		WHEN 3 THEN 9400
		WHEN 11 THEN 9400
	 	ELSE CPV.DeliveryRuleNo
		END,
	DetourGroup = CASE EVB.MailControlTypeNo
		WHEN 2 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN EVB.DetourGroup
			ELSE CPV.DetourGroup
		END
		WHEN 3 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN EVB.DetourGroup
			ELSE CPV.DetourGroup
			END
		WHEN 11 THEN EVB.DetourGroup
	 	ELSE CPV.DetourGroup
		END, 
	DetourGroupOld = CASE EVB.MailControlTypeNo
		WHEN 2 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN 'Bleibepost'
			ELSE NULL
		END
		WHEN 3 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN 'Bleibepost'
			ELSE NULL
			END
		WHEN 11 THEN CASE CPV.CarrierTypeNo 
			WHEN 12 THEN 'Bleibepost'
			ELSE CPV.DetourGroup
			END
	 	ELSE NULL
		END, 
	CPV.CorrItemId, CPV.IsPrimaryCorrAddress, CPV.CopyNumber, CPV.CorrLanguageNo,
	EVB.ID AS EventId, ESP.Id AS SelectionPosId
FROM	EvBase EVB
JOIN	EvSelection SEL ON SEL.EventId = EVB.Id
JOIN	EvSelectionPos ESP ON ESP.EventSelectionId = SEL.Id
JOIN	PtPosition POS ON POS.Id = ESP.PositionId
JOIN	PtCorrPortfolioViewLang CPV ON CPV.PortfolioId = POS.PortfolioId
