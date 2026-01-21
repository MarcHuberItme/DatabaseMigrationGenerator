--liquibase formatted sql

--changeset system:create-alter-view-AcPartnerAccountsOwn context:any labels:c-any,o-view,ot-schema,on-AcPartnerAccountsOwn,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcPartnerAccountsOwn
CREATE OR ALTER VIEW dbo.AcPartnerAccountsOwn AS
Select PtAccountBase.HdVersionNo, PtAccountBase.AccountNo, PtAccountBase.AccountNoText, PtAccountBase.AccountNoEdited, PtAccountBase.AccountNoIbanForm, 
           PtAccountBase.CustomerReference, PtAccountBase.OpeningDate, PtAccountBase.MotiveToOpenNo From PtAccountBase
Where AccountNo >= 900000000
And PtAccountBase.HdVersionNo Between 1 And 999999998
