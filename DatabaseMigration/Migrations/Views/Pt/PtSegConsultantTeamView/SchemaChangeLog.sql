--liquibase formatted sql

--changeset system:create-alter-view-PtSegConsultantTeamView context:any labels:c-any,o-view,ot-schema,on-PtSegConsultantTeamView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSegConsultantTeamView
CREATE OR ALTER VIEW dbo.PtSegConsultantTeamView AS
SELECT P.Id, 
	P.PartnerNo,
	P.SegmentNo,
	P.ConsultantTeamName,
	P.HdCreateDate,
	P.HdCreator,
	P.HdChangeDate,
	P.HdChangeUser,	
	P.HdEditStamp,
	P.HdVersionNo,
	P.HdProcessId,
	P.HdStatusFlag, 
	P.HdNoUpdateFlag,
	P.HdPendingChanges, 
	P.HdPendingSubChanges,
	P.HdTriggerControl,
	A.FullAddress
FROM PtBase AS P
LEFT OUTER JOIN PtAddress AS A
	ON P.Id = A.PartnerId
	AND A.AddressTypeNo = 11

