--liquibase formatted sql

--changeset system:create-alter-view-ReBuildingView context:any labels:c-any,o-view,ot-schema,on-ReBuildingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReBuildingView
CREATE OR ALTER VIEW dbo.ReBuildingView AS
SELECT TOP 100 PERCENT
	ReBd.Id,
	ReBd.HdCreateDate, 
	ReBd.HdEditStamp,
	ReBd.HdStatusFlag, 
	ReBd.HdPendingChanges, 
	ReBd.HdPendingSubChanges, 
	ReBd.HdVersionNo,
	ReBd.HdProcessId,
	ReBd.BuildingTypeNo,
	ReBd.BuildingStyleNo,
	ReBd.YearOfConstruction,
	ReBd.YearOfTotalChange,
	ReBd.InsuranceNo,
	ReBd.AreaM2,
	ReBd.VolumeM3,
	ReBd.VolumeTypeId,
	ReBd.RentAmountDate,
	ReBd.RentAmount,
	ReBd.EmptyAmount,
	ReBd.SupportAmount,
	ReBd.AddExpAmount,
	ReBd.RentRateBusiness,
	ReBd.RentRateOwn,
	RePR.Id AS PRId
FROM ReBuilding As ReBd
INNER JOIN RePremises AS ReP ON ReBd.PremisesId = ReP.Id
INNER JOIN ReBase AS ReB ON ReP.ReBaseId = ReB.Id
INNER JOIN RePledgeRegister AS RePR ON ReB.Id = RePR.ReBaseId

