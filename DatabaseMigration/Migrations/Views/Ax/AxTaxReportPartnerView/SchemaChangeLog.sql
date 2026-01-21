--liquibase formatted sql

--changeset system:create-alter-view-AxTaxReportPartnerView context:any labels:c-any,o-view,ot-schema,on-AxTaxReportPartnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AxTaxReportPartnerView
CREATE OR ALTER VIEW dbo.AxTaxReportPartnerView AS
Select Distinct XD.Id, B.Id As PartnerId, MO.PartnerNo, 10 As TariffTypeNo, 
CI.ItemNo, Convert(Date, MO.ScheduledDeliveryTime) As ReferenceDate, XD.DebitAccountId, XD.ChargeRebate, 
Case When X.ValidFrom<XD.ValidFrom Then XD.ValidFrom Else X.ValidFrom End As ValidFrom,
Case When X.ValidTo Is Null Then XD.ValidTo 
     When X.ValidTo Is Not Null And XD.ValidTo Is Null Then X.ValidTo 
     When X.ValidTo>XD.ValidTo Then XD.ValidTo Else X.ValidTo End As ValidTo,
Cast(Case When CC.CountryCode= 'CH' Or CC.CountryCode='LI' Then 1 Else 0 End As bit) As IsDomestic, 
Cast(Case When E.PartnerID Is Null Then 0 Else 1 End As bit) As IsEmployee, E.HasStaffRebate 
From AsMailOutput MO Join PtBase B On MO.PartnerNo=B.PartnerNo 
Left Outer Join PtPortfolio O On O.PartnerId=B.Id And O.HdVersionNo<999999999 And O.TerminationDate Is Null 
Join PtFiscalCountry CC On CC.PartnerID=B.ID And CC.IsPrimaryCountry=1 And CC.HdVersionNo<999999999 
Left Outer Join PtUserBase E On B.ID=E.PartnerID And (E.LeavingDate Is Null Or E.LeavingDate>getDate()) 
Join AsDocumentData DD On MO.DocumentDataId=DD.Id And DD.HdVersionNo<999999999 And DD.StatusNo>1 
Join AiTaxStatus X On B.Id=X.PartnerId And X.TaxProgramNo =10900 
Join AxTaxDetailATX XD On XD.TaxStatusId=X.Id 
Join AxTaxDetailATXType XT On XD.TaxDetailATXTypeNo=XT.TaxDetailATXTypeNo 
Join AsCorrItem CI On XT.CorrItemId=CI.Id 
Where MO.HdVersionNo < 999999999 And B.HdVersionNo < 999999999
   And DD.HdVersionNo <999999999 And X.HdVersionNo <999999999   
   And XD.HdVersionNo <999999999 And XT.HdVersionNo <999999999   
   And CI.HdVersionNo <999999999   
   And B.TerminationDate Is Null And O.Id Is Not Null 
