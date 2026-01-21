--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPartnerInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPartnerInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPartnerInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSPartnerInfo
@PartnerId UniqueIdentifier As
DECLARE @refCur char(3)
DECLARE @CurCount int

	Select @CurCount = count(distinct Currency) from PtPortfolio
	Where PartnerId = @PartnerId and Currency is not null

	IF @CurCount = 1
		Select distinct @refCur = Currency from PtPortfolio
		Where PartnerId = @PartnerId


	Select top 1 @refCur as RefCurrency,PtBase.PartnerNo,
                            PtBase.PartnerNoEdited,PtBase.Name,PtBase.FirstName,PtBase.SexStatusNo, 
                            PtAddress.PreferredLanguageNo,PtAddress.Street, PtAddress.Town, PtAddress.Zip, PtAddress.HouseNo,
                            PtAddress.CountryCode as AddressCountryCode, AdrCountryTxt.TextShort AddressCountry, 
                            PtNationality.CountryCode as NatCountryCode,PtFiscalCountry.CountryCode as FiscalCountryCode, PtBase.LegalStatusNo, PtBase.DateOfBirth,
                            PtBase.OpeningDate, PtPhoneNumber.PhoneNumber, PhB.PhoneNumber as  PhoneBusiness,
                            PhP.PhoneNumber as  PhonePrivate, FaxB.PhoneNumber as FaxBusiness,EPriv.EmailAddress as EmailPrivate, 
                            Ebus.EmailAddress as EmailBusiness, Master.PartnerNo as MasterPartnerNo, AsLanguage.PMSLanguageNo,nameinfo.NamePart1, nameinfo.NamePart2 from PtBase
                            inner join PtAddress on PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
                            left outer join AsCountry AdrCountry on PtAddress.CountryCode = AdrCountry.ISOCode
                            left outer join PtNationality on PtNationality.PartnerId = PtBase.Id and PtNationality.HdVersionNo between 1 and 999999998 and PtNationality.HdCreateDate =
                            (Select min(HdCreatedate) from PtNationality PTN where PTN.PartnerId = PtBase.Id and PTN.HdVersionNo between 1 and 999999998)
                            left  outer join AsText AdrCountryTxt on AdrCountryTxt.MasterId = AdrCountry.Id and isnull(PtAddress.PreferredLanguageNo,2) = AdrCountryTxt.LanguageNo
                            left  outer join PtFiscalCountry on PtBase.Id = PtFiscalCountry.PartnerId and PtFiscalCountry.IsPrimaryCountry = 1
                            left  outer join PtPhoneNumber PhB on PtBase.Id = PhB.PartnerId  and PhB.PhoneNumberTypeNo = 2
                            left  outer join PtPhoneNumber PhP on PtBase.Id = PhP.PartnerId  and PhP.PhoneNumberTypeNo = 5
                            left  outer join PtPhoneNumber  on PtBase.Id = PtPhoneNumber.PartnerId and PtPhoneNumber.PhoneNumberTypeNo = 1
                            left  outer join PtPhoneNumber FaxB on PtBase.Id = FaxB.PartnerId and FaxB.PhoneNumberTypeNo = 13
                            left  outer join PtEmailAddress EPriv on PtBase.Id = EPriv.PartnerId and EPriv.EmailAddressTypeNo = 1
                            left  outer join PtEmailAddress EBus on PtBase.Id = EBus.PartnerId and EBus.EmailAddressTypeNo = 2
			    left  outer join AsLanguage on PtAddress.PreferredLanguageNo = AsLanguage.LanguageNo	
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
left outer join PtRelationMaster on PtRelationSlave.MasterId = PtRelationMaster.Id
left outer join PtBase Master on Master.Id = PtRelationMaster.PartnerId
CROSS APPLY GetNameInfoForPMS(PtBase.PartnerNo) nameinfo

Where PtBase.Id =  @PartnerId


