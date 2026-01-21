--liquibase formatted sql

--changeset system:create-alter-view-RePartnerRelView context:any labels:c-any,o-view,ot-schema,on-RePartnerRelView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePartnerRelView
CREATE OR ALTER VIEW dbo.RePartnerRelView AS
(SELECT TOP 100 PERCENT
	RP.Id,
	RP.HdCreateDate, 
	RP.HdCreator, 
	RP.HdChangeDate, 
	RP.HdChangeUser, 
	RP.HdEditStamp,
	RP.HdVersionNo,
	RP.HdProcessId,
	RP.HdStatusFlag, 
	RP.HdNoUpdateFlag, 
	RP.HdPendingChanges, 
	RP.HdPendingSubChanges, 
	RP.HdTriggerControl, 
	RP.ReBaseId,
	RP.PremisesId,
	RP.BuildingId,
	RP.PremisesPtRelTypeNo,
	RP.PartnerId,
                NULL As PartnerNo,
	RP.Name,
	RP.FirstName,
	RP.DateOfBirth,
	RP.SexStatusNo,
	RP.Street,
	RP.HouseNo,
	RP.Zip,
	RP.Town,
	RP.CountryCode,
                RP.ValidFrom,
                RP.ValidTo,
                RP.ValidPer
FROM     RePremisesPtRel As RP
WHERE  RP.HdVersionNo < 999999999
AND        RP.PartnerId IS NULL)
UNION
(SELECT TOP 100 PERCENT
	RP.Id,
	RP.HdCreateDate, 
	RP.HdCreator, 
	RP.HdChangeDate, 
	RP.HdChangeUser, 
	RP.HdEditStamp,
	RP.HdVersionNo,
	RP.HdProcessId,
	RP.HdStatusFlag, 
	RP.HdNoUpdateFlag, 
	RP.HdPendingChanges, 
	RP.HdPendingSubChanges, 
	RP.HdTriggerControl, 
	RP.ReBaseId,
	RP.PremisesId,
	RP.BuildingId,
	RP.PremisesPtRelTypeNo,
	RP.PartnerId,
	PD.PartnerNo,
	PD.Name,
	PD.FirstName,
	PD.DateOfBirth,
	PD.SexStatusNo,
	PD.Street,
	PD.HouseNo,
	PD.Zip,
	PD.Town,
	PD.CountryCode,
                RP.ValidFrom,
                RP.ValidTo,
                RP.ValidPer
FROM     RePremisesPtRel As RP
LEFT OUTER JOIN PtDescriptionView As PD ON RP.PartnerId =  PD.Id  AND PD.HdVersionNo < 999999999
WHERE  RP.HdVersionNo < 999999999
AND        RP.PartnerId IS NOT NULL)

