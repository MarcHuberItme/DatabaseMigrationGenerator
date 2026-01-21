--liquibase formatted sql

--changeset system:create-alter-view-PtAgrSafeDepositView context:any labels:c-any,o-view,ot-schema,on-PtAgrSafeDepositView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrSafeDepositView
CREATE OR ALTER VIEW dbo.PtAgrSafeDepositView AS
SELECT
	a.Id,
	a.HdCreateDate,
	a.HdCreator,
	a.HdChangeDate,
	a.HdEditStamp,
	a.HdVersionNo,
	a.HdProcessID,
	a.HdStatusFlag,
	a.HdNoUpdateFlag,
	a.HdPendingChanges, 
	a.HdPendingSubChanges, 
	a.HdTriggerControl,
	p.ID As PartnerID,
	p.PartnerNoEdited,
	p.FirstName,
	p.Name,
	p.NameCont,
	p.SexStatusNo,
	p.DateOfBirth,
 		str(p.PartnerNo,6)+ ' ' + IsNull(p.FirstName + ' ','') + IsNull(p.Name,'') PtDescription,
	a.BeginDate,
	Case When a.ExpirationDate Is Null Then p.terminationDate Else a.ExpirationDate End As ExpirationDate,
	a.DebitAccountId,
	a.SafeDepositBoxId,
	d.DepositDescription
FROM PtAgrSafeDepositBox a Inner Join PtBase p On a.PartnerId = p.Id
	Inner Join PrSafeDepositView d on a.SafeDepositBoxId=d.ID
