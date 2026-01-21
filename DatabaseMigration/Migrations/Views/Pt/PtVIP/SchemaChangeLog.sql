--liquibase formatted sql

--changeset system:create-alter-view-PtVIP context:any labels:c-any,o-view,ot-schema,on-PtVIP,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtVIP
CREATE OR ALTER VIEW dbo.PtVIP AS
SELECT  PtBase.Id,
PtBase.HdCreateDate,
PtBase.HdCreator,
PtBase.HdChangeDate,
PtBase.HdChangeUser,
PtBase.HdEditStamp,
PtBase.HdVersionNo,
PtBase.HdProcessId,
PtBase.HdStatusFlag,
PtBase.HdNoUpdateFlag,
PtBase.HdPendingChanges,
PtBase.HdPendingSubChanges,
PtBase.HdTriggerControl,
PtBase.PartnerNoEdited, PtBase.BusinessTypeCode, PtBase.FirstName, PtBase.Name, PtBase.NameCont, 
PtBase.DateOfBirth, PtBase.ConsultantTeamName
FROM  PtBase INNER JOIN PtSymbol ON PtBase.Id = PtSymbol.PartnerId
WHERE (PtSymbol.SymbolType = 'VIP')
