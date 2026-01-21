--liquibase formatted sql

--changeset system:create-alter-procedure-GetInvoiceCorrInfoPartner context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInvoiceCorrInfoPartner,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInvoiceCorrInfoPartner
CREATE OR ALTER PROCEDURE dbo.GetInvoiceCorrInfoPartner

@PartnerId uniqueidentifier

AS

SELECT Pt.PartnerId, 
	Pt.AddressId, 
	Pt.AttentionOf,
	Pt.CarrierTypeNo, 
	Pt.DeliveryRuleNo,
	Pt.DetourGroup,
	Pt.IsPrimaryCorrAddress,
	Adr.PartnerId AS ReceiverPartnerId
FROM  PtCorrPartner AS Pt
INNER JOIN PtAddress AS Adr ON Pt.AddressId = Adr.Id

WHERE Pt.PartnerId = @PartnerId AND (Pt.HdVersionNo BETWEEN 1 AND 999999998) 
      
GROUP BY Pt.PartnerId, Pt.AddressId, Pt.AttentionOf, Pt.CarrierTypeNo, Pt.DeliveryRuleNo, Pt.DetourGroup, Pt.IsPrimaryCorrAddress, Adr.PartnerId, Adr.AddressTypeNo
ORDER BY IsPrimaryCorrAddress DESC, Pt.CarrierTypeNo ASC, Adr.AddressTypeNo
