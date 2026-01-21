--liquibase formatted sql

--changeset system:create-alter-view-PtAgrCardView02 context:any labels:c-any,o-view,ot-schema,on-PtAgrCardView02,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrCardView02
CREATE OR ALTER VIEW dbo.PtAgrCardView02 AS
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
	C.IssueDate,
	C.ExpirationDate,
                C.SerialNo,
                C.CardStatus
FROM PtAgrCardBase As B
LEFT OUTER JOIN PtAgrCard As C ON C.CardId = B.Id
INNER JOIN PtAccountBase As A ON B.AccountId = A.Id
INNER JOIN PtPortfolio As O ON A.PortfolioId = O.Id
INNER JOIN PtBase As P ON O.PartnerId = P.Id
