--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetWiBe context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetWiBe,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetWiBe
CREATE OR ALTER PROCEDURE dbo.DataExport_GetWiBe
    @PartnerId uniqueidentifier,
    @LanguageNo int AS
SELECT  Convert(varchar(10),b.DateOfBirth,104) As Gebdatum, 
        a.Zip + ' ' +  a.Town As 'partnerWirtBerechtigt.PlzOrt',
        dbo.DataExport_BuildName(b.Name, b.MaidenName, b.ChangeNameOrder) As 'partnerWirtBerechtigt.Name1',
        dbo.DataExport_BuildFirstName(b.FirstName, b.MiddleName, b.UseMiddleName) As 'partnerWirtBerechtigt.Name2',
        dbo.DataExport_GetNationality(b.Id, @LanguageNo) As 'partnerWirtBerechtigt.Nationalitaet',
        a.Street + ' ' + a.HouseNo As 'partnerWirtBerechtigt.Strasse',
        'P' As wirtBerechtigt     
FROM PtBase b
   Join PtRelationSlave s on s.PartnerId = b.Id
   Join PtRelationMaster m on m.Id = s.masterId
   JOIN PtAddress a on a.PartnerId = b.Id and a.AddresstypeNo = 11
WHERE m.PartnerId = @PartnerId
   And m.RelationTypeNo = 20
ORDER BY PartnerNo

