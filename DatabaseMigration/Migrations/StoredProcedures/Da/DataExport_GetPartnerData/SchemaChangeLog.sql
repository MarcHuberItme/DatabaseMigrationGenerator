--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetPartnerData context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetPartnerData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetPartnerData
CREATE OR ALTER PROCEDURE dbo.DataExport_GetPartnerData
@AddressId uniqueidentifier AS
  
Declare @AdresseDarstellung INT
Declare @Anrede nvarchar(20)
Declare @BriefAnrede nvarchar(100)
Declare @Gebdatum datetime
Declare @Land nvarchar(32)
Declare @Name1 nvarchar(70)
Declare @Name2 nvarchar(70)
Declare @Nationalität nvarchar(50)
Declare @Ort nvarchar(50)
Declare @PartnerNummer nvarchar(20)
Declare @PLZ nvarchar(10)
Declare @Rechtsform int
Declare @Strasse nvarchar(50)
Declare @Typ nvarchar(10)
Declare @Zusatz nvarchar(50)

Declare @SexStatus int
Declare @CountryCode char(2)
Declare @CountryText nvarchar(50)
Declare @FirstName nvarchar(50)
Declare @Name nvarchar(40)
Declare @NameCont nvarchar(50)
Declare @MiddleName nvarchar(50)
Declare @MaidenName nvarchar(25)
Declare @UseMiddleName bit
Declare @ChangeNameOrder bit
Declare @LegalStatusNo As int
Declare @LegalStatusDate As datetime

Declare @PartnerId As Uniqueidentifier
Declare @LanguageNo As Int


SELECT @SexStatus = b.SexStatusNo, @BriefAnrede = a.FormalAddress, @GebDatum = b.DateOfBirth, @CountryCode = a.CountryCode, 
       @CountryText = t.TextShort, @FirstName = b.FirstName, @Name = b.name, @NameCont = b.NameCont,
       @MaidenName = b.MaidenName, @MiddleName = b.MiddleName, @UseMiddleName = b.UseMiddleName, @ChangeNameOrder = b.ChangeNameOrder,
       @Ort = a.Town, @PartnerNummer = b.PartnerNoEdited, @PLZ = a.Zip, @Strasse = a.Street + ' ' + a.HouseNo,
       @partnerId = b.Id, @LanguageNo = a.CorrespondenceLanguageNo, @LegalStatusNo = b.LegalStatusNo, @LegalStatusDate = b.LegalStatusDate
FROM PtAddress a
   JOIN PtBase b on b.Id = a.PartnerId
   LEFT OUTER JOIN AsCountry c on c.IsoCode = a.CountryCode
   LEFT OUTER JOIN AsText t on t.MasterId = c.Id and t.LanguageNo = a.CorrespondenceLanguageNo 
WHERE a.Id = @AddressId

Set @Anrede = CASE @SexStatus
   WHEN 1 THEN 'Frau'
   WHEN 2 THEN 'Herr'
   WHEN 5 THEN 'Herr und Frau'
   ELSE ''
END 

IF @CountryCode = 'CH'
    Set @Land = ''
ELSE
    Set @Land = @CountryText


IF @SexStatus = 1 OR @SexStatus = 2                -- Natürliche Einzelpersonen
BEGIN
    Set @Typ = 'NP'
    SELECT  @Name1 = dbo.DataExport_Buildname(@Name,@MaidenName,@ChangeNameOrder)
    SELECT  @Name2 = dbo.DataExport_BuildFirstName(@FirstName, @MiddleName, @UseMiddleName)
    SET @AdresseDarstellung = 0
END
ELSE
IF @SexStatus = 5                             -- Ehepaare
BEGIN
   SET @Typ = 'MP'
   SELECT  @Name1 = dbo.DataExport_Buildname(@Name,@MaidenName,@ChangeNameOrder)
   SET @Name2 = Replace(@FirstName,',' ,' und')
   SET @AdresseDarstellung = 1


   SET @Rechtsform = Case @LegalStatusNo
      WHEN 2  THEN 35         -- Ehepaar
      WHEN 20 Then 20         -- Erbengemeinschaft
      WHEN 32 Then 35         -- Einfache Gesellschaft
      WHEN 33 THEN 35         -- Paar
      WHEN 34 THEN 35         -- Einfache Gesellschaft
      WHEN 35 Then 35         -- registrierte Partnerschaft
      WHEN 36 THEN 35         -- registrierte Partnerschaft
      ELSE 12                 -- ELSE CASE is irrelevant for DocWiz
   END

   SET @GebDatum = (SELECT TOP 1 DateOfBirth FROM PtBase b
      Join PtRelationSlave s on s.PartnerId = b.Id
      Join PtRelationMaster m on m.Id = s.masterId
   WHERE m.PartnerId = @PartnerId
      And m.RelationTypeNo = 10
   ORDER BY PartnerNo)

END
ELSE
BEGIN
   SET @Typ = 'JP' 
   SET @Name1 = @Name
   SET @Name2 = @NameCont
   SET @AdresseDarstellung = 1
   SET @GebDatum = @LegalStatusDate     -- Gründungsdatum wird in ibis auf Geburtsdatum gemapped
   SET @Rechtsform = 32                 -- Juristische Person
END

Set @Briefanrede = Replace(@Briefanrede, Char(13), ',')
Set @Briefanrede = Replace(@Briefanrede, Char(10), ' ')


-- Get Nationalities
SELECT @Nationalität = dbo.DataExport_GetNationality(@PartnerId, @LanguageNo)

-- Return Results

SELECT @AdresseDarstellung As AdresseDarstellung, 
       @Anrede As Anrede,
       @BriefAnrede As BriefAnrede,
       'Normale Post' As ExtSped,
       '00' As ExtSpedCode,
       Convert(varchar(10),@Gebdatum,104) As Gebdatum,
       @Land As Land,
       @Name1 As Name1,
       @Name2 As Name2,
       @Nationalität As Nationalitaet,
       @Ort As Ort,
       @PartnerNummer As PartnerNummer,
       @PLZ As Plz,
       @Rechtsform As RechtsformCode,
       @Strasse As Strasse,
       @Typ As Typ,
       '' As Zusatz
