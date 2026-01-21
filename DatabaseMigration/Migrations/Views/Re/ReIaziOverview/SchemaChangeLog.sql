--liquibase formatted sql

--changeset system:create-alter-view-ReIaziOverview context:any labels:c-any,o-view,ot-schema,on-ReIaziOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReIaziOverview
CREATE OR ALTER VIEW dbo.ReIaziOverview AS
Select 
RP.Id, RP.HdCreateDate, RP.HdCreator, RP.HdChangeDate, RP.HdChangeUser, RP.HdEditStamp, RP.HdVersionNo, RP.HdProcessId, RP.HdStatusFlag, RP.HdNoUpdateFlag, RP.HdPendingChanges, RP.HdPendingSubChanges, RP.HdTriggerControl, 
RB.Id as BuildingId, 
RP.Id as PremisesId,
RP.PremisesType, 
RP.GBNo, RP.GBNoAdd, RP.GBPlanNo, 
RP.Street,RP.HouseNo,RP.Zip, RP.Town,  
RB.YearOfConstruction,RB.YearOfTotalChange,
RP.AreaM2,
RB.ElevatorNo, 
RB.WetCellsNo,
RB.FloorNo, 
RB.RentAmount, 
RB.IsLuxus,
RB.RoofFloorDev,
RB.SituationWithinBuildingId,
RB.HasMultipleFloors,
RB.SeparateWC,
isNull(RB.RentRateBusiness,0)as RentRateBusiness,
ISNULL(CAST(RB.VolumeM3 AS INT), 0) AS VolumeM3,
ISNULL(CAST(RB.AreaM2 AS INTEGER), 0) AS LivingArea, 
ISNULL(CAST(RB.SurfaceM2 AS INTEGER), 0) AS SurfaceM2,  
ISNULL(CAST(RB.AreaM2Store AS INTEGER), 0) AS AreaM2Store, 
ISNULL(CAST(RB.AreaM2Education AS INTEGER), 0) AS AreaM2Education, 
ISNULL(CAST(RB.AreaM2Medical AS INTEGER), 0) AS AreaM2Medical,  
ISNULL(CAST(RB.AreaM2Office AS INTEGER), 0) AS AreaM2Office, 
ISNULL(CAST(RB.AreaM2Business AS INTEGER), 0) AS AreaM2Business,  
RB.VolumeTypeId as VolumnNorm, 
RP.SituationAllocationID as SituationInTown,
RB.QualityNo as BuildingQuality, 
RB.ConditionTypeId as BuildingCondition,
RB.MinergieStandardType as MinergieStandardType,  
RP.HasServitute,
 
RPRTB.ValidTo as BuildRightEndDate,  
ISNULL((SELECT SUM(Number) FROM ReParking RP WHERE RP.BuildingId = RB.Id AND ParkingType = 82 AND RP.HdVersionNo < 999999999), 0) 
	+ CASE WHEN RBSO.PfandRegValue = 82 OR RBSS.PfandRegValue = 82 THEN 1 ELSE 0 END AS ParkingPlaceNo,  
ISNULL((SELECT SUM(Number) FROM ReParking RP WHERE RP.BuildingId = RB.Id AND(ParkingType = 81 OR ParkingType = 4 ) AND RP.HdVersionNo < 999999999), 0)  
	+ CASE WHEN RBSO.PfandRegValue = 81 OR RBSO.PfandRegValue = 4 OR RBSS.PfandRegValue = 81 OR RBSS.PfandRegValue = 4 THEN 1 ELSE 0 END AS UndergroundNo,   
ISNULL((SELECT SUM(Number) FROM ReParking RP WHERE RP.BuildingId = RB.Id AND ParkingType = 80 AND RP.HdVersionNo < 999999999), 0)
	+ CASE WHEN RBSO.PfandRegValue = 80 OR RBSS.PfandRegValue = 80 THEN 1 ELSE 0 END AS GarageNo
,(select count(*) from ReDwelling where BuildingId = rb.id and hdversionno < 999999999) as flatNo  
--,(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 1 and hdversionno < 999999999) as flat10nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 2 and hdversionno < 999999999) as flat15nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 3 and hdversionno < 999999999) as flat20nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 4 and hdversionno < 999999999) as flat25nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 5 and hdversionno < 999999999) as flat30nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 6 and hdversionno < 999999999) as flat35nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 7 and hdversionno < 999999999) as flat40nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 8 and hdversionno < 999999999) as flat45nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 9 and hdversionno < 999999999) as flat50nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 10 and hdversionno < 999999999) as flat55nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 11 and hdversionno < 999999999) as flat60nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 12 and hdversionno < 999999999) as flat65nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and (DwellingTypeNo Between 13 AND 60) and hdversionno < 999999999) as flat70nb  ,
--(select count(*) from ReDwelling where BuildingId = rb.id and DwellingTypeNo = 61 and hdversionno < 999999999) as flatloft  
--,RVE.MarketValue, RVE.ValuationDate, RVE.Remark  
From RePremises RP  
INNER JOIN ReBuilding AS RB On RB.PremisesId = RP.Id   And RB.HdVersionNo<999999999
LEFT OUTER JOIN ReBuildingStyleOthers AS RBSO ON RB.BuildingStyleOthersNo = RBSO.BuildingStyleOthersNo AND RBSO.HdVersionNo BETWEEN 1 AND 999999998      
LEFT OUTER JOIN ReBuildingStyleSTWE AS RBSS ON RB.BuildingStyleSTWENo = RBSS.BuildingStyleSTWENo AND RBSS.HdVersionNo BETWEEN 1 AND 999999998      
Left Outer Join RePremisesRelRightToBuild AS RPRTB ON RPRTB.PremisesId = RP.Id  
--Inner Join (	SELECT PremisesId, MAX(ValuationDate) AS MaxValuationDateTime 
--				FROM ReValuationExt
--				Where ValuationExtTypeNo = 1 AND HdVersionNo < 9999999999
--				GROUP BY PremisesId 
--				) AS OMAX ON RP.Id = OMAX.PremisesId --AND RP.premisestype = 1
--Inner Join ReValuationExt AS RVE On RVE.PremisesId = OMAX.PremisesId AND RVE.ValuationDate = OMAX.MaxValuationDateTime AND RVE.HdVersionNo < 9999999999
Where RP.PremisesType in(1,2,3)
