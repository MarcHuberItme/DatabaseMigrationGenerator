--liquibase formatted sql

--changeset system:create-alter-view-PtCounterPartyView context:any labels:c-any,o-view,ot-schema,on-PtCounterPartyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCounterPartyView
CREATE OR ALTER VIEW dbo.PtCounterPartyView AS

SELECT Id, HdCreator, HdChangeUser, HdCreateDate, HdChangeDate, HdEditStamp, HdPendingChanges, HdPendingSubChanges, HdProcessId, HdVersionNo, 
ArCode AS LargeExpGroupNo, BankName AS Description
FROM AcBankCounterparty
WHERE HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT Id, HdCreator, HdChangeUser, HdCreateDate, HdChangeDate, HdEditStamp, HdPendingChanges, HdPendingSubChanges, HdProcessId, HdVersionNo, 
CONVERT(varchar(12),PartnerNo), Name
FROM PtBase AS Pt
WHERE Pt.Name like 'KGR %' AND ServiceLevelNo = 10
AND Pt.HdVersionNo BETWEEN 1 AND 999999998 
AND TerminationDate IS NULL
