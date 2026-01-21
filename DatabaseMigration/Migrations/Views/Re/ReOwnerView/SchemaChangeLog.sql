--liquibase formatted sql

--changeset system:create-alter-view-ReOwnerView context:any labels:c-any,o-view,ot-schema,on-ReOwnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReOwnerView
CREATE OR ALTER VIEW dbo.ReOwnerView AS
(SELECT TOP 100 PERCENT
	RO.Id,
	RO.HdCreateDate, 
	RO.HdCreator, 
	RO.HdChangeDate, 
	RO.HdChangeUser, 
	RO.HdEditStamp,
	RO.HdVersionNo,
	RO.HdProcessId,
	RO.HdStatusFlag, 
	RO.HdNoUpdateFlag, 
	RO.HdPendingChanges, 
	RO.HdPendingSubChanges, 
	RO.HdTriggerControl, 
	RO.ReBaseId,
	RO.PartnerRelId,
	RO.PropertyTypeNo,
	RO.Number,
	RO.Denominator,
	RO.UnitTypeNo,
	RB.PartnerId,
                NULL As PartnerNo,
	RB.Name,
	RB.FirstName,
                RB.ValidFrom,
                RB.ValidTo,
                RB.ValidPer
FROM ReOwner As RO
LEFT JOIN ReBasePtRel As RB ON RB.Id = RO.PartnerRelId AND RB.HdVersionNo < 999999999
WHERE RB.PartnerId IS NULL)
UNION
(SELECT TOP 100 PERCENT
	RO.Id,
	RO.HdCreateDate, 
	RO.HdCreator, 
	RO.HdChangeDate, 
	RO.HdChangeUser, 
	RO.HdEditStamp,
	RO.HdVersionNo,
	RO.HdProcessId,
	RO.HdStatusFlag, 
	RO.HdNoUpdateFlag, 
	RO.HdPendingChanges, 
	RO.HdPendingSubChanges, 
	RO.HdTriggerControl, 
	RO.ReBaseId,
	RO.PartnerRelId,
	RO.PropertyTypeNo,
	RO.Number,
	RO.Denominator,
	RO.UnitTypeNo,
	RB.PartnerId,
	PD.PartnerNo,
	PD.Name,
	PD.FirstName,
                RB.ValidFrom,
                RB.ValidTo,
                RB.ValidPer
FROM ReOwner As RO
LEFT JOIN ReBasePtRel As RB ON RB.Id = RO.PartnerRelId  AND RB.HdVersionNo < 999999999
LEFT OUTER JOIN PtDescriptionView As PD ON RB.PartnerId =  PD.Id  AND PD.HdVersionNo < 999999999
WHERE RB.PartnerId IS NOT NULL)

