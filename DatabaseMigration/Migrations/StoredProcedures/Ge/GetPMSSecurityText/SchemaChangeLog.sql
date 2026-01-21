--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityText context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityText,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityText
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityText
@PublicId UniqueIdentifier
AS
Select top 1 a.VdfInstrumentSymbol, a.Line1,a.Line2,a.Line3
from 
(
Select PUB.Id,
PUB.InstrumentTypeNo,
    PUB.IsinNo,
    PUB.NominalCurrency,
    PUB.VdfInstrumentSymbol,
    PUB.SecurityType,
    IsNull(Convert(varchar,PTE.Interest) + ' % ', '') as Percentage,
    Replace(
    Case 
		When InstrumentTypeNo in (1,8,12) then
			/*IsNull(Convert(varchar,PTE.Interest) + ' % ', '') +*/ Replace( IsNull(PTE.Preffix  , ''), '  ', ' ')
		when InstrumentTypeNo in (2,3,4,5,6,98,99)  then
			IsNull(PTE.Preffix  , '') + IsNull( ' ' + PIN.Name , '')
		when InstrumentTypeNo in (7,9)  then
			IsNull('  ' + PTE.Preffix , '') 
	End, '  ',' ')  as 'Line1',
	
	Replace(
    Case 
		When InstrumentTypeNo in (1,12) then
			 IsNull( PIN.Name + ' ', '') + IsNull(' ' + PTE.ValidityRange   , '')
		when InstrumentTypeNo in (2,3,4,6,98,99)  then
			IsNull(PTE.Suffix , '') 
		when InstrumentTypeNo in (7,8,9)  then
			IsNull( PIN.Name , '') + IsNull(PTE.Suffix , '') 
		When InstrumentTypeNo in (5) then
			IsNull(PTE.ValidityRange , '') + IsNull(PTE.Suffix , '') 
	End, '  ',' ')  as 'Line2',
	Case 
		When InstrumentTypeNo in (1,12) then
			Replace(IsNull(PTE.Suffix , '') ,'  ',' ')
		
	End  as 'Line3'
  from  PrPublic PUB 
LEFT OUTER JOIN PrPublicText PTE
   ON PUB.Id  = PTE.PublicId 
LEFT OUTER JOIN PtInstituteName PIN
   ON PUB.NamingPartnerId = PIN.PartnerId 
Where (PIN.LanguageNo IS NULL OR
               PTE.LanguageNo IS NULL OR
               (PTE.LanguageNo = PIN.LanguageNo and PTE.LanguageNo = 2))

and Pub.Id = @PublicId
 
) a
