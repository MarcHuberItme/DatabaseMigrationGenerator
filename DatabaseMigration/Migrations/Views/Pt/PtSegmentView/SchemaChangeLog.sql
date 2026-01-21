--liquibase formatted sql

--changeset system:create-alter-view-PtSegmentView context:any labels:c-any,o-view,ot-schema,on-PtSegmentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSegmentView
CREATE OR ALTER VIEW dbo.PtSegmentView AS
 SELECT 
 PtSegment.Id,
 AsText.TextShort,
 PtSegment.SegmentNo,
 AsText.LanguageNo
 FROM PtSegment
 INNER JOIN AsText ON PtSegment.Id = AsText.MasterId
 WHERE PtSegment.HdVersionNo<999999999
