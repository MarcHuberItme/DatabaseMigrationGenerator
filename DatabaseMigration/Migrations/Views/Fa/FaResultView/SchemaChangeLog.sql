--liquibase formatted sql

--changeset system:create-alter-view-FaResultView context:any labels:c-any,o-view,ot-schema,on-FaResultView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view FaResultView
CREATE OR ALTER VIEW dbo.FaResultView AS
SELECT 
       v.PartnerNo, 
       v.PtDescription,
       MaxTotalBalanceUSD,
	   MaxOwnBalanceUSD, 
	   bal.OwnBalanceUSD,
       ISNULL(s.IsUsCiticen, b.IsUsCiticen) As IsUsCiticen,
       ISNULL(s.HasUsDomicile, b.HasUsDomicile) As HasUsDomicile, 
       ISNULL(s.HasUsAddress, b.HasUsAddress) As  HasUsAddress,
       ISNULL(s.MailsToUsAddress, b.MailsToUsAddress) As MailsToUsAddress,
       ISNULL(s.HasUsPhoneNumber, b.HasUsPhoneNumber) As HasUsPhoneNumber,
       ISNULL(s.StandingInstructions, b.StandingInstructions) As StandingInstructions,
       ISNULL(s.GrantsToUsAddress, b.GrantsToUsAddress) As GrantsToUsAddress,
       ISNULL(s.InCareOf_Inside, b.InCareOf_Inside) As InCareOf_Inside,
       ISNULL(s.InCareOf_Outside, b.InCareOf_Outside) As InCareOf_Outside,
       ISNULL(s.OnlyHoldMail, b.OnlyHoldMail) As OnlyHoldMail,
       ISNULL(s.UsBasket, b.UsBasket) As UsBasket,
       RmInquiryUsAccount,
       OtherIndicia,
       UsCiticenOverride,
       UsDomicileOverride,
       b.OpeningDate,
       b.ClosingDate,
       b.OpeningPeriod,
       ISNULL(s.HasW9, b.HasW9) As HasW9,
       adr.FullAddress,
       adr.CountryCode As MainDomicile,
       bas.ConsultantTeamName,
       tu.TextShort,
       b.HasIndicia,
       b.HasRelatedUsAccounts,
       b.NonUs_DBA,
       b.IsUsRelatedAccount,
       b.Id As FaBaseId
       
FROM  FaBase b 
    JOIN PtDescriptionView v on v.Id = b.PartnerId
    JOIN PtBase bas on bas.ID = v.Id
    JOIN PtAddress adr on adr.PartnerId = v.Id and adr.AddressTypeNo = 11
    LEFT OUTER JOIN FaManualSearch s on s.FaBaseId = b.Id and s.HdVersionNo < 999999999
    Left Outer JOIN FaBalance bal on bal.FaBaseId = b.Id and bal.ValuationDate = '20131231'
    Left Outer JOIN AsUserGroup g on g.UserGroupName = bas.ConsultantTeamName
    LEFT outer join AsText tu on tu.MasterId = g.Id and tu.LanguageNo = 2
   
WHERE b.IsUsRelatedAccount = 1
and b.NonUsStatusApproved = 0

