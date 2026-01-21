--liquibase formatted sql

--changeset system:create-alter-view-PrRefSpecialKeyView context:any labels:c-any,o-view,ot-schema,on-PrRefSpecialKeyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrRefSpecialKeyView
CREATE OR ALTER VIEW dbo.PrRefSpecialKeyView AS
SELECT	DISTINCT TOP 100 PERCENT
                REF.Id,
    	0 AS HdPendingChanges,
    	0 AS HdPendingSubChanges, 
    	1 AS HdVersionNo,
	ISNULL(REF.SpecialKey,'') AS SpecialKey,
	PUB.Id AS PublicId
FROM	PrReference REF 
JOIN	PrPublic PUB ON PUB.ProductId = REF.ProductId
WHERE  REF.HdVersionNo < 999999999
