--liquibase formatted sql

--changeset system:create-alter-view-PtAgrEBankingSearchView context:any labels:c-any,o-view,ot-schema,on-PtAgrEBankingSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrEBankingSearchView
CREATE OR ALTER VIEW dbo.PtAgrEBankingSearchView AS
select agr.Id AgreementId
     , p.PartnerNo PartnerNumber
     , p.Id PartnerId
     , agr.BeginDate ValidFrom
     , agr.AcceptanceDate
     , agr.ExpirationDate ValidTo
     , agr.MgVTNo AgreementNumber
     , agr.SeqNo SequenceNumber
     , agr.IsBLinkAllowed IsBLinkAllowed
     , agr.BLinkTermsConditionsAcceptedAt BLinkTermsConditionsAcceptedAt
     , agr.InstantDomesticPaymentsAllowed InstantDomesticPaymentsAllowed
     , agr.Remark Remark
     , agr.InternetbankingAllowed IsInternetBankingAllowed
     , agr.AGBacceptedByCustomer AGBAcceptedByCustomerDateTime
     , agr.HdVersionNo HdVersionNo
from PtAgrEbanking agr
         join PtBase p on p.Id = agr.PartnerId
