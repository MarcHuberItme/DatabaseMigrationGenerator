--liquibase formatted sql

--changeset system:create-alter-view-ReNoteView context:any labels:c-any,o-view,ot-schema,on-ReNoteView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReNoteView
CREATE OR ALTER VIEW dbo.ReNoteView AS
SELECT TOP 100 PERCENT
	RN.Id,
	RN.HdCreateDate, 
	RN.HdEditStamp,
	RN.HdStatusFlag, 
	RN.HdPendingChanges, 
	RN.HdPendingSubChanges, 
	RN.HdVersionNo,
	RN.HdProcessId,
        RN.PremisesId,
        RN.NoteTypeNo,
        RN.Currency,
        CASE RN.NoteTypeNo
	   WHEN 4 THEN (SELECT SUM(ReBelong.ValueAmount) FROM ReBelong WHERE ReBelong.NoteId = RN.Id AND ReBelong.HdVersionNo < 999999999)
	   WHEN 5 THEN (SELECT SUM(ReCoProperty.Amount) FROM ReCoProperty WHERE ReCoProperty.NoteId = RN.Id AND ReCoProperty.HdVersionNo < 999999999)
	   ELSE RN.Amount
        END As Amount,
        RN.ForValuation,
        RN.Remark
FROM ReNote As RN

