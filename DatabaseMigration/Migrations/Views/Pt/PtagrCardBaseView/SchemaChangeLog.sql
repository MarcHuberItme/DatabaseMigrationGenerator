--liquibase formatted sql

--changeset system:create-alter-view-PtagrCardBaseView context:any labels:c-any,o-view,ot-schema,on-PtagrCardBaseView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtagrCardBaseView
CREATE OR ALTER VIEW dbo.PtagrCardBaseView AS
SELECT  B.Id, 
                B.HdCreateDate, 
                B.HdCreator, 
                B.HdChangeDate, 
                B.HdChangeUser,
                B.HdEditStamp,
                B.HdVersionNo,
                B.HdProcessId, 
                B.HdStatusFlag,
                B.HdNoUpdateFlag,
                B.HdPendingChanges, 
                B.HdPendingSubChanges,
                B.HdTriggerControl,      
	B.CardNo,
	B.CardType,
	B.PartnerId,
	B.ContactPersonId,
	B.AccountId,
	A.AccountNoEdited,
                P.PartnerNoEdited,
                P.Name,
                P.FirstName,
	B.BeginDate,
	B.ExpirationDate
FROM PtAgrCardBase As B
INNER JOIN PtAccountBase As A ON B.AccountId = A.Id
INNER JOIN PtPortfolio As O ON O.Id = A.PortfolioId
INNER JOIN PtBase As P ON P.Id = O.PartnerId

