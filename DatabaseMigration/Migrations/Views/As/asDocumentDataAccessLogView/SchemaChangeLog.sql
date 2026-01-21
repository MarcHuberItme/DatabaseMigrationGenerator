--liquibase formatted sql

--changeset system:create-alter-view-asDocumentDataAccessLogView context:any labels:c-any,o-view,ot-schema,on-asDocumentDataAccessLogView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view asDocumentDataAccessLogView
CREATE OR ALTER VIEW dbo.asDocumentDataAccessLogView AS

SELECT AL.ID
, AL.AsDocumentDataId
, D.Id as AsDocumentId
, AL.UserName
, AL.AccessDateTime
, AL.SignStatusNo
, AL.CheckResult
, D.PartnerId
, D.PortfolioId
, D.AccountBaseId
, D.VirtualDate
, B.PartnerNoEdited
, B.Name
, B.FirstName
, T.TextShort as DocumentType
, DC.Comment
, AL.HdPendingChanges
, AL.HdPendingSubChanges
, AL.HdVersionNo
, AL.HdProcessId
, AL.HdCreateDate
, AL.HdChangeDate
, AL.HdEditStamp
, AL.HdCreator
, AL.HdChangeUser
FROM			asDocumentDataAccessLog AL
Inner Join		asDocumentData DD on DD.ID = AL.AsDocumentDataId
Inner Join		asDocument D on D.Id = DD.DocumentId
Left Outer Join ptBase B on B.Id = D.PartnerId
Left Outer Join asDocumentComment DC on DC.DocumentId = D.ID
Left Outer Join asCorrItem CI on CI.ID = D.Type
Left Outer Join asText T on T.MasterId = CI.Id and LanguageNo = 2
