--liquibase formatted sql

--changeset system:create-alter-view-ReDwellingView context:any labels:c-any,o-view,ot-schema,on-ReDwellingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReDwellingView
CREATE OR ALTER VIEW dbo.ReDwellingView AS

(SELECT	TOP 100 PERCENT
        RD.Id,
	RD.HdCreateDate, 
	RD.HdEditStamp,
	RD.HdStatusFlag, 
	RD.HdPendingChanges, 
	RD.HdPendingSubChanges, 
	RD.HdVersionNo,
	RD.HdProcessId,
	RD.BuildingId,
	RD.DwellingTypeNo,
	RD.FloorType,
	RD.AreaM2,
	RD.NettoFlag,
	RD.SurfaceM2,
	RD.WetCellsNo,
	RD.IsRented,
	RPR.PartnerId,
	Cast(NULL as DECIMAL(11))  As PartnerNo,
	RPR.Name,
	RPR.FirstName,
	RD.RentAmount,
	RD.EmptyAmount,
	RD.SupportAmount,
	RD.AddExpAmount,
	RD.ApartmentNo,
	RFT.SortNo As SortNoFloorType,
	RDT.SortNo As SortNoDwellingType
FROM ReDwelling As RD
LEFT OUTER JOIN ReBuildingFloorType As RFT ON RD.FloorType = RFT.FloorType
LEFT OUTER JOIN ReDwellingType As RDT ON RD.DwellingTypeNo = RDT.DwellingTypeNo
LEFT OUTER JOIN RePremisesPtRel As RPR ON RD.RentPartnerRelId = RPR.Id AND RPR.HdVersionNo < 999999999
WHERE RPR.PartnerId is NULL)
UNION
(SELECT	TOP 100 PERCENT
        RD.Id,
	RD.HdCreateDate, 
	RD.HdEditStamp,
	RD.HdStatusFlag, 
	RD.HdPendingChanges, 
	RD.HdPendingSubChanges, 
	RD.HdVersionNo,
	RD.HdProcessId,
	RD.BuildingId,
	RD.DwellingTypeNo,
	RD.FloorType,
	RD.AreaM2,
	RD.NettoFlag,
	RD.SurfaceM2,
	RD.WetCellsNo,
	RD.IsRented,
	RPR.PartnerId,
	Cast(PD.PartnerNo as DECIMAL(11)),
	PD.Name,
	PD.FirstName,
	RD.RentAmount,
	RD.EmptyAmount,
	RD.SupportAmount,
	RD.AddExpAmount,
	RD.ApartmentNo,
	RFT.SortNo As SortNoFloorType,
	RDT.SortNo As SortNoDwellingType
FROM ReDwelling As RD
LEFT OUTER JOIN ReBuildingFloorType As RFT ON RD.FloorType = RFT.FloorType
LEFT OUTER JOIN ReDwellingType As RDT ON RD.DwellingTypeNo = RDT.DwellingTypeNo
LEFT OUTER JOIN RePremisesPtRel As RPR ON RD.RentPartnerRelId = RPR.Id AND RPR.HdVersionNo < 999999999
LEFT OUTER JOIN PtDescriptionView As PD ON RPR.PartnerId =  PD.Id  AND PD.HdVersionNo < 999999999
WHERE RPR.PartnerId is NOT NULL)

