--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAnnuityBookingView context:any labels:c-any,o-view,ot-schema,on-PtAccountAnnuityBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAnnuityBookingView
CREATE OR ALTER VIEW dbo.PtAccountAnnuityBookingView AS
select PtBooking.*, PtAccBase.AccountNo, PtAccBase.AccountNoEdited, PtPartner.Id as PartnerId, PtPartner.PartnerNoEdited from 
    PtAccountAnnuityBooking PtBooking
inner join PtAccountBase PtAccBase on PtBooking.MortgageAccountId = PtAccBase.Id
inner join PtPortfolio PtPo on PtAccBase.PortfolioId = PtPo.Id
inner join PtBase PtPartner on PtPo.PartnerId = PtPartner.Id 
WHERE PtBooking.HdVersionNo BETWEEN 0 AND 999999998
