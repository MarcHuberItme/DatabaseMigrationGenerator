--liquibase formatted sql

--changeset system:create-alter-view-PtCorrPartnerView context:any labels:c-any,o-view,ot-schema,on-PtCorrPartnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrPartnerView
CREATE OR ALTER VIEW dbo.PtCorrPartnerView AS

SELECT TOP 100 PERCENT 

	Pt.PartnerId, 
	Pt.AddressId, 
	Pt.AttentionOf,
	Pt.CarrierTypeNo, 
	Pt.DeliveryRuleNo,
	Pt.DetourGroup,
	Pt.IsPrimaryCorrAddress,
	SUM(PtItem.CopyNumber) AS CopyNumber,
	V3.CorrItemId

FROM  PtCorrPartner AS Pt

	INNER JOIN PtCorrPartnerItemGroup AS PtItem ON Pt.Id = PtItem.CorrPartnerId AND PtItem.CopyNumber > 0 AND (PtItem.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN AsCorrItemAssign AS V3 ON PtItem.CorrItemGroupNo = V3.CorrItemGroupNo AND (V3.HdVersionNo BETWEEN 1 AND 999999998)
 
WHERE (Pt.HdVersionNo BETWEEN 1 AND 999999998) 
      
GROUP BY Pt.PartnerId, Pt.AddressId, Pt.AttentionOf, Pt.CarrierTypeNo, Pt.DeliveryRuleNo, Pt.DetourGroup, V3.CorrItemId, Pt.IsPrimaryCorrAddress
