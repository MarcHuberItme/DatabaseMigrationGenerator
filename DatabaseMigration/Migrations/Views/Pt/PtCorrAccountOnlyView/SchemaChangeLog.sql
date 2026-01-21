--liquibase formatted sql

--changeset system:create-alter-view-PtCorrAccountOnlyView context:any labels:c-any,o-view,ot-schema,on-PtCorrAccountOnlyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrAccountOnlyView
CREATE OR ALTER VIEW dbo.PtCorrAccountOnlyView AS
SELECT TOP 100 PERCENT
	 AccountId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, CorrItemId, IsPrimaryCorrAddress, SUM(CopyNumber) AS CopyNumber

FROM (
	SELECT 
		A.AccountId, 
		A.AddressId AS AddressId, 
		A.AttentionOf AS AttentionOf,
		A.CarrierTypeNo AS CarrierTypeNo, 
		A.DeliveryRuleNo AS DeliveryRuleNo,
		A.DetourGroup AS DetourGroup,
		A.IsPrimaryCorrAddress,
		AItem.CopyNumber AS CopyNumber,
		V1.CorrItemId As CorrItemId
	FROM PtCorrAccount AS A
	INNER JOIN PtCorrAccountItemGroup AS AItem ON A.Id = AItem.CorrAccountId AND AItem.CopyNumber > 0 AND (AItem.HdVersionNo BETWEEN 1 AND 999999998)
	INNER JOIN AsCorrItemAssign AS V1 ON AItem.CorrItemGroupNo = V1.CorrItemGroupNo AND (V1.HdVersionNo BETWEEN 1 AND 999999998)
	WHERE (A.HdVersionNo BETWEEN 1 AND 999999998)

) AS Cor

GROUP BY AccountId,AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, CorrItemId, IsPrimaryCorrAddress
