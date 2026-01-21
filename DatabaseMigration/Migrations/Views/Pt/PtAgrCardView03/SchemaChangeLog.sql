--liquibase formatted sql

--changeset system:create-alter-view-PtAgrCardView03 context:any labels:c-any,o-view,ot-schema,on-PtAgrCardView03,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrCardView03
CREATE OR ALTER VIEW dbo.PtAgrCardView03 AS
SELECT TOP 100 PERCENT acb.Id , acb.HdCreateDate , acb.HdCreator , acb.HdChangeDate , acb.HdChangeUser 
	, acb.HdEditStamp , acb.HdVersionNo , acb.HdProcessId , acb.HdStatusFlag 
	, acb.HdNoUpdateFlag , acb.HdPendingChanges , acb.HdPendingSubChanges 
	, acb.HdTriggerControl , acb.PartnerId , acb.ContactPersonId , acb.AccountId  
	, acb.CardType , acb.CardNo , acb.VersionNo , acb.PrintDate , acb.BeginDate 
	, acb.PeriodOfNotice , acb.TimeInterval , acb.Remark , acb.AuthorizationNo
	, acb.LastChargeDate , acb.ChargePrintDate , acb.CardNoNew ,  acb.CardTransferDate , pac.Id AS AgrCardId
	, pav.AccountNoEdited , pav.PartnerNoEdited , pav.Name , pav.FirstName 
	, pac.IssueDate , pac.ExpirationDate , pac.SerialNo , pac.CardStatus, acb.CardExtendedInformation, acb.IsPhysicalCard
FROM PtAgrCardBase acb
LEFT OUTER JOIN PtAgrCard pac ON pac.CardId = acb.Id  AND pac.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN PtAccountView pav ON acb.AccountId = pav.Id
	
