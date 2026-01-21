--liquibase formatted sql

--changeset system:create-alter-view-AsSwissTownPartView context:any labels:c-any,o-view,ot-schema,on-AsSwissTownPartView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsSwissTownPartView
CREATE OR ALTER VIEW dbo.AsSwissTownPartView AS
Select T.Id, 
 T.HdCreateDate, 
 T.HdCreator, 
 T.HdChangeDate, 
 T.HdChangeUser, 
 T.HdEditStamp, 
 T.HdVersionNo, 
 T.HdProcessId, 
 T.HdStatusFlag, 
 T.HdNoUpdateFlag, 
 T.HdPendingChanges, 
 T.HdPendingSubChanges, 
 T.HdTriggerControl, D.SwissTownNo,
 T.SwissTownPartNo, D.DistrictCode, 
 Case When D.DistrictCode Is Null Then X.TextShort 
  Else X.TextShort + ' / '+ DX.TextShort End As Description, X.LanguageNo
From AsSwissTownPart T Left Outer Join AsSwissCityDistrict D On D.BFSCode=T.SwissTownPartNo And D.HdVersionNo<999999999
	Left Outer Join AsText X On T.Id=X.MasterId 
	Left Outer Join AsText DX On D.Id=DX.MasterId And DX.LanguageNo=X.LanguageNo 
Where T.HdVersionNo<999999999




