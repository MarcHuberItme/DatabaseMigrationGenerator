--liquibase formatted sql

--changeset system:create-alter-view-PrPublicCfSetLeafView context:any labels:c-any,o-view,ot-schema,on-PrPublicCfSetLeafView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicCfSetLeafView
CREATE OR ALTER VIEW dbo.PrPublicCfSetLeafView AS
SELECT	S1.PublicId, S1.Id AS CfRootSetId, C2.PublicCfId
FROM	PrPublicCfSet S1
JOIN	PrPublicCfComp C2 ON S1.Id = C2.PublicCfParentSetId 
WHERE	C2.PublicCfId is not NULL
UNION
SELECT	S1.PublicId, S1.Id AS CfRootSetId, C3.PublicCfId
FROM	PrPublicCfSet  S1
JOIN	PrPublicCfComp C2 ON S1.Id = C2.PublicCfParentSetId 
JOIN	PrPublicCfSet  S2 ON S2.Id = C2.PublicCfSetId 
JOIN	PrPublicCfComp C3 ON S2.Id = C3.PublicCfParentSetId 
WHERE	C3.PublicCfId is not NULL
UNION
SELECT	S1.PublicId, S1.Id AS CfRootSetId, C4.PublicCfId
FROM	PrPublicCfSet  S1
JOIN	PrPublicCfComp C2 ON S1.Id = C2.PublicCfParentSetId 
JOIN	PrPublicCfSet  S2 ON S2.Id = C2.PublicCfSetId 
JOIN	PrPublicCfComp C3 ON S2.Id = C3.PublicCfParentSetId 
JOIN	PrPublicCfSet  S3 ON S3.Id = C3.PublicCfSetId 
JOIN	PrPublicCfComp C4 ON S3.Id = C4.PublicCfParentSetId 
WHERE	C4.PublicCfId is not NULL
UNION
SELECT	S1.PublicId, S1.Id AS CfRootSetId, C5.PublicCfId
FROM	PrPublicCfSet S1
JOIN	PrPublicCfComp C2 ON S1.Id = C2.PublicCfParentSetId 
JOIN	PrPublicCfSet  S2 ON S2.Id = C2.PublicCfSetId 
JOIN	PrPublicCfComp C3 ON S2.Id = C3.PublicCfParentSetId 
JOIN	PrPublicCfSet  S3 ON S3.Id = C3.PublicCfSetId 
JOIN	PrPublicCfComp C4 ON S3.Id = C4.PublicCfParentSetId 
JOIN	PrPublicCfSet  S4 ON S4.Id = C4.PublicCfSetId 
JOIN	PrPublicCfComp C5 ON S4.Id = C5.PublicCfParentSetId 
WHERE	C5.PublicCfId is not NULL
UNION
SELECT	S1.PublicId, S1.Id AS CfRootSetId, C6.PublicCfId
FROM	PrPublicCfSet S1
JOIN	PrPublicCfComp C2 ON S1.Id = C2.PublicCfParentSetId 
JOIN	PrPublicCfSet  S2 ON S2.Id = C2.PublicCfSetId 
JOIN	PrPublicCfComp C3 ON S2.Id = C3.PublicCfParentSetId 
JOIN	PrPublicCfSet  S3 ON S3.Id = C3.PublicCfSetId 
JOIN	PrPublicCfComp C4 ON S3.Id = C4.PublicCfParentSetId 
JOIN	PrPublicCfSet  S4 ON S4.Id = C4.PublicCfSetId 
JOIN	PrPublicCfComp C5 ON S4.Id = C5.PublicCfParentSetId 
JOIN	PrPublicCfSet  S5 ON S5.Id = C5.PublicCfSetId 
JOIN	PrPublicCfComp C6 ON S5.Id = C6.PublicCfParentSetId 
WHERE	C6.PublicCfId is not NULL
