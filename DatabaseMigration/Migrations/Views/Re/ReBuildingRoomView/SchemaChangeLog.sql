--liquibase formatted sql

--changeset system:create-alter-view-ReBuildingRoomView context:any labels:c-any,o-view,ot-schema,on-ReBuildingRoomView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReBuildingRoomView
CREATE OR ALTER VIEW dbo.ReBuildingRoomView AS
SELECT 	RBR.Id,
	RBR.HdCreateDate, 
	RBR.HdEditStamp,
	RBR.HdStatusFlag, 
	RBR.HdPendingChanges, 
	RBR.HdPendingSubChanges, 
	RBR.HdVersionNo,
	RBR.HdProcessId,
	RBR.BuildingId,
	RBR.DwellingId,
	RBR.FloorType,
	RBR.RoomType,
	RBR.IsRented,
	RBR.RentPartnerRelId,
	RPR.PartnerId,
	RPR.Name,
	RPR.FirstName,
	RBR.SeatNo,
	RBR.AreaM2,
	RBR.RoomNo,
	RBR.IsTrade,
	RBR.IsLiving,
	RBR.IsSecondary,
	RFT.SortNo As SortNoFloorType,
	RRT.SortNo As SortNoRoomType
FROM ReBuildingRoom As RBR
LEFT OUTER JOIN ReBuildingFloorType As RFT ON RBR.FloorType = RFT.FloorType
LEFT OUTER JOIN ReRoomType As RRT ON RBR.RoomType = RRT.RoomType
LEFT OUTER JOIN RePremisesPtRel As RPR ON RBR.RentPartnerRelId = RPR.Id

