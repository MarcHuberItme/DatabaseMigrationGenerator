--liquibase formatted sql

--changeset system:create-alter-view-CoBaseAssignCreditView context:any labels:c-any,o-view,ot-schema,on-CoBaseAssignCreditView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoBaseAssignCreditView
CREATE OR ALTER VIEW dbo.CoBaseAssignCreditView AS
Select BA.ID, BA.HdCreateDate, BA.HdCreator, BA.HdChangeDate,
 BA.HdChangeUser, BA.HdEditStamp, BA.HdVersionNo, BA.HdProcessId,
 BA.HdStatusFlag, BA.HdNoUpdateFlag, BA.HdPendingChanges, BA.HdPendingSubChanges,
 BA.CollateralId, B.PortfolioId, B.ObligationId, B.AccountId, B.Insurancepolice, B.OwnerId As CollPartnerId, B.CollSubType, B.CollNo, B.ExtKey, B.Description, 
 Case When BA.AssignNullValue=0 Then 'N' Else 'Y' End As AssignNullValue, BA.MaxAllocAmount,
 A.Id As CreditAccountId, A.AccountNoEdited As CreditAccountNoEdited, A.AccountNo  As CreditAccountNo, A.PrioCredit,
 O.PartnerId As CreditPartnerId, V.PtDescription As OwnerDesc, VC.PtDescription As CreditDesc, BA.InactFlag
From CoBase B Join CoBaseAss BA On B.Id=BA.CollateralId And B.HdVersionNo<999999999 And BA.HdVersionNo Between 1 And 999999998
Join PtAccountBase A On BA.AccountId=A.Id And A.HdVersionNo<999999999
Join PtPortfolio O On A.PortfolioId=O.Id And O.HdVersionNo<999999999 And O.TerminationDate Is Null
Join PtBase CB On O.PartnerId=CB.Id And CB.HdVersionNo<999999999 And CB.TerminationDate Is Null
Join PtDescriptionView V On V.Id=B.OwnerId
Join PtDescriptionView VC On VC.Id=CB.Id
